//
//  ContentView.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-16.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    @StateObject private var authViewModel = AuthorizationViewModel()
    @ObservedObject private var session = SessionManager.shared
    
    var body: some View {
        ZStack {
            if let route = viewModel.currentRoute {
                viewForRoute(route)
                    .transition(.opacity)
                    .ignoresSafeArea(.keyboard)
            }
            
            VStack {
                Spacer()
                if routeShouldShowTabBar() {
                    TabBarView(viewModel: viewModel)
                }
            }
        }
        .onAppear {
            viewModel.start()
        }
        .animation(.default, value: viewModel.currentRoute)
    }
}

extension MainView {
    @ViewBuilder
    private func viewForRoute(_ route: Route) -> some View {
        switch route {
            case .login:
                LoginView(viewModel: authViewModel)
            case .registration:
                RegisterView(viewModel: authViewModel)
            case .home:
                HomeView()
            case .profile:
                ProfileView()
            case .scan:
                ScanView()
            case .qr:
                QrView()
            case .onboarding:
                OnboardingView()
        }
    }
    
    private func routeShouldShowTabBar() -> Bool {
        guard let currentRoute = viewModel.currentRoute else {
            return true
        }
        return currentRoute.shouldShowTabBar
    }
}

#Preview {
    MainView()
}
