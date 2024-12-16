//
//  OnboardingView.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-17.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 255)
            
            Spacer()
            
            HStack {
                Image(loadingImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)
                
                Spacer()
                
                Button {
                    viewModel.next()
                } label: {
                    Text("Далее")
                        .foregroundStyle(.white)
                        .padding(EdgeInsets(top: 20,
                                            leading: 54,
                                            bottom: 20,
                                            trailing: 54))
                        .background (
                            RoundedRectangle(cornerRadius: 22)
                        )
                }
            }
            
            
        }
        .padding(EdgeInsets(top: 64,
                            leading: 16,
                            bottom: 21,
                            trailing: 16))
        .background(Color("LoginBg"))
        .overlay(alignment: .top) {
            navBar
        }
    }
}

extension OnboardingView {
    
    var navBar: some View {
        HStack {
            if viewModel.currentStep != .step1 {
                Button {
                    viewModel.back()
                } label: {
                    Image(systemName: "chevron.left")
                }
            }
            
            Spacer()
            
            Button {
                viewModel.skip()
            } label: {
                Text("Пропустить")
            }
        }
        .padding(EdgeInsets(top: 20,
                            leading: 16, 
                            bottom: 20, 
                            trailing: 16))
    }
    
    var loadingImageName: String {
        var name = "Onboarding/"
        switch viewModel.currentStep {
            case .step1:
                name += "beens1"
            case .step2:
                name += "beens2"
            case .step3:
                name += "beens3"
        }
        return name
    }
    
    private var imageName: String {
        var name = "Onboarding/"
        switch viewModel.currentStep {
            case .step1:
                name += "img1"
            case .step2:
                name += "img2"
            case .step3:
                name += "img3"
        }
        return name
    }
}

#Preview {
    OnboardingView()
}
