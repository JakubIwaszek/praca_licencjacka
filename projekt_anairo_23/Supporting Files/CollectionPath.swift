//
//  CollectionPath.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 19/01/2024.
//

import Foundation

enum CollectionPath: String {
    case users = "users"
    case posts = "posts"
    case postsImpressions = "post-impressions"
    case userPosts = "user-posts"
    case userFollowing = "user-following"
    
    enum Subcollections: String {
        case comments = "comments"
        case likes = "likes"
    }
}
