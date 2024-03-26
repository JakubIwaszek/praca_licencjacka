//
//  HomePageViewModel.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 19/01/2024.
//

import Foundation
import Combine

class HomePageViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = false
    var hasFetched = false
    private var cancellables = Set<AnyCancellable>()
    
    func setupNotification() {
        NotificationCenter.default.publisher(for: Notification.Name("addedPost"))
            .receive(on: RunLoop.main)
            .sink { _ in
                self.fetchAllPosts()
            }
            .store(in: &cancellables)
    }
    
    func fetchAllPosts() {
        isLoading = true
        AppDelegate.db.collection(CollectionPath.posts.rawValue).getDocuments { [weak self] querySnapshot, error in
            self?.hasFetched = true
            self?.isLoading = false
            if let documents = querySnapshot?.documents {
                var decodedPosts: [Post] = []
                for document in documents {
                    guard let post = try? document.data(as: Post.self) else {
                        // error
                        return
                    }
                    decodedPosts.append(post)
                }
                decodedPosts.sort(by: { DateFormatter.firestoreDateFormatter.date(from: $0.date) ?? Date() > DateFormatter.firestoreDateFormatter.date(from: $1.date) ?? Date() })
                self?.posts = decodedPosts
            }
        }
    }
}
