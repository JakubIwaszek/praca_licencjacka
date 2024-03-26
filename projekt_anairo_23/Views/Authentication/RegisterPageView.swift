//
//  RegisterPageView.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 08/12/2023.
//

import SwiftUI

struct RegisterPageView: View {
    @StateObject private var viewModel = RegisterPageViewModel()
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        ScrollView {
            logo
            Spacer()
            textFieldsView
            Spacer()
                .padding(.bottom, 30)
            buttonView
        }
        .scrollBounceBehavior(.basedOnSize)
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.loginBackgroundColor)
        .alert(viewModel.alert.message, isPresented: $viewModel.alert.isPresented) {
            Button {
                if viewModel.alert.shouldDismissView {
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
    
    private var logo: some View {
        Image("logo")
            .resizable()
            .frame(width: 350, height: 350)
    }
    
    private var textFieldsView: some View {
        VStack {
            TextField(text: $viewModel.login) {
                Text("Provide your email")
                    .foregroundStyle(Color.gray)
            }
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(Color.black)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.bottom, 6)
            TextField(text: $viewModel.nickname) {
                Text("Provide your nickname")
                    .foregroundStyle(Color.gray)
            }
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(Color.black)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.bottom, 6)
            SecureField(text: $viewModel.password) {
                Text("Provide your password")
                    .foregroundStyle(Color.gray)
            }
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(Color.black)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
    
    private var buttonView: some View {
        VStack {
            Button {
                viewModel.createUserAccount()
            } label: {
                Text("Create an account")
                    .foregroundStyle(viewModel.validateFields() ? Color.white : Color.gray)
            }
            .padding(12)
            .frame(width: 200)
            .background(Color.mainBackgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .disabled(!viewModel.validateFields())
        }
    }
}

#Preview {
    RegisterPageView()
}
