//
//  LoginPageView.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 25/11/2023.
//

import SwiftUI

struct LoginPageView: View {
    @EnvironmentObject private var appRootManager: RootManager
    @StateObject private var viewModel = LoginPageViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                logo
                Spacer()
                textFieldsView
                Spacer()
                    .padding(.bottom, 30)
                buttonsView
            }
            .scrollBounceBehavior(.basedOnSize)
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.loginBackgroundColor)
            .alert(viewModel.alert.message, isPresented: $viewModel.alert.isPresented) {
                Button {
                    print("ok")
                } label: {
                    Text("Ok")
                }
            }
            .modifier(ActivityIndicatorModifier(isLoading: viewModel.isLoading))
            .onChange(of: viewModel.shouldMoveRoot) { _, shouldMove in
                if shouldMove {
                    withAnimation(.spring()) {
                        appRootManager.currentRoot = .home
                    }
                }
            }
            .onAppear {
                viewModel.checkForSavedData()
            }
        }
    }
    
    private var logo: some View {
        Image("logo")
            .resizable()
            .frame(width: 350, height: 350)
    }
    
    private var textFieldsView: some View {
        VStack {
            TextField(text: $viewModel.login) {
                Text("Login")
                    .foregroundStyle(Color.gray)
            }
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(Color.black)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.bottom, 6)
            .accessibilityIdentifier("txtFieldLogin")
            SecureField(text: $viewModel.password) {
                Text("Password")
                    .foregroundStyle(Color.gray)
            }
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(Color.black)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .accessibilityIdentifier("txtFieldPassword")
        }
    }
    
    private var buttonsView: some View {
        VStack {
            Button {
                viewModel.signIn { success in
                    if success {
                        viewModel.setCurrentRootView()
                    }
                }
            } label: {
                Text("Log In")
                    .foregroundStyle(viewModel.validateFields() ? Color.white : Color.gray)
            }
            .padding(12)
            .frame(width: 200)
            .background(Color.mainBackgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .disabled(!viewModel.validateFields())
            .accessibilityIdentifier("btnLogin")
            NavigationLink {
                RegisterPageView()
            } label: {
                Text("Sign Up")
                    .foregroundStyle(Color.white)
            }
            .padding(12)
            .frame(width: 200)
            .background(Color.mainBackgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .accessibilityIdentifier("btnSignUp")
        }
    }
}

#Preview {
    LoginPageView()
}
