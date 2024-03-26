//
//  UserAccountPageViewModel.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 19/01/2024.
//

import Foundation

@MainActor
class UserAccountPageViewModel: ObservableObject {
    @Published var userPosts: [Post] = []
    var user = UserManager.shared.currentUser
    var isLoading = true
    
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
    
    func logout(with root: RootManager) {
        UserManager.shared.removeUser()
        root.currentRoot = .authentication
    }
}
