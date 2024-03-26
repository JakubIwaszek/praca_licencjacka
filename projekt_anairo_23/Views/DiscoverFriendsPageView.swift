//
//  DiscoverFriendsPageView.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 20/01/2024.
//

import SwiftUI

struct DiscoverFriendsPageView: View {
    @StateObject private var viewModel = DiscoverFriendsPageViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    if !viewModel.users.isEmpty {
                        ForEach(viewModel.users) { user in
                            Divider()
                                .background(Color.white)
                                .padding([.top, .bottom], 8)
                            createUserLayoutView(for: user)
                        }
                        Divider()
                            .background(Color.white)
                            .padding([.top, .bottom], 8)
                    } else {
                        Text("It's so empty in here...")
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.top, 100)
                            .onAppear {
                                if !viewModel.hasFetched {
                                    viewModel.fetchAllUsers()
                                }
                            }
                    }
                }
                .padding(16)
            }
            .background(Color.mainBackgroundColor)
            .navigationTitle("Discover")
            .refreshable {
                viewModel.fetchAllUsers()
            }
            .alert(viewModel.alert.message, isPresented: $viewModel.alert.isPresented) {
                Button {
                    viewModel.fetchAllUsers()
                } label: {
                    Text("Ok")
                }
            }
            .modifier(ActivityIndicatorModifier(isLoading: viewModel.isLoading))
        }
    }
    
    private func createUserLayoutView(for user: User) -> some View {
        HStack(alignment: .top, spacing: 16) {
            userImageView
            VStack(alignment: .leading) {
                Text(user.nickname)
                    .font(.title3)
                Text(user.email)
                    .font(.caption)
                    .foregroundStyle(Color.lightGray)
            }
            Spacer()
            if !UserManager.shared.following.contains(user.id) {
                Button {
                    viewModel.addNewFriend(userId: user.id)
                } label: {
                    Text("Follow")
                        .padding(8)
                        .frame(width: 80)
                        .background(Color.postBackgroundColor)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
        .foregroundStyle(Color.white)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var userImageView: some View {
        Image(systemName: "person.circle.fill")
            .resizable()
            .frame(width: 40, height: 40)
            .clipShape(Circle())
    }
}

#Preview {
    DiscoverFriendsPageView()
}
