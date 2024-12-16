//
//  TabBarView.swift
//  coffee-shop
//
//  Created by Анастасия Талмазан on 2024-12-16.
//

import SwiftUI

struct TabBarView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        HStack {
            tabBarIcons
        }
        .padding(.top, 13)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .overlay(alignment: .top) {
            Divider()
        }
    }
}

extension TabBarView {
    var tabBarIcons: some View {
        ForEach(TabBarEnum.allCases, id: \.self) { tabType in
            Button {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0.5)) {
                    viewModel.selectedIndex = tabType
                }
            } label: {
                Spacer()
                Image(systemName: tabType.imageName)
                    .font(.system(size: tabType == .scan ? 31 : 20))
                    .foregroundColor(tabType == viewModel.selectedIndex ? .accentColor : .gray)
                    .scaleEffect(viewModel.selectedIndex == tabType ? 1.2 : 1.0)
                Spacer()
            }
        }
    }
}

#Preview {
    TabBarView(viewModel: MainViewModel())
}
