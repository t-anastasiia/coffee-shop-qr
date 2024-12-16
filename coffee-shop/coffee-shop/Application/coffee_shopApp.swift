//
//  coffee_shopApp.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-16.
//

import SwiftUI

@main
struct coffee_shopApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
