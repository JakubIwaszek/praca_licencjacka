//
//  Comment.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 13/04/2024.
//

import Foundation

struct Comment: Identifiable, Codable {
    var id: String
    var contentText: String
    var date: String
    var author: User
}
