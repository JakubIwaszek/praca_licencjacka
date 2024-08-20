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
    var imageData: Data?
    
    init(id: String, contentText: String, date: String, user: User, imageData: Data? = nil) {
        self.id = id
        self.contentText = contentText
        self.date = date
        self.user = user
        self.imageData = imageData
    }
    
    init(id: String, contentText: String, date: String, user: User) {
        self.id = id
        self.contentText = contentText
        self.date = date
        self.user = user
    }
}
