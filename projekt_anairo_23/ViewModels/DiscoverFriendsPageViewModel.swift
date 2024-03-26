//
//  DiscoverFriendsPageViewModel.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 20/01/2024.
//

import Foundation
import FirebaseFirestore

class DiscoverFriendsPageViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var alert = AlertMessage(message: "")
    @Published var isLoading = false
    var hasFetched = false
    
    func fetchAllUsers() {
        UserManager.shared.fetchFollowingList()
        isLoading = true
        AppDelegate.db.collection(CollectionPath.users.rawValue).getDocuments { [weak self] snapshot, error in
            self?.hasFetched = true
            self?.isLoading = false
            var decodedUsers: [User] = []
            if let documents = snapshot?.documents {
                for document in documents {
                    if let user = try? document.data(as: User.self) {
                        if !user.id.elementsEqual(UserManager.shared.currentUser?.id ?? "") {
                            decodedUsers.append(user)
                        }
                    }
                }
                self?.users = decodedUsers
            } else {
                self?.alert.setup(isPresented: true, message: error?.localizedDescription ?? "Something went wrong...")
            }
        }
    }
    
    func addNewFriend(userId: String) {
        guard let currentUser = UserManager.shared.currentUser else {
            self.alert.setup(isPresented: true, message: "Something went wrong...")
            return
        }
        isLoading = true
        AppDelegate.db.collection(CollectionPath.userFollowing.rawValue).document(currentUser.id).setData(["ids": FieldValue.arrayUnion([userId])], merge: true) { [weak self] error in
            self?.isLoading = false
            if let error = error {
                self?.alert.setup(isPresented: true, message: error.localizedDescription)
            } else {
                self?.alert.setup(isPresented: true, message: "You are following this user now.")
            }
        }
    }
}
