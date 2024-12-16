//
//  SessionManager.swift
//  exhale
//
//  Created by Анастасия Талмазан on 2024-12-16.
//

import Foundation

final class SessionManager: ObservableObject {
    static let shared = SessionManager()
    
    private init() {}
    
    @Published var currentUser: User? = nil
    @Published var isTabBarVisible: Bool = true
    
    func setUser(_ user: User?) {
        currentUser = user
    }
    
    func clearUser() {
        currentUser = nil
    }
}
