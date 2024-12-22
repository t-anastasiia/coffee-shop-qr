//
//  User.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-16.
//

import Foundation

public struct User: Codable {
    public let id: String
    public let name: String
    public let email: String
    public let coffeeCount: Int
    public let status: UserStatusEnum

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case coffeeCount
        case status
    }
    
    public init(id: String, name: String, email: String, coffeeCount: Int, status: UserStatusEnum) {
        self.id = id
        self.name = name
        self.email = email
        self.coffeeCount = coffeeCount
        self.status = status
    }
}
