//
//  PostDetailsViewModel.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 19/04/2024.
//

import Foundation

class PostDetailsViewModel: ObservableObject {
    @Published var commentText: String = ""
    @Published var comments: [Comment] = []
    @Published var likes: [String] = []
    @Published var isLoading = false
    var hasFetched = false
    var post: Post
    
    init(post: Post) {
        self.post = post
    }
    
    func refreshData() {
        fetchLikes()
        fetchComments()
    }
    
    func hasLiked() -> Bool {
        guard let currentUser = UserManager.shared.currentUser else {
            return false
        }
        return likes.contains(where: { $0 == currentUser.id })
    }
    
    func addLike() {
        guard let currentUser = UserManager.shared.currentUser else {
            // handle error
            return
        }
        AppDelegate.db.collection(CollectionPath.postsImpressions.rawValue).document(post.id).collection(CollectionPath.Subcollections.likes.rawValue).document(currentUser.id).setData(["id": currentUser.id])
        isLoading = false
        refreshData()
    }
    
    func addComment() {
        guard commentText != "", let currentUser = UserManager.shared.currentUser else {
            // handle error
            return
        }
        let comment = Comment(id: UUID().uuidString, contentText: commentText, date: Date().formatted(), author: currentUser)
        isLoading = true
        do {
            try AppDelegate.db.collection(CollectionPath.postsImpressions.rawValue).document(post.id).collection(CollectionPath.Subcollections.comments.rawValue).addDocument(from: comment)
            commentText = ""
            isLoading = false
            refreshData()
        } catch {
            // handle error
            isLoading = false
        }
    }
    
    func fetchComments() {
        isLoading = true
        AppDelegate.db.collection(CollectionPath.postsImpressions.rawValue).document(post.id).collection(CollectionPath.Subcollections.comments.rawValue).getDocuments { [weak self] snapshot, error in
                self?.hasFetched = true
                self?.isLoading = false
                if let documents = snapshot?.documents {
                    var decodedComments: [Comment] = []
                    for document in documents {
                        guard let comment = try? document.data(as: Comment.self) else {
                            // error
                            return
                        }
                        decodedComments.append(comment)
                    }
                    decodedComments.sort(by: { DateFormatter.firestoreDateFormatter.date(from: $0.date) ?? Date() > DateFormatter.firestoreDateFormatter.date(from: $1.date) ?? Date() })
                    self?.comments = decodedComments
                }
        }
    }
    
    func fetchLikes() {
        AppDelegate.db.collection(CollectionPath.postsImpressions.rawValue).document(post.id).collection(CollectionPath.Subcollections.likes.rawValue).getDocuments { [weak self] snapshot, error in
            if let documents = snapshot?.documents {
                var likesCount: [String] = []
                for document in documents {
                    likesCount.append(document.documentID)
                }
                self?.likes = likesCount
            }
        }
    }
}
