//
//  UserAccountPageViewModel.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 19/01/2024.
//

import Foundation
import SwiftUI
import PhotosUI

@MainActor
class UserAccountPageViewModel: ObservableObject {
    @Published var userPosts: [Post] = []
    @Published var isLoading = true
    @Published var profileImageState: ImageState = .empty
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            if let imageSelection {
                let progress = imageSelection.loadTransferable { [weak self] imageData in
                    if let imageData = imageData {
                        self?.saveUserImage(imageData: imageData) { [weak self] success in
                            if success, let uiImage = UIImage(data: imageData) {
                                self?.profileImageState = .success(Image(uiImage: uiImage))
                            } else {
                                // handle error
                            }
                        }
                    } else {
                        self?.profileImageState = .failure
                    }
                }
                profileImageState = .loading(progress)
            } else {
                profileImageState = .empty
            }
        }
    }
    var user = UserManager.shared.currentUser
    
    func loadUserPosts() async {
        UserManager.shared.fetchFollowingList()
        do {
            if let posts = try await self.fetchUserPosts() {
                isLoading = false
                userPosts = posts
            } else {
                isLoading = false
                objectWillChange.send()
            }
        } catch {
            isLoading = false
            objectWillChange.send()
        }
    }
    
    func fetchUserPosts() async throws -> [Post]? {
        guard let user = user else {
            return nil
        }
        guard let postsIds = try? await AppDelegate.db.collection(CollectionPath.userPosts.rawValue).document(user.id).getDocument().data()?["ids"] as? [String] else {
            return nil
        }
        var decodedPosts: [Post] = []
        for postId in postsIds {
            if let post = try? await AppDelegate.db.collection(CollectionPath.posts.rawValue).document(postId).getDocument(as: Post.self) {
                decodedPosts.append(post)
            }
        }
        decodedPosts.sort(by: { DateFormatter.firestoreDateFormatter.date(from: $0.date) ?? Date() > DateFormatter.firestoreDateFormatter.date(from: $1.date) ?? Date() })
        return decodedPosts
    }
    
    func refreshUserImage() async {
        profileImageState = .loading(Progress())
        UserManager.shared.fetchUserImage { [weak self] data in
            if let imageData = data, let uiImage = UIImage(data: imageData) {
                self?.profileImageState = .success(Image(uiImage: uiImage))
            } else {
                self?.profileImageState = .empty
            }
        }
    }
    
    func saveUserImage(imageData: Data, completion: @escaping (Bool) -> Void) {
        guard let currentUser = UserManager.shared.currentUser else {
            completion(false)
            return
        }
        let newImageRef = AppDelegate.storage.reference().child("images/user-\(currentUser.id)")
        newImageRef.putData(imageData, metadata: nil) {result in
            switch result {
            case .success(_):
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    func logout(with root: RootManager) {
        UserManager.shared.removeUser()
        root.currentRoot = .authentication
    }
}
