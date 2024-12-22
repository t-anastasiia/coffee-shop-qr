//
//  LoginTextFields.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-16.
//

import SwiftUI

struct LoginTextField: View {
    
    var title: String
    var placeholder: String
    @Binding var binding: String
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text(title)
                    .foregroundStyle(Color("Text/Mint"))
                    .font(.headline)
                Spacer()
            }
            TextField(placeholder, text: $binding)
                .textInputAutocapitalization(.never)
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
    LoginTextField(title: "Название", placeholder: "Плейсхолдер", binding: .constant(""))
}
