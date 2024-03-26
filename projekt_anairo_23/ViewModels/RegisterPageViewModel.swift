//
//  RegisterPageViewModel.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 08/12/2023.
//

import Foundation
import FirebaseAuth

class RegisterPageViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var alert = AlertMessage(message: "")
    @Published var login = ""
    @Published var password = ""
    @Published var nickname = ""

    func validateFields() -> Bool {
        return (!login.isEmpty && !password.isEmpty)
    }
    
    func createUserAccount() {
        isLoading = true
        Auth.auth().createUser(withEmail: login, password: password) { [weak self] result, error in
            self?.isLoading = false
            if let user = result {
                guard let userData = self?.prepareUserData(userId: user.user.uid) else {
                    self?.alert.setup(isPresented: true, message: "Something went wrong...")
                    return
                }
                AppDelegate.db.collection(CollectionPath.users.rawValue).document(user.user.uid).setData(userData) { [weak self] error in
                    if let error = error {
                        self?.alert.setup(isPresented: true, message: error.localizedDescription)
                    } else {
                        self?.alert.setup(isPresented: true, message: "The account has been created.", shouldDismissView: true)
                    }
                }
            } else {
                guard let error = error else {
                    self?.alert.setup(isPresented: true, message: "Something went wrong...")
                    return
                }
                self?.alert.setup(isPresented: true, message: error.localizedDescription)
            }
        }
    }
    
    func prepareUserData(userId: String) -> [String: Any] {
        return [
            "id": userId,
            "email": login,
            "nickname": nickname
        ]
    }
}
