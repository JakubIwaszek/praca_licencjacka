//
//  CommentView.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 13/04/2024.
//

import SwiftUI

struct CommentView: View {
    var comment: Comment
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
            VStack(alignment: .leading) {
                commentDetailsView
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
                    .background(.gray)
                contentView
            }
        }
        .padding(16)
        .frame(alignment: .leading)
        .foregroundStyle(.white)
        .background(Color.postBackgroundColor)
        .cornerRadius(20) /// make the background rounded
        .overlay( /// apply a rounded border
            RoundedRectangle(cornerRadius: 20)
                .stroke(.gray, lineWidth: 1)
        )
    }
    
    private var commentDetailsView: some View {
        HStack(alignment: .top) {
            Text(comment.author.nickname)
        }
    }
    
    private var contentView: some View {
        VStack {
            Text(comment.contentText)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    CommentView(comment: Comment(id: "1", contentText: "sample comment", date: Date().formatted(), author: User(id: "", email: "test@test.com", nickname: "testuser", photoUrl: "")))
}
