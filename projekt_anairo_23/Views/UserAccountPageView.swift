//
//  UserAccountPageView.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 14/12/2023.
//

import SwiftUI
import PhotosUI

struct UserAccountPageView: View {
    @EnvironmentObject private var appRootManager: RootManager
    @StateObject private var viewModel = UserAccountPageViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    profileStackView
                        .foregroundColor(.white)
                        .padding(16)
                    Divider()
                        .background(.white)
                    postsView
                        .padding(16)
                }
            }
            .task {
                await viewModel.loadUserPosts()
                await viewModel.refreshUserImage()
            }
            .refreshable {
                await viewModel.loadUserPosts()
                await viewModel.refreshUserImage()
            }
            .background(Color.mainBackgroundColor)
            .modifier(ActivityIndicatorModifier(isLoading: viewModel.isLoading))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.logout(with: appRootManager)
                    } label: {
                        Text("Logout")
                    }
                }
            }
        }
    }
    
    private var profileStackView: some View {
        HStack(alignment: .top, spacing: 16) {
            userImageView
            userDetailsView
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var userImageView: some View {
        ImageView(imageState: viewModel.profileImageState)
            .frame(width: 140, height: 140)
            .clipShape(Circle())
            .overlay(alignment: .topLeading) {
                PhotosPicker(selection: $viewModel.imageSelection, matching: .images, preferredItemEncoding: .automatic) {
                    Image(systemName: "arrow.triangle.2.circlepath.camera")
                        .resizable()
                        .frame(width: 30, height: 25)
                        .padding(10)
                        .background(Color.mainBackgroundColor)
                        .clipShape(Circle())
                }
            }
    }
    
    private var userDetailsView: some View {
        VStack(alignment: .leading) {
            Text(viewModel.user?.nickname ?? "Invalid user")
                .font(.title)
            Text(viewModel.user?.email ?? "Invalid user")
                .font(.title3)
            Spacer()
            Text("Following: \(UserManager.shared.following.count)")
            Text("Posts: \(viewModel.userPosts.count)")
                .padding(.bottom, 8)
        }
    }
    
    private var postsView: some View {
        VStack {
            ForEach(viewModel.userPosts, id: \.id) { post in
                PostView(post: post, author: UserManager.shared.currentUser ?? post.user)
                    .padding(.bottom, 20)
            }
        }
    }
}

#Preview {
    UserAccountPageView()
}
