//
//  L2SybilsApp.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/4.
//

import SwiftUI

@main
struct L2SybilsApp: App {
    
    @StateObject private var uiState = UIState.shared
    
    @SceneBuilder
    var body: some Scene {
        WindowGroup {
            contentView
        }
    }

    private var contentView: some View {
        TabbarView()
            .environmentObject(uiState)
            .onAppear(perform: setupAppearance)
        
    }
    
    private func setupAppearance() {
        
    }
}
