//
//  User.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 14/12/2023.
//

import Foundation

struct User: Codable, Identifiable {
    var id: String
    var email: String
    var nickname: String
    var photoData: Data?
    
    init(id: String, email: String, nickname: String, photoData: Data? = nil) {
        self.id = id
        self.email = email
        self.nickname = nickname
        self.photoData = photoData
    }
    
    init(id: String, email: String, nickname: String) {
        self.id = id
        self.email = email
        self.nickname = nickname
    }
}
