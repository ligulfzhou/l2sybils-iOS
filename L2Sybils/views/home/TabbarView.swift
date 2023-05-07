//
//  TabbarView.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/5.
//

import SwiftUI

struct TabbarView: View {
    @EnvironmentObject private var uiState: UIState
    @ObservedObject private var viewModel = TabbarViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $uiState.selectedTab) {
                WelcomeView()
                    .tabItem {
                        Image("welcome")
                        Text("welcome")
                    }
                    .tag(UIState.Tab.welcome)
                
                AccountsView()
                    .tabItem {
                        Image("welcome")
                        Text("accounts")
                    }
                    .tag(UIState.Tab.accounts)
                
                ProjectsView()
                    .tabItem {
                        Image("welcome")
                        Text("projects")
                    }
                    .tag(UIState.Tab.projects)
            }
            .environment(\.currentDate, viewModel.currentDate)
            
        }
    }
}
