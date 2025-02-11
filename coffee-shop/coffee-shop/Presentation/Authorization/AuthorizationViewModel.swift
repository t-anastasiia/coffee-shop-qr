//
//  AuthorizationViewModel.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-16.
//

import Foundation

@MainActor
class AuthorizationViewModel: ObservableObject {
    private let useCase: AuthorizationUseCaseProtocol
    private let coordinator = AppCoordinator.shared

    // MARK: - Published Properties
    @Published var currentUser: User? = nil
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    @Published var currentRoute: Route? = .login
    
    // MARK: - Input Fields
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    // MARK: - Init
    init(useCase: AuthorizationUseCaseProtocol = AuthorizationUseCase(authorizationRepository: AuthorizationRepository())) {
        self.useCase = useCase
        self.currentUser = useCase.getCurrentUser()
        
        coordinator.currentRoutePublisher
            .receive(on: DispatchQueue.main)
            .assign(to: &$currentRoute)
    }
    
    // MARK: - Registration
    func register() {
        Task {
            isLoading = true
            let userInfo = UserRegisterInfo(name: self.name, email: self.email, password: self.password, status: .user)
            let success = await useCase.register(userInfo: userInfo)
            
            if success {
                self.currentUser = useCase.getCurrentUser()
                self.errorMessage = nil
                DispatchQueue.main.async {
                    AppCoordinator.shared.navigate(.home, allowDuplicates: false)
                }
            } else {
                self.errorMessage = "Registration failed. Please try again."
            }
            isLoading = false
        }
    }
    
    // MARK: - Login
    func login() {
        Task {
            isLoading = true
            let loginInfo = UserLoginInfo(email: self.email, password: self.password)
            let success = await useCase.login(loginInfo: loginInfo)
            
            if success {
                self.currentUser = useCase.getCurrentUser()
                self.errorMessage = nil
                DispatchQueue.main.async {
                    AppCoordinator.shared.navigate(.home, allowDuplicates: false)
                }
            } else {
                self.errorMessage = "Login failed. Please check your email and password."
            }
            isLoading = false
        }
    }
    
    // MARK: - Logout
    func logout() async {
        await useCase.logout()
        currentUser = nil
        navigate(to: .login)
    }
    
    // MARK: - Navigation Methods
    func navigate(to route: Route) {
        coordinator.navigate(route)
    }
    
    func back() {
        coordinator.back()
    }
}
