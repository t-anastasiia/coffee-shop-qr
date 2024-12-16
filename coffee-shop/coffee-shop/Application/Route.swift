//
//  Route.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-17.
//

import Foundation

enum Route: Identifiable, Hashable {
    case registration
    case login
    case home
    case profile
    case scan
    case onboarding(OnboardingStep)
    
    var id: String {
        switch self {
            case .registration:
                return "registration"
            case .login:
                return "login"
            case .home:
                return "home"
            case .profile:
                return "profile"
            case .scan:
                return "scan"
            case .onboarding(let step):
                return "onboarding-\(step.rawValue)"
        }
    }
}

extension Route {
    var shouldShowTabBar: Bool {
        switch self {
            case .registration,
                 .login,
                 .onboarding:
                return false
            default:
                return true
        }
    }
}
