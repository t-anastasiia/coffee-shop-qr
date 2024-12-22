//
//  UserUseCase.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-17.
//

import Foundation

import UIKit

protocol UserUseCaseProtocol {
    func generateQR(info: QrInfo) -> Result<UIImage, Error>
    func loadCurrentUser() async throws -> User
    func fetchUser(info: QrInfo) async throws -> User
    func updateCoffeeCount(info: CoffeeUpdateInfo) async throws
}

class UserUseCase: UserUseCaseProtocol {
    private let repository: UserRepositoryProtocol
    
    init(repository: UserRepositoryProtocol = UserRepository()) {
        self.repository = repository
    }
    
    func generateQR(info: QrInfo) -> Result<UIImage, Error> {
        return repository.generateQR(info: info)
    }
    
    func loadCurrentUser() async throws -> User {
        return try await repository.loadCurrentUser()
    }
    
    func fetchUser(info: QrInfo) async throws -> User {
        return try await repository.fetchUser(info: info)
    }

    func updateCoffeeCount(info: CoffeeUpdateInfo) async throws {
        try await repository.updateCoffeeCount(info: info)
    }
}
