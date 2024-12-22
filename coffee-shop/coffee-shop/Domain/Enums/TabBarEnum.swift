//
//  TabBarEnum.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-16.
//

import Foundation

enum TabBarEnum: Hashable {
    case home
    case scanOrQR(isWorker: Bool)
    case profile
    
    var imageName: String {
        switch self {
        case .home: return "house"
        case .scanOrQR(let isWorker): return isWorker ? "qrcode.viewfinder" : "qrcode"
        case .profile: return "person"
        }
    }
    
    var route: Route {
        switch self {
        case .home: return .home
        case .scanOrQR(let isWorker): return isWorker ? .scan : .qr
        case .profile: return .profile
        }
    }
}
