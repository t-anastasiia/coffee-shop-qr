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
            
        VStack(spacing: 20) {
            VStack(spacing: 20) {
                GeometryReader { geometry in
                    
                    let designSize: CGFloat = 945.2
                    
                    let imageWidth = geometry.size.width + 16
                    let scaleFactor = imageWidth / designSize
                    
                    let baseOffset = (designSize / 2) * scaleFactor
                    let stepOffset = designSize * scaleFactor
                    let computedOffset = baseOffset + CGFloat(viewModel.currentStep.rawValue) * stepOffset
                    
                    ZStack {
                        Image("Onboarding/onboarding_reel")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                    .offset(x: -computedOffset, y: 0)
                    .animation(.easeInOut, value: viewModel.currentStep)
                    .frame(height: designSize * scaleFactor)
                    .padding(.horizontal, -16)
                    .padding(.top, 8)
                }
                
                Text(viewModel.currentStep.description)
                    .font(.system(size: 24, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color("LoginBg"))
                    .frame(maxWidth: .infinity)
                    .animation(.easeInOut, value: viewModel.currentStep)
                    .padding(.bottom, 50)
            }
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(.accent)
            )
            
            
            HStack {
                
                Spacer()
                
                Button {
                    viewModel.next()
                } label: {
                    Text("Next")
                        .foregroundStyle(Color("LoginBg"))
                        .bold()
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
                Text("Skip")
                    .italic()
            }
        }
        .padding(EdgeInsets(top: 20,
                            leading: 16, 
                            bottom: 20, 
                            trailing: 16))
    }
}

#Preview {
    OnboardingView()
}
