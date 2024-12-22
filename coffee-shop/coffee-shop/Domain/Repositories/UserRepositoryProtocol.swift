//
//  UserRepositoryProtocol.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-17.
//

import UIKit

protocol UserRepositoryProtocol {
    func generateQR(info: QrInfo) -> Result<UIImage, Error>
    func loadCurrentUser() async throws -> User
    func fetchUser(info: QrInfo) async throws -> User
    func updateCoffeeCount(info: CoffeeUpdateInfo) async throws
}
