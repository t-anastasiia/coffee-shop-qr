//
//  OnboardingStep.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-17.
//

import Foundation

public enum OnboardingStep: Int, CaseIterable, Hashable {
    case step1 = 0
    case step2 = 1
    case step3 = 2
    
    var description: String {
        switch self {
            case .step1: return "Добро пожаловать в Coffee Shop!"
            case .step2: return "Лучший кофе — здесь!"
            case .step3: return "Начни свой день с нами!"
        }
    }
}
