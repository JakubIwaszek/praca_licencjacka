//
//  PostDetailsView.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 13/04/2024.
//

import SwiftUI

struct PostDetailsView: View {
    @StateObject private var viewModel: PostDetailsViewModel
    @FocusState private var isCommentFieldFocused: Bool
    
    init(post: Post, author: User) {
        _viewModel = StateObject(wrappedValue: PostDetailsViewModel(post: post, author: author))
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    userView
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Divider()
                        .background(.gray)
                    contentView
                    Divider()
                        .background(.gray)
                    expressionsCounterView
                    Divider()
                        .background(.gray)
                    expressionsButtonsView
                }
                .padding([.top, .leading, .trailing], 16)
                .frame(alignment: .leading)
                .foregroundStyle(.white)
                .background(Color.postBackgroundColor)
                Divider()
                    .background(.gray)
                commentsView
            }
            addCommentView
        }
        .toolbarTitleDisplayMode(.inline)
        .background(Color.postBackgroundColor)
        .onTapGesture {
            isCommentFieldFocused = false
        }
        .modifier(ActivityIndicatorModifier(isLoading: viewModel.isLoading))
        .refreshable {
            viewModel.refreshData()
        }
        .onAppear {
            viewModel.refreshData()
        }
    }
    
    private var userView: some View {
        HStack(alignment: .top) {
            if let imageData = viewModel.author.photoData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
            }
            Text(viewModel.post.user.nickname)
        }
    }
    
    private var contentView: some View {
        VStack {
            Text(viewModel.post.contentText)
                .frame(maxWidth: .infinity, alignment: .leading)
            if let imageData = viewModel.post.imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            Text(viewModel.post.date)
                .font(.footnote)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 16)
        }
    }
    
    private var expressionsCounterView: some View {
        HStack {
            Text("**\(viewModel.likes.count)** likes   **\(viewModel.comments.count)** comments")
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private var expressionsButtonsView: some View {
        HStack {
            Button {
                viewModel.addLike()
            } label: {
                Image(systemName: viewModel.hasLiked() ? "heart.fill" : "heart")
                    .frame(width: 30, height: 30)
                    .foregroundStyle(viewModel.hasLiked() ? Color.red : Color.white)
            }
            .padding(.trailing, 16)
            Button {
                isCommentFieldFocused = true
            } label : {
                Image(systemName: "bubble.right")
                    .frame(width: 30, height: 30)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private var commentsView: some View {
        if !viewModel.comments.isEmpty {
            VStack {
                ForEach(viewModel.comments, id: \.id) { comment in
                    CommentView(comment: comment, author: comment.author)
                        .padding(.horizontal, 16)
                }
            }
        } else if viewModel.isLoading {
            ProgressView()
        }
    }
    
    private var addCommentView: some View {
        HStack(alignment: .top) {
            TextField("Add your comment", text: $viewModel.commentText)
                .focused($isCommentFieldFocused)
                .textFieldStyle(.automatic)
            Spacer()
            Button {
                viewModel.addComment()
            } label: {
                Text("Send")
            }
        }
        .padding(16)
        .background(Color.mainBackgroundColor)
        .foregroundStyle(.white)
    }
}

//#Preview {
//    PostDetailsView(post: Post(id: "1", contentText: "lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum", date: "2024-11-21", user: User(id: "1", email: "test@test.com", nickname: "test", photoUrl: "")))
//}
