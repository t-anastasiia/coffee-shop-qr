//
//  OnboardingViewModel.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-17.
//

import Foundation

class OnboardingViewModel: ObservableObject {
    @Published var currentRoute: Route? = .home
    
    @Published private(set) var currentStep: OnboardingStep = .step1
    
    private let coordinator = AppCoordinator.shared
    
    init() {
        coordinator.currentRoutePublisher
            .receive(on: DispatchQueue.main)
            .assign(to: &$currentRoute)
    }
    
    // Переход на следующий шаг
    func next() {
        if let nextStep = getNextStep(from: currentStep) {
            navigate(to: nextStep)
        } else {
            coordinator.navigate(.login, allowDuplicates: false) // Завершение онбординга
        }
    }
    
    // Возврат к предыдущему шагу
    func back() {
        if let previousStep = getPreviousStep(from: currentStep) {
            navigate(to: previousStep)
        } else {
            coordinator.back()
        }
    }
    
    // Пропуск онбординга
    func skip() {
        coordinator.navigate(.login, allowDuplicates: false) // Пропуск сразу к логину
    }
    
    // Навигация к конкретному шагу
    func navigate(to step: OnboardingStep) {
        currentStep = step
        coordinator.navigate(.onboarding(step), allowDuplicates: false)
    }
    
    // Получение следующего шага
    private func getNextStep(from step: OnboardingStep) -> OnboardingStep? {
        guard let currentIndex = OnboardingStep.allCases.firstIndex(of: step),
              currentIndex + 1 < OnboardingStep.allCases.count else { return nil }
        return OnboardingStep.allCases[currentIndex + 1]
    }

    // Получение предыдущего шага
    private func getPreviousStep(from step: OnboardingStep) -> OnboardingStep? {
        guard let currentIndex = OnboardingStep.allCases.firstIndex(of: step),
              currentIndex > 0 else { return nil }
        return OnboardingStep.allCases[currentIndex - 1]
    }
}
