//
//  User.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-16.
//

import Foundation

public struct User {
    public let name: String
    public let email: String
    public let coffeeCount: Int
    
    init(name: String, email: String, coffeeCount: Int) {
        self.name = name
        self.email = email
        self.coffeeCount = coffeeCount
    }
}
