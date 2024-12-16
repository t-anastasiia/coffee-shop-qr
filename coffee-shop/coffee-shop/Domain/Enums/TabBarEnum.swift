//
//  TabBarEnum.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-16.
//

import Foundation

public enum TabBarEnum: String, CaseIterable {
    case home = "house"
    case scan = "qrcode.viewfinder"
    case profile = "person"
    
    var imageName: String {
        return self.rawValue
    }
}
