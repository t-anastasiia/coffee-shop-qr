//
//  AuthorizationRepositoryProtocol.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-16.
//

import Foundation

protocol AuthorizationRepositoryProtocol {
    func register(userInfo: UserRegisterInfo) async -> User?
    func login(loginInfo: UserLoginInfo) async -> User?
    func logout()
}
