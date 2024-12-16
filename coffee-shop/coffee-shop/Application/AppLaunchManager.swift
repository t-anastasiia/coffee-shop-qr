//
//  AppLaunchManager.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-17.
//

import SwiftUI

class AppLaunchManager {
    static let shared = AppLaunchManager()
    
    private init() {}
    
    private let firstLaunchKey = "isFirstLaunch"
    
    // Проверка первого запуска
    func isFirstLaunch() -> Bool {
        #if DEBUG
        return true // Всегда возвращать первый запуск в режиме Debug
        #else
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: firstLaunchKey)
        
        if isFirstLaunch {
            // Устанавливаем флаг после первого запуска
            UserDefaults.standard.set(true, forKey: firstLaunchKey)
        }
        
        return isFirstLaunch
        #endif
    }
    
    // Сброс флага (для тестирования)
    func resetFirstLaunchFlag() {
        UserDefaults.standard.removeObject(forKey: firstLaunchKey)
    }
}
