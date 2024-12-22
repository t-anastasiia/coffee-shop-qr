//
//  RegisterView.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-16.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var viewModel: AuthorizationViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            Image("CoffeeShotLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 56)
            
            VStack(spacing: 20) {
                VStack(spacing: 10) {
                    HStack {
                        Text("Регистрация")
                            .foregroundStyle(Color("Text/Brown"))
                            .font(.system(size: 28, weight: .bold))
                        Spacer()
                    }
                    Text("Мы рады, что вы готовы стать частью нашей кофейной сети! Не забудьте ознакомиться с вашими привилегиями!")
                        .foregroundStyle(Color("Text/Brown"))
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                LoginTextField(title: "Имя", placeholder: "Введите ваше имя", binding: $viewModel.name)
                
                LoginTextField(title: "Почта", placeholder: "Введите вашу почту", binding: $viewModel.email)
                
                PasswordTextField(binding: $viewModel.password)
                
                Spacer()
                
                    
                Button {
                    viewModel.register()
                } label: {
                    Text("ЗАРЕГИСТРИРОВАТЬСЯ")
                        .foregroundStyle(.white)
                        .padding(.vertical, 20)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 22)
                        )
                }
                
            }
            
        }
        .padding(EdgeInsets(top: 24,
                            leading: 16,
                            bottom: 30,
                            trailing: 16))
        .overlay(alignment: .top) {
            Button {
                viewModel.back()
            } label: {
                Image(systemName: "chevron.left")
            }
            .padding(EdgeInsets(top: 20,
                                leading: 16, 
                                bottom: 20, 
                                trailing: 16))
        }
        .background(Color("LoginBg"))
    }
}

#Preview {
    RegisterView(viewModel: AuthorizationViewModel())
}
