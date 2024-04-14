//
//  PostDetailsView.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 13/04/2024.
//

import SwiftUI

struct PostDetailsView: View {
    @State private var commentText: String = ""
    @FocusState private var isCommentFieldFocused: Bool
    var post: Post
    var demoComments: [Comment] = [Comment(id: "1", contentText: "sampel commeent 1", author: User(id: "", email: "test", nickname: "testacc", photoUrl: "")), Comment(id: "2", contentText: "sampel commeent 2", author: User(id: "", email: "test", nickname: "testacc", photoUrl: "")), Comment(id: "3", contentText: "sampel commeent 3", author: User(id: "", email: "test", nickname: "testacc", photoUrl: ""))]
    
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
                VStack {
                    ForEach(demoComments, id: \.id) { comment in
                        CommentView(comment: comment)
                    }
                }
            }
            addCommentView
        }
        .toolbarTitleDisplayMode(.inline)
        .background(Color.postBackgroundColor)
        .onTapGesture {
            isCommentFieldFocused = false
        }
    }
    
    private var userView: some View {
        HStack(alignment: .top) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
            Text(post.user.nickname)
        }
    }
    
    private var contentView: some View {
        VStack {
            Text(post.contentText)
                .frame(maxWidth: .infinity, alignment: .leading)
            if let imageUrl = post.imageUrl {
                Image("fala")
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            Text(post.date)
                .font(.footnote)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 16)
        }
    }
    
    private var expressionsCounterView: some View {
        HStack {
            // TODO: Update counters
            Text("**\(10)** likes   **\(demoComments.count)** comments")
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private var expressionsButtonsView: some View {
        HStack {
            Button {
                // TODO: Implement action
                print("like")
            } label: {
                Image(systemName: "heart")
                    .frame(width: 30, height: 30)
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
    
    private var addCommentView: some View {
        HStack(alignment: .top) {
            TextField("Add your comment", text: $commentText)
                .focused($isCommentFieldFocused)
                .textFieldStyle(.automatic)
            Spacer()
            Button {
                // TODO: Implement action
                print("send comment")
            } label: {
                Text("Send")
            }
        }
        .padding(16)
        .background(Color.mainBackgroundColor)
        .foregroundStyle(.white)
    }
}

#Preview {
    PostDetailsView(post: Post(id: "1", contentText: "lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum", date: "2024-11-21", user: User(id: "1", email: "test@test.com", nickname: "test", photoUrl: "")))
}
