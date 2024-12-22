//
//  AuthorizationUseCase.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-16.
//

import Foundation

protocol AuthorizationUseCaseProtocol {
    func register(userInfo: UserRegisterInfo) async -> Bool
    func login(loginInfo: UserLoginInfo) async -> Bool
    func logout() async
    func getCurrentUser() -> User?
}

class AuthorizationUseCase: AuthorizationUseCaseProtocol {
    private let authorizationRepository: AuthorizationRepositoryProtocol
    
    init(authorizationRepository: AuthorizationRepositoryProtocol) {
        self.authorizationRepository = authorizationRepository
    }
    
    func register(userInfo: UserRegisterInfo) async -> Bool {
        guard let _ = await authorizationRepository.register(userInfo: userInfo) else {
            return false
        }
        return true
    }
    
    func login(loginInfo: UserLoginInfo) async -> Bool {
        guard let _ = await authorizationRepository.login(loginInfo: loginInfo) else {
            return false
        }
        return true
    }
    
    func logout() async {
        await authorizationRepository.logout()
    }
    
    @MainActor
    func getCurrentUser() -> User? {
        return SessionManager.shared.currentUser
    }
}
