//
//  KeychainManager.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 20/04/2024.
//

import Foundation
import KeychainAccess

class KeychainManager {
    static let shared = KeychainManager()
    private let keychain = Keychain()
    
    func save(key: String, value: String) {
        keychain[key] = value
    }
    
    func read(key: String) -> String? {
        return keychain[key]
    }
    
    func remove(key: String) {
        keychain[key] = nil
    }
}
