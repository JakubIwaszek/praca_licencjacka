//
//  MainTabView.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 24/11/2023.
//

import SwiftUI

struct MainTabView: View {
    @State private var selection = 0

    var body: some View {
        TabView(selection: $selection) {
            HomePageView()
                .tag(0)
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("Home")
                    }
                }
            DiscoverFriendsPageView()
                .tag(1)
                .tabItem {
                    VStack {
                        Image(systemName: "person.3")
                        Text("People")
                    }
                }
            UserAccountPageView()
                .tag(2)
                .tabItem {
                    VStack {
                        Image(systemName: "person")
                        Text("Profile")
                    }
                }
        }
        .toolbarBackground(Color.mainBackgroundColor, for: .automatic)
//        .tint(Color.lightGray)
    }
}

#Preview {
    MainTabView()
}
