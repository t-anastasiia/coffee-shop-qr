//
//  ScanView.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-16.
//

import SwiftUI
import CodeScanner

struct ScanView: View {
    @StateObject private var viewModel = UserViewModel()

    var body: some View {
        ZStack {
            if !viewModel.isShowingPicker {
                CodeScannerView(
                    codeTypes: [.qr],
                    simulatedData: "John Doe\njohn@example.com",
                    completion: viewModel.processScanResult
                )
            }
            
            if viewModel.isShowingPicker {
                pickerView
                    .background(
                        Color.white
                            .cornerRadius(12)
                            .shadow(radius: 10)
                    )
                    .padding()
            }
        }
        .onAppear {
            viewModel.isShowingScanner = true
        }
        .alert(isPresented: $viewModel.isError) {
            Alert(title: Text("Ошибка"), message: Text(viewModel.message), dismissButton: .default(Text("OK")))
        }
    }
}

extension ScanView {
    private var pickerView: some View {
        VStack(spacing: 20) {
            Text("Сколько напитков заказал пользователь?")
                .font(.headline)
                .multilineTextAlignment(.center)

            Picker("Количество напитков", selection: $viewModel.selectedDrinks) {
                ForEach(1...10, id: \.self) { number in
                    Text("\(number)").tag(number)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(height: 150)

            HStack(spacing: 20) {
                Button("Отправить") {
                    viewModel.sendDrinksCount()
                    viewModel.isShowingPicker = false
                }
                .buttonStyle(.borderedProminent)
                
                // Кнопка "Закрыть"
                Button("Закрыть") {
                    viewModel.isShowingPicker = false
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
    }
}

#Preview {
    ScanView()
}
