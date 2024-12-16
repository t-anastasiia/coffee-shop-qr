//
//  String+Extention.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-16.
//

import Foundation

extension String {
    private static let emailMask = "^([\\w.\\-]+)@([\\w\\-]+)((\\.(\\w){2,3})+)$"
    
    var isValidEmail: Bool {
        let regex = try? NSRegularExpression(pattern: String.emailMask)
        let range = NSRange(location: 0, length: utf16.count)
        let match = regex?.firstMatch(in: self, options: [], range: range)
        return match != nil
    }
}
