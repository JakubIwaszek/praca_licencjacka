//
//  Post.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 24/11/2023.
//

import Foundation

struct Post: Identifiable, Codable {
    var id: String
    var contentText: String
    var date: String
    var user: User
    var imageUrl: String?
}
