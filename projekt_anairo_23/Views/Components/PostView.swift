//
//  PostView.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 24/11/2023.
//

import SwiftUI

struct PostView: View {
    var post: Post
    
    var body: some View {
        NavigationLink {
            PostDetailsView(post: post)
        } label: {
            VStack(alignment: .leading) {
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
            .clipShape(RoundedRectangle(cornerRadius: 25))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var userView: some View {
        HStack(alignment: .top) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
            Text(post.user.nickname)
                .multilineTextAlignment(.leading)
        }
    }
    
    private var contentView: some View {
        VStack(alignment: .leading) {
            Text(post.contentText)
                .multilineTextAlignment(.leading)
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


//#Preview {
//    PostView(post: Post(id: "1", contentText: "lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum"))
//}
