//
//  WelcomeView.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/5.
//

import SwiftUI

struct WelcomeView: View {
    
    @State private var selectedSheet: Sheet.SheetType?

    var body: some View {
        NavigationView {
            List {
                WelcomeSectionView()
                
                Banner(bannerID: "ca-app-pub-9174125730777485/9647154992", width: UIScreen.main.bounds.width-50)
                
                PreviousBigAirdropsView()
                
                FAQView()
            }
            .listStyle(.insetGrouped)
            .navigationBarItems(trailing: aboutButton)
            .navigationTitle("Welcome")
            .sheet(item: $selectedSheet) {Sheet(sheetType: $0)}
        }
       
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private var aboutButton: some View {
        Button(action: {
            self.selectedSheet = .about
        } ) {
            Image(systemName: "info.circle")
        }
        .buttonStyle(.bordered)
    }

}
