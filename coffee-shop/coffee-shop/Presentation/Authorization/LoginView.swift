//
//  LoginView.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-16.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel: AuthorizationViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            VStack(spacing: 0) {
//                Image("beans_falling")
//                    .resizable()
//                    .scaledToFit()
//                    .padding(.horizontal, -16)
//                    .scaleEffect(x: -1, y: 1)
//                    .ignoresSafeArea(edges: .top)
                SteamEffect()
                    .frame(height: 200)
                    .ignoresSafeArea(edges: .top)
                
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
            }
            
            Spacer()
            
            VStack(spacing: 20) {
                
                LoginTextField(title: "Почта", placeholder: "Введите вашу почту", binding: $viewModel.email)
                
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
                
                HStack(spacing: 5) {
                    Text("Еще нет аккаунта?")
                        .font(.footnote)
                    
                    Button {
                        viewModel.navigate(to: .registration)
                    } label: {
                        Text("Зарегистируйтесь")
                            .foregroundStyle(Color("Text/Mint"))
                            .italic()

                    }
                }
                .padding(.top, -15)
            }

            
        }
        .padding(EdgeInsets(top: 0,
                            leading: 16,
                            bottom: 30,
                            trailing: 16))
        .background(Color("LoginBg"))
    }
}

#Preview {
    LoginView(viewModel: AuthorizationViewModel())
}
