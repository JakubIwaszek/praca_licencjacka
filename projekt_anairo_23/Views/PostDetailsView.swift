//
//  PostDetailsView.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 13/04/2024.
//

import SwiftUI

struct PostDetailsView: View {
    @State private var commentText: String = ""
    var post: Post
    var demoComments: [Comment] = [Comment(id: "1", contentText: "sampel commeent 1", author: User(id: "", email: "test", nickname: "testacc", photoUrl: "")), Comment(id: "2", contentText: "sampel commeent 2", author: User(id: "", email: "test", nickname: "testacc", photoUrl: "")), Comment(id: "3", contentText: "sampel commeent 3", author: User(id: "", email: "test", nickname: "testacc", photoUrl: ""))]
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    userView
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Divider()
                        .background(.white)
                    contentView
                }
                .padding(16)
                .frame(alignment: .leading)
                .foregroundStyle(.white)
                .background(Color.postBackgroundColor)
                Divider()
                    .background(.white)
                VStack {
                    ForEach(demoComments, id: \.id) { comment in
                        CommentView(comment: comment)
                    }
                }
            }
            HStack(alignment: .top) {
                TextField("Add your comment", text: $commentText)
                    .textFieldStyle(.automatic)
                Spacer()
                Button {
                    print("send comment")
                } label: {
                    Text("Send")
                }
            }
            .padding(16)
            .background(Color.mainBackgroundColor)
            .foregroundStyle(.white)
        }
        .toolbarTitleDisplayMode(.inline)
        .background(Color.postBackgroundColor)
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
        }
    }
}

#Preview {
    PostDetailsView(post: Post(id: "1", contentText: "lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum", date: "2024-11-21", user: User(id: "1", email: "test@test.com", nickname: "test", photoUrl: "")))
}
