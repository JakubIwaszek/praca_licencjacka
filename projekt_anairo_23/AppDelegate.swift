//
//  AppDelegate.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 08/12/2023.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage

class AppDelegate: NSObject, UIApplicationDelegate {
    static let db = Firestore.firestore()
    static let storage = Storage.storage()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
