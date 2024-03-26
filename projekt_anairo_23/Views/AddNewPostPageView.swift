//
//  AddNewPostPageView.swift
//  projekt_anairo_23
//
//  Created by Przemysław Szwajcowski on 08/12/2023.
//

import SwiftUI

struct AddNewPostPageView: View {
    @Environment(\.presentationMode) private var presentationMode
    @StateObject private var viewModel = AddNewPostViewModel()
    private var placeholderText = "What's happening?"
    
    var body: some View {
        VStack {
            TextEditor(text: $viewModel.postText)
                .scrollContentBackground(.hidden)
                .background(Color.clear)
                .padding(16)
                .foregroundColor(viewModel.postText == placeholderText ? .gray : .primary)
                .onTapGesture {
                    if viewModel.postText == placeholderText {
                        viewModel.postText = ""
                    }
                }
        }
        .toolbarTitleDisplayMode(.inline)
        .background(Color.mainBackgroundColor)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.addNewPost()
                } label: {
                    Text("Post")
                }
            }
        }
        .alert(viewModel.alert.message, isPresented: $viewModel.alert.isPresented) {
            Button {
                if viewModel.alert.shouldDismissView {
                    NotificationCenter.default.post(name: NSNotification.Name("addedPost"), object: nil)
                    presentationMode.wrappedValue.dismiss()
                }
            } label: {
                if viewModel.alert.shouldDismissView {
                    Text("Dismiss")
                } else {
                    Text("Ok")
                }
            }
        }
        .modifier(ActivityIndicatorModifier(isLoading: viewModel.isLoading))
    }
}

#Preview {
    AddNewPostPageView()
}
