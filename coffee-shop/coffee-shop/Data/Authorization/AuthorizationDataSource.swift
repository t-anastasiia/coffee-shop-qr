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
        // Создаем пользователя в Firebase Authentication
        let authResult = try await Auth.auth().createUser(withEmail: userInfo.email, password: userInfo.password)
        let uid = authResult.user.uid

        let user = User(id: uid, name: userInfo.name, email: userInfo.email, coffeeCount: 0, status: userInfo.status)
        let userRef = db.collection("users").document(uid)
        
        // Проверка существования пользователя в Firestore
        let document = try await userRef.getDocument()
        if document.exists {
            print("User already exists in Firestore.")
            throw NSError(domain: "Registration", code: 0, userInfo: [NSLocalizedDescriptionKey: "User already exists in Firestore."])
        }
        
        // Добавление пользователя в Firestore
        do {
            try await userRef.setData([
                "name": user.name,
                "email": user.email,
                "coffeeCount": user.coffeeCount,
                "status": user.status.rawValue
            ])
        } catch {
            print("Error adding user to Firestore: \(error.localizedDescription)")
            throw error
        }
        
        return user
    }
    
    func login(loginInfo: UserLoginInfo) async throws -> User {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: loginInfo.email, password: loginInfo.password)
            let uid = authResult.user.uid
            
            print("User authenticated successfully. UID: \(uid)")
            
            let document = try await db.collection("users").document(uid).getDocument()
            
            if !document.exists {
                print("Document for user \(uid) does not exist in Firestore.")
                throw NSError(domain: "Login", code: 0, userInfo: [NSLocalizedDescriptionKey: "User document not found in database."])
            }
            
            guard let data = document.data(),
                  let name = data["name"] as? String,
                  let email = data["email"] as? String,
                  let coffeeCount = data["coffeeCount"] as? Int,
                  let statusRaw = data["status"] as? String,
                  let status = UserStatusEnum(rawValue: statusRaw) else {
                print("Invalid user data format for UID: \(uid)")
                throw NSError(domain: "Login", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to parse user data."])
            }
            
            print("User data retrieved successfully: \(data)")
            return User(id: uid, name: name, email: email, coffeeCount: coffeeCount, status: status)
            
        } catch let error {
            print("Login failed with error: \(error.localizedDescription)")
            throw error
        }
    }
    
    func logout() throws {
        try Auth.auth().signOut()
    }
}
