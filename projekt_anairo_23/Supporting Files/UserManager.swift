//
//  UserManager.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 19/01/2024.
//

import Foundation
import LocalAuthentication
import SwiftUI

class UserManager {
    static let shared = UserManager()
    var currentUser: User?
    var following: [String] = []
    
    func setupUser(with user: User) {
        currentUser = user
        fetchFollowingList()
        fetchUserImage { _ in }
    }
    
    func saveUserSession(currentUser: User) {
        let encoder = JSONEncoder()
        if let userData = try? encoder.encode(currentUser) {
            UserDefaults.standard.set(userData, forKey: "user")
        }
    }
    
    func getUserSession() -> User? {
        if let userData = UserDefaults.standard.object(forKey: "user") as? Data {
            let decoder = JSONDecoder()
            guard let user = try? decoder.decode(User.self, from: userData) else {
                return nil
            }
            return user
        } else {
            return nil
        }
    }
    
    func removeUserSession() {
        UserDefaults.standard.removeObject(forKey: "user")
    }
    
    func saveUserCredentials(login: String?, password: String?) {
        guard let login = login, let password = password else {
            return
        }
        KeychainManager.shared.save(key: "login", value: login)
        KeychainManager.shared.save(key: "password", value: password)
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
    
    func fetchUserImage(completion: @escaping (Data?) -> Void) {
        guard let currentUser = UserManager.shared.currentUser else {
            completion(nil)
            return
        }
        let imageRef = AppDelegate.storage.reference().child("images/user-\(currentUser.id)")
        imageRef.getData(maxSize: 10 * 1024 * 1024) { [weak self] data, _ in
            if let imageData = data {
                self?.currentUser?.photoData = imageData
                completion(data)
            } else {
                completion(nil)
            }
        }
    }
    
    func removeUser() {
        removeUserSession()
        currentUser = nil
        following = []
    }
    
    func authenticateWithBiometrics(success: @escaping (Bool) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "Auto login"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { authSuccess, authenticationError in
                // authentication has now completed
                if authSuccess {
                    // authenticated successfully
                    success(true)
                } else {
                    // there was a problem
                    success(false)
                }
            }
        } else {
            // no biometrics
            success(false)
        }
    }
}
