//
//  User.swift
//  projekt_anairo_23
//
//  Created by Bartosz Lipiński on 14/12/2023.
//

import Foundation

struct User: Codable, Identifiable {
    var id: String
    var email: String
    var nickname: String
    var photoUrl: String?
}
