//
//  UserDataSource.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-17.
//

import UIKit
import CoreImage.CIFilterBuiltins
import FirebaseFirestore

protocol UserDataSourceProtocol {
    func generateQR(info: QrInfo) -> Result<UIImage, Error>
    func loadCurrentUser() async throws -> User
    func fetchUser(info: QrInfo) async throws -> User
    func updateCoffeeCount(info: CoffeeUpdateInfo) async throws
}

class UserDataSource: UserDataSourceProtocol {
    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()
    private let db = Firestore.firestore()
    private let session = SessionManager.shared
    
    // Генерация QR-кода
    func generateQR(info: QrInfo) -> Result<UIImage, Error> {
        filter.message = Data(info.qrContent.utf8)
        if let outputImage = filter.outputImage,
           let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return .success(UIImage(cgImage: cgImage))
        } else {
            return .failure(NSError(domain: "QRGeneration", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unable to generate QR code"]))
        }
    }
    
    // Загрузка текущего пользователя
    func loadCurrentUser() async throws -> User {
        guard let userID = await session.currentUser?.id else {
            throw NSError(domain: "UserData", code: 401, userInfo: [NSLocalizedDescriptionKey: "No user ID found in session."])
        }
        return try await fetchUserByID(userID: userID)
    }
    
    // Поиск пользователя по QrInfo
    func fetchUser(info: QrInfo) async throws -> User {
        let querySnapshot = try await db.collection("users")
            .whereField("name", isEqualTo: info.name)
            .whereField("email", isEqualTo: info.email)
            .getDocuments()
        
        guard let document = querySnapshot.documents.first else {
            throw NSError(domain: "UserData", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"])
        }
        return parseUser(from: document)
    }
    
    // Обновление количества напитков по CoffeeUpdateInfo
    func updateCoffeeCount(info: CoffeeUpdateInfo) async throws {
        let userRef = db.collection("users").document(info.userID)

        try await db.runTransaction { transaction, _ in
            do {
                let snapshot = try transaction.getDocument(userRef)
                let currentCount = snapshot.data()?["coffeeCount"] as? Int ?? 0
                let updatedCount = currentCount + info.additionalCups

                transaction.updateData(["coffeeCount": updatedCount], forDocument: userRef)
                return nil
            } catch {
                print("Error updating coffee count: \(error.localizedDescription)")
                return nil
            }
        }
    }
    
    // Вспомогательный метод для парсинга User
    private func parseUser(from document: DocumentSnapshot) -> User {
        let data = document.data() ?? [:]
        return User(
            id: document.documentID,
            name: data["name"] as? String ?? "",
            email: data["email"] as? String ?? "",
            coffeeCount: data["coffeeCount"] as? Int ?? 0,
            status: UserStatusEnum(rawValue: data["status"] as? String ?? "") ?? .user
        )
    }
    
    private func fetchUserByID(userID: String) async throws -> User {
        let snapshot = try await db.collection("users").document(userID).getDocument()
        guard let data = snapshot.data() else {
            throw NSError(domain: "UserData", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"])
        }
        return parseUser(from: snapshot)
    }
}
