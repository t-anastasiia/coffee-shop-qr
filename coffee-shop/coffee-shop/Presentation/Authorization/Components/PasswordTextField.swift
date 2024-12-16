//
//  PasswordTextField.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-17.
//

import SwiftUI

struct PasswordTextField: View {
    var title: String = "Пароль"
    var placeholder: String = "Введите пароль"
    @Binding var binding: String
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text(title)
                    .foregroundStyle(Color("Text/Mint"))
                    .font(.headline)
                Spacer()
            }
            SecureField(placeholder, text: $binding)
                .foregroundStyle(Color("Text/Brown"))
                .padding(EdgeInsets(top: 18,
                                    leading: 10,
                                    bottom: 18,
                                    trailing: 10))
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: Color.gray.opacity(0.3), radius: 4, x: 0, y: 2)
        }
    }
}

#Preview {
    PasswordTextField(binding: .constant(""))
}
