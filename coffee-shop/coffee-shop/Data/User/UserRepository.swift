//
//  UserRepository.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-17.
//

import UIKit

class UserRepository: UserRepositoryProtocol {
    private let dataSource: UserDataSourceProtocol
    
    init(dataSource: UserDataSourceProtocol = UserDataSource()) {
        self.dataSource = dataSource
    }
    
    func generateQR(info: QrInfo) -> Result<UIImage, Error> {
        let result = dataSource.generateQR(info: info)
        switch result {
        case .success(let image):
            print("QR code generation successful in repository.")
            return .success(image)
        case .failure(let error):
            print("Error generating QR in repository: \(error.localizedDescription)")
            return .failure(error)
        }
    }
    
    func loadCurrentUser() async throws -> User {
        return try await dataSource.loadCurrentUser()
    }

    func fetchUser(info: QrInfo) async throws -> User {
        return try await dataSource.fetchUser(info: info)
    }

    func updateCoffeeCount(info: CoffeeUpdateInfo) async throws {
        try await dataSource.updateCoffeeCount(info: info)
    }
}
