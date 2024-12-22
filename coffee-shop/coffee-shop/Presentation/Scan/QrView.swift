//
//  QrView.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-17.
//

import SwiftUI

struct QrView: View {
    @StateObject private var viewModel = UserViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            qrCode
            Spacer()
            
            progressView
        }
        .padding(.bottom, 51)
        .onAppear {
            viewModel.generateQR()
        }
        
    }
}

extension QrView {
    @ViewBuilder
    var qrCode: some View {
        if viewModel.isLoading {
            ProgressView("Генерация QR-кода...")
        } else if let qrImage = viewModel.qrImage {
            Image(uiImage: qrImage)
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
        } else {
            Text(viewModel.message)
                .foregroundColor(viewModel.isError ? .red : .gray)
                .multilineTextAlignment(.center)
        }
    }
    
    var progressView: some View {
        let coffeeCount = viewModel.user?.coffeeCount ?? 0
        let filledCups = coffeeCount % 10
        let emptyCups = 10 - filledCups
        
        return VStack {
            HStack(spacing: -15) {
                // Заполненные чашки
                ForEach(0..<filledCups, id: \.self) { _ in
                    cupView(isFilled: true)
                }
                // Пустые чашки
                ForEach(0..<emptyCups, id: \.self) { _ in
                    cupView(isFilled: false)
                }
            }
            Text("Осталось \(emptyCups) напитков до бесплатного кофе")
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
    
    func cupView(isFilled: Bool) -> some View {
        ZStack {
            Image(systemName: "cup.and.heat.waves.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 47, height: 47) // Обводка чуть больше
                .foregroundColor(.white)
            
            Image(systemName: isFilled ? "cup.and.heat.waves.fill" : "cup.and.heat.waves")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40) // Основной размер
                .foregroundColor(isFilled ? .accentColor : .gray)
        }
    }
}

#Preview {
    QrView()
}
