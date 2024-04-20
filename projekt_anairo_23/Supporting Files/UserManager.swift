//
//  UserManager.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 19/01/2024.
//

import Foundation
import LocalAuthentication

class UserManager {
    static let shared = UserManager()
    var currentUser: User?
    var following: [String] = []
    
    func setupUser(with user: User) {
        currentUser = user
        fetchFollowingList()
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
    
    func removeUser() {
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
