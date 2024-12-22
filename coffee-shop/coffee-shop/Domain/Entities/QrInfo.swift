//
//  QrInfo.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-17.
//

import Foundation

struct QrInfo {
    let name: String
    let email: String
    
    var qrContent: String {
        return "\(name)\n\(email)"
    }
}
