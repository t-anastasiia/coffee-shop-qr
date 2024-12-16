//
//  AuthorizationDataSource.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-16.
//

import FirebaseAuth
import FirebaseFirestore

protocol AuthorizationDataSourceProtocol {
    func register(userInfo: UserRegisterInfo) async throws -> User
    func login(loginInfo: UserLoginInfo) async throws -> User
    func logout() throws
}

struct AuthorizationDataSource: AuthorizationDataSourceProtocol {
    
    private let db = Firestore.firestore()
    
    func register(userInfo: UserRegisterInfo) async throws -> User {
        let authResult = try await Auth.auth().createUser(withEmail: userInfo.email, password: userInfo.password)
        
        let uid = authResult.user.uid
        
        let user = User(id: uid, name: userInfo.name, email: userInfo.email, coffeeCount: 0, status: userInfo.status)
        
        try await db.collection("users").document(uid).setData([
            "name": user.name,
            "email": user.email,
            "coffeeCount": user.coffeeCount,
            "status": user.status.rawValue
        ])
        
        return user
    }
    
    func login(loginInfo: UserLoginInfo) async throws -> User {
        let authResult = try await Auth.auth().signIn(withEmail: loginInfo.email, password: loginInfo.password)
        let uid = authResult.user.uid
        
        let document = try await db.collection("users").document(uid).getDocument()
        
        guard let data = document.data(),
              let name = data["name"] as? String,
              let email = data["email"] as? String,
              let coffeeCount = data["coffeeCount"] as? Int,
              let statusRaw = data["status"] as? String,
              let status = UserStatusEnum(rawValue: statusRaw) else {
            throw NSError(domain: "Login", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to retrieve user data"])
        }
        
        return User(id: uid, name: name, email: email, coffeeCount: coffeeCount, status: status)
    }
    
    func logout() throws {
        try Auth.auth().signOut()
    }
}
