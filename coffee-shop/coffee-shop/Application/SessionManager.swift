//
//  SessionManager.swift
//  exhale
//
//  Created by Анастасия Талмазан on 2024-12-16.
//

import Foundation

@MainActor
final class SessionManager: ObservableObject {
    static let shared = SessionManager()
    
    private let userDefaultsKey = "currentUser"
    
    private init() {
        loadUserFromDefaults()
    }
    
    @Published var currentUser: User? = nil
    @Published var isTabBarVisible: Bool = true
    
    // Установка пользователя и сохранение в UserDefaults
    func setUser(_ user: User?) {
        currentUser = user
        if let user = user {
            saveUserToDefaults(user)
        } else {
            clearUserDefaults()
        }
    }
    
    // Очистка сессии пользователя
    func clearUser() {
        currentUser = nil
        clearUserDefaults()
    }
    
    // Сохранение пользователя в UserDefaults
    private func saveUserToDefaults(_ user: User) {
        if let encodedUser = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encodedUser, forKey: userDefaultsKey)
        }
    }
    
    // Загрузка пользователя из UserDefaults
    private func loadUserFromDefaults() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let savedUser = try? JSONDecoder().decode(User.self, from: data) {
            currentUser = savedUser
        }
    }
    
    // Очистка UserDefaults
    private func clearUserDefaults() {
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
    }
}
