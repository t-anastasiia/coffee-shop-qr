//
//  UserRegisterInfo.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-16.
//

import Foundation

public struct UserRegisterInfo {
    public let name: String
    public let email: String
    public let password: String
    public let status: UserStatusEnum
    
    public init(name: String, email: String, password: String, status: UserStatusEnum) {
        self.name = name
        self.email = email
        self.password = password
        self.status = status
    }
}
