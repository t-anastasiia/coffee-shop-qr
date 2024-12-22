//
//  MainViewModel.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-16.
//

import Foundation
import Combine

@MainActor
class MainViewModel: ObservableObject {
    @Published var selectedIndex: TabBarEnum = .home
    @Published var currentRoute: Route? = .home
    @Published var availableTabs: [TabBarEnum] = [.home, .profile]

    private let coordinator = AppCoordinator.shared
    private let session = SessionManager.shared
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        coordinator.currentRoutePublisher
            .receive(on: DispatchQueue.main)
            .assign(to: &$currentRoute)
        
        // Подписка на изменения currentUser в SessionManager
        session.$currentUser
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.configureTabs()
            }
            .store(in: &cancellables)
        

        configureTabs()
    }

    func configureTabs() {
        guard let currentUser = session.currentUser else {
            availableTabs = [.home, .profile]
            return
        }

        availableTabs = [.home]

        if currentUser.status == .worker {
            availableTabs.append(.scanOrQR(isWorker: true))
        } else {
            availableTabs.append(.scanOrQR(isWorker: false))
        }

        availableTabs.append(.profile)
    }
    
    func start() {
        if let _ = SessionManager.shared.currentUser {
            coordinator.start(with: .home) 
        } else if AppLaunchManager.shared.isFirstLaunch() {
            coordinator.start(with: .onboarding(.step1))
        } else {
            coordinator.start(with: .login)
        }
    }
    
    func navigate(to route: Route, allowDuplicates: Bool = false) {
        coordinator.navigate(route, allowDuplicates: allowDuplicates)
    }
}
