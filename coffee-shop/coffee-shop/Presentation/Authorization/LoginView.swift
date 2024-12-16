//
//  LoginView.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-16.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewModel = AuthorizationViewModel()
    
    var body: some View {
        VStack(spacing: 10) {
            Image("CoffeeShotLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 56)
            
            VStack(spacing: 20) {
                VStack(spacing: 10) {
                    HStack {
                        Text("Вход")
                            .foregroundStyle(Color("Text/Brown"))
                            .font(.system(size: 28, weight: .bold))
                        Spacer()
                    }
                    Text("Время кофе! Войдите в аккаунт и давайте соберём весь кофе в мире! Ну или хотя бы айс-кофе.")
                        .foregroundStyle(Color("Text/Brown"))
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                LoginTextField(title: "Почта", placeholder: "Введите вашу почту", binding: $viewModel.name)
                
                PasswordTextField(binding: $viewModel.password)
                
                Button {
                    Task {
                        viewModel.login()
                    }
                } label: {
                    Text("ВОЙТИ")
                        .foregroundStyle(.white)
                        .padding(.vertical, 20)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 22)
                        )
                }
                
                Spacer()
                
                VStack(spacing: 5) {
                    
                    Text("Еще нет аккаунта?")
                        .font(.footnote)
                    
                    Button {
                        viewModel.navigate(to: .registration)
                    } label: {
                        Text("СОЗДАТЬ АККАУНТ")
                            .foregroundStyle(.white)
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 22)
                            )
                    }
                }
            }
            
        }
        .padding(.horizontal, 16)
        .background(Color("LoginBg"))
    }
}

#Preview {
    LoginView()
}
