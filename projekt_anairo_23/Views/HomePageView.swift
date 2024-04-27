//
//  HomePageView.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 03/11/2023.
//

import SwiftUI

struct HomePageView: View {
    @StateObject private var viewModel = HomePageViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    if !viewModel.posts.isEmpty {
                        ForEach(viewModel.posts, id: \.id) { post in
                            PostView(post: post, author: post.user)
                                .padding(.bottom, 20)
                        }
                    } else {
                        Text("It's so empty in here...")
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.top, 100)
                            .onAppear {
                                if !viewModel.hasFetched {
                                    viewModel.setupNotification()
                                    viewModel.fetchAllPosts()
                                }
                            }
                    }
                }
                .padding(16)
            }
            .background(Color.mainBackgroundColor)
            .frame(maxWidth: .infinity)
            .navigationTitle("Feed")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        AddNewPostPageView()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .refreshable {
                viewModel.fetchAllPosts()
            }
            .modifier(ActivityIndicatorModifier(isLoading: viewModel.isLoading))
        }
    }
}

#Preview {
    HomePageView()
}
