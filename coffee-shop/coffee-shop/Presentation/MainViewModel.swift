//
//  MainViewModel.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-16.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var selectedIndex: TabBarEnum = .home
    @Published var currentRoute: Route? = .home
    
    private let coordinator = AppCoordinator.shared
    
    // Подписка на изменения маршрута в AppCoordinator
    init() {
        coordinator.currentRoutePublisher
            .receive(on: DispatchQueue.main)
            .assign(to: &$currentRoute)
    }
    
    func start() {
        coordinator.start(with: .login)
    }
    
    func navigate(to route: Route, allowDuplicates: Bool = false) {
        coordinator.navigate(route, allowDuplicates: allowDuplicates)
    }
}
