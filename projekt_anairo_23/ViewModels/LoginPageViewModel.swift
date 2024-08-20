//
//  LoginPageViewModel.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 08/12/2023.
//

import Foundation
import FirebaseAuth

class LoginPageViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var alert = AlertMessage(message: "")
    @Published var login = ""
    @Published var password = ""
    @Published var shouldMoveRoot = false
    
    func validateFields() -> Bool {
        return !login.isEmpty && !password.isEmpty
    }
    
    func signIn(success: @escaping (Bool) -> Void) {
        isLoading = true
        Auth.auth().signIn(withEmail: login, password: password) { [weak self] result, error in
            self?.isLoading = false
            if let user = result {
                AppDelegate.db.collection(CollectionPath.users.rawValue).document(user.user.uid).getDocument(as: User.self) { result in
                    switch result {
                    case .success(let user):
                        UserManager.shared.setupUser(with: user)
                        UserManager.shared.saveUserSession(currentUser: user)
                        UserManager.shared.saveUserCredentials(login: self?.login, password: self?.password)
                        success(true)
                    case .failure(let error):
                        self?.alert.setup(isPresented: true, message: error.localizedDescription)
                        success(false)
                    }
                }
            } else {
                guard let error = error else {
                    self?.alert.setup(isPresented: true, message: "Something went wrong...")
                    success(false)
                    return
                }
                self?.alert.setup(isPresented: true, message: error.localizedDescription)
                success(false)
            }
        }
    }
    
    func setCurrentRootView() {
        shouldMoveRoot = true
    }
    
    func checkForSavedData() {
        guard let savedLogin = KeychainManager.shared.read(key: "login"), let savedPassword = KeychainManager.shared.read(key: "password") else {
            return
        }
        UserManager.shared.authenticateWithBiometrics { [weak self] success in
            if success {
                self?.login = savedLogin
                self?.password = savedPassword
                self?.signIn { [weak self] signedIn in
                    self?.setCurrentRootView()
                }
            }
        }
    }
}
