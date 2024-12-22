//
//  AuthorizationRepository.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-16.
//

import Foundation

struct AuthorizationRepository: AuthorizationRepositoryProtocol {
    private let dataSource: AuthorizationDataSourceProtocol
    
    init(dataSource: AuthorizationDataSourceProtocol = AuthorizationDataSource()) {
        self.dataSource = dataSource
    }
    
    func register(userInfo: UserRegisterInfo) async -> User? {
        do {
            let user = try await dataSource.register(userInfo: userInfo)
            await SessionManager.shared.setUser(user)
            print("User registered: \(user)")
            return user
        } catch {
            print("Registration failed: \(error.localizedDescription)")
            return nil
        }
    }
    
    func login(loginInfo: UserLoginInfo) async -> User? {
        do {
            let user = try await dataSource.login(loginInfo: loginInfo)
            await SessionManager.shared.setUser(user)
            print("User logged in: \(user)")
            return user
        } catch {
            print("Login failed: \(error.localizedDescription)")
            return nil
        }
    }
    
    func logout() async {
        do {
            try dataSource.logout()
            await SessionManager.shared.clearUser()
            print("User logged out successfully")
        } catch {
            print("Logout failed: \(error.localizedDescription)")
        }
    }
}
