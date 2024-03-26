//
//  UserManager.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 19/01/2024.
//

import Foundation

class UserManager {
    static let shared = UserManager()
    var currentUser: User?
    var following: [String] = []
    
    func setupUser(with user: User) {
        currentUser = user
        fetchFollowingList()
    }
    
    func fetchFollowingList() {
        guard let currentUser = UserManager.shared.currentUser else {
            return
        }
        AppDelegate.db.collection(CollectionPath.userFollowing.rawValue).document(currentUser.id).getDocument { [weak self] snapshot, error in
            if let ids = snapshot?.data()?["ids"] as? [String] {
                self?.following = ids
            }
        }
    }
    
    func removeUser() {
        currentUser = nil
        following = []
    }
}
