//
//  PostView.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 24/11/2023.
//

import SwiftUI

struct PostView: View {
    var post: Post
    @State var author: User
    @State var isAuthorPhotoLoading = true
    
    var body: some View {
        NavigationLink {
            PostDetailsView(post: post, author: author)
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
            if let imageData = author.photoData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            } else if isAuthorPhotoLoading {
                ProgressView()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .onAppear {
                        UserManager.shared.fetchUserImage(for: author) { imageData in
                            author.photoData = imageData
                            isAuthorPhotoLoading = false
                        }
                    }
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
            }
            Text(author.nickname)
                .multilineTextAlignment(.leading)
        }
    }
    
    private var contentView: some View {
        VStack(alignment: .leading) {
            Text(post.contentText)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            if let imageData = post.imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
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
