//
//  ImageView.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 20/04/2024.
//

import SwiftUI

enum ImageState {
    case empty
    case loading(Progress)
    case success(Image)
    case failure
}

struct ImageView: View {
    let imageState: ImageState
    
    var body: some View {
        switch imageState {
        case .success(let image):
            image.resizable()
        case .loading:
            ProgressView()
        case .empty:
            Image(systemName: "person.circle.fill")
                .resizable()
                .foregroundColor(.white)
        case .failure:
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .foregroundColor(.white)
        }
    }
}

//#Preview {
//    ImageView()
//}
