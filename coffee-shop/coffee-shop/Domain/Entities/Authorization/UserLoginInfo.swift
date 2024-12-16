//
//  UserLoginInfo.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-16.
//

import Foundation

public struct UserLoginInfo {
    public let email: String
    public let password: String
    
    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
