//
//  AddNewPostViewModel.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 19/01/2024.
//

import Foundation
import FirebaseFirestore

class AddNewPostViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var alert = AlertMessage(message: "")
    @Published var postText = "What's happening?"
    
    func addNewPost() {
        isLoading = true
        // prepare post data
        guard let postData = preparePostData() else {
            isLoading = false
            self.alert.setup(isPresented: true, message: "Something went wrong...")
            return
        }
        do {
            try AppDelegate.db.collection(CollectionPath.posts.rawValue).document(postData.id).setData(from: postData) { [weak self] error in
                if let error = error {
                    self?.alert.setup(isPresented: true, message: error.localizedDescription)
                    self?.isLoading = false
                } else {
                    AppDelegate.db.collection(CollectionPath.userPosts.rawValue).document(postData.user.id).setData(["ids": FieldValue.arrayUnion([postData.id])], merge: true) { error in
                        self?.isLoading = false
                        if let error = error {
                            self?.alert.setup(isPresented: true, message: error.localizedDescription)
                        } else {
                            self?.alert.setup(isPresented: true, message: "Post has been added", shouldDismissView: true)
                        }
                    }
                }
            }
        }
        catch {
            isLoading = false
            alert.setup(isPresented: true, message: "Something went wrong...")
        }
    }
    
    func preparePostData() -> Post? {
        guard let user = UserManager.shared.currentUser else {
            return nil
        }
        let post = Post(id: UUID().uuidString, contentText: postText, date: Date().formatted(), user: user)
        return post
    }
}
