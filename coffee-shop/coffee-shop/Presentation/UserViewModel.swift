//
//  UserViewModel.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-17.
//

import SwiftUI
import UIKit
import CodeScanner

@MainActor
class UserViewModel: ObservableObject {
    private let useCase: UserUseCaseProtocol
    private let session = SessionManager.shared
    
    //MARK: for user
    @Published var qrImage: UIImage? = nil
    @Published var user: User? = nil
    
    // MARK: for worder
    private var scannedUser: User? = nil
    @Published var isShowingPicker = false
    @Published var isShowingScanner = false
    @Published var selectedDrinks = 1
    
    //MARK: common
    @Published var isLoading: Bool = false
    @Published var message: String = "Подождите, пока сгенерируется QR-код..."
    @Published var isError: Bool = false
    
    init(useCase: UserUseCaseProtocol = UserUseCase()) {
        self.useCase = useCase
        self.user = session.currentUser
    }
    
    func generateQR() {
        loadCurrentUser()
        guard let currentUser = session.currentUser else {
            setMessage("Пользователь не авторизован.", isError: true)
            return
        }
        
        let qrInfo = QrInfo(name: currentUser.name, email: currentUser.email)
        
        isLoading = true
        qrImage = nil
        setMessage("Подождите, пока сгенерируется QR-код...", isError: false)
        
        Task(priority: .userInitiated) {
            let result = await MainActor.run {
                self.useCase.generateQR(info: qrInfo)
            }
            
            await MainActor.run {
                self.isLoading = false
                switch result {
                case .success(let image):
                    self.qrImage = image
                    self.setMessage("QR-код успешно сгенерирован.", isError: false)
                case .failure:
                    self.setMessage("Ошибка при генерации QR-кода.", isError: true)
                }
            }
        }
    }
    
    func loadCurrentUser() {
        isLoading = true
        Task {
            do {
                let loadedUser = try await useCase.loadCurrentUser()
                self.user = loadedUser
                session.setUser(loadedUser) // Обновляем пользователя в сессии
                setMessage("Данные пользователя загружены.", isError: false)
            } catch {
                setMessage("Ошибка загрузки пользователя: \(error.localizedDescription)", isError: true)
            }
            isLoading = false
        }
    }
    
    // Обработка результата сканирования
    func processScanResult(_ result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        switch result {
        case .success(let scanResult):
            let details = scanResult.string.components(separatedBy: "\n")
            guard details.count == 2 else {
                setMessage("Ошибка: неверный формат QR-кода.", isError: true)
                return
            }
            let qrInfo = QrInfo(name: details[0], email: details[1])
            fetchScannedUser(qrInfo: qrInfo)
        case .failure(let error):
            setMessage("Сканирование не удалось: \(error.localizedDescription)", isError: true)
        }
    }
    
    // Получение пользователя по QR-коду
    func fetchScannedUser(qrInfo: QrInfo) {
        Task {
            do {
                scannedUser = try await useCase.fetchUser(info: qrInfo)
                isShowingPicker = true
                setMessage("Пользователь найден: \(scannedUser?.name ?? "Неизвестно")", isError: false)
            } catch {
                setMessage("Ошибка поиска пользователя: \(error.localizedDescription)", isError: true)
            }
        }
    }
    
    // Отправка количества напитков
    func sendDrinksCount() {
        guard let currentUser = session.currentUser, currentUser.status == .worker else {
            setMessage("Ошибка: У вас нет прав на выполнение этой операции.", isError: true)
            return
        }
        
        guard let scannedUser = scannedUser else {
            setMessage("Ошибка: Вы не выбрали пользователя.", isError: true)
            return
        }

        let updateInfo = CoffeeUpdateInfo(userID: scannedUser.id, additionalCups: selectedDrinks)
        Task {
            do {
                try await useCase.updateCoffeeCount(info: updateInfo)
                setMessage("Количество напитков успешно обновлено.", isError: false)
            } catch {
                setMessage("Ошибка обновления напитков: \(error.localizedDescription)", isError: true)
            }
        }
    }
    
    private func setMessage(_ text: String, isError: Bool) {
        self.message = text
        self.isError = isError
    }
}
