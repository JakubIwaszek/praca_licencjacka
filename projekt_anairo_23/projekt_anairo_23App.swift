//
//  projekt_anairo_23App.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 03/11/2023.
//

import SwiftUI
import SwiftData

@main
struct projekt_anairo_23App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var appRootManager = RootManager()

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            Group {
                switch appRootManager.currentRoot {
                case .home:
                    MainTabView()
                        .preferredColorScheme(.dark)
                case .authentication:
                    LoginPageView()
                        .preferredColorScheme(.dark)
                }
            }
            .environmentObject(appRootManager)
        }
        .modelContainer(sharedModelContainer)
    }
}
