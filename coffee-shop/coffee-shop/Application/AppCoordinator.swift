//
//  AppCoordinator.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-17.
//

import SwiftUI
import Combine

protocol CoordinatorProtocol: Navigator {
    var navigationPathPublisher: Published<NavigationPath>.Publisher { get }
    var currentRoutePublisher: Published<Route?>.Publisher { get }
    var currentRoute: Route? { get }
    func start(with route: Route?)
}

protocol Navigator {
    func navigate(_ route: Route, allowDuplicates: Bool)
    func back()
    func backToRoot()
    func backToView(at index: Int)
}

final class AppCoordinator: CoordinatorProtocol, ObservableObject {
    static let shared = AppCoordinator()

    @Published private(set) var navigateStack: [Route] = []
    @Published var navigationPath = NavigationPath()
    @Published var currentRoute: Route?

    var navigationPathPublisher: Published<NavigationPath>.Publisher { $navigationPath }
    var currentRoutePublisher: Published<Route?>.Publisher { $currentRoute }

    private init() {}

    func start(with route: Route? = nil) {
        backToRoot()
        if let route = route {
            navigate(route)
        } else {
            navigate(.login)
        }
    }

    func navigate(_ route: Route, allowDuplicates: Bool = true) {
        if !allowDuplicates, let index = navigateStack.firstIndex(of: route) {
            backToView(at: index)
        } else {
            navigateStack.append(route)
            navigationPath.append(route)
            currentRoute = route
        }
    }

    func back() {
        if !navigateStack.isEmpty {
            navigateStack.removeLast()
            navigationPath.removeLast()
            currentRoute = navigateStack.last
        }
    }

    func backToRoot() {
        navigateStack.removeAll()
        navigationPath = NavigationPath()
        currentRoute = nil
    }

    func backToView(at index: Int) {
        guard index >= 0, index < navigateStack.count else { return }
        navigateStack = Array(navigateStack.prefix(index + 1))
        navigationPath = NavigationPath(navigateStack)
        currentRoute = navigateStack.last
    }
}
