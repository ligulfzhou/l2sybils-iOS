//
//  WelcomeView.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/5.
//

import SwiftUI

struct WelcomeView: View {
    
    var body: some View {
        NavigationView {
            List {
                WelcomeSectionView()
                    .listRowBackground(Color.gray)
                
                PreviousBigAirdropsView()
                    .listRowBackground(Color.gray)
                
                FAQView()
                    .listRowBackground(Color.gray)
            }

            .listStyle(.insetGrouped)

            .navigationTitle("Welcome")
        }
    }
    
}
