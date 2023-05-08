//
//  WelcomeSectionView.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/5.
//

import SwiftUI

struct WelcomeSectionView: View {
    
    var body: some View {
        Section {
            HStack {
                VStack(alignment: .leading, content: {
                    Text("Welcome to Airdrop Sybil club!")
                        .font(.headline)
//                        .foregroundColor(.white)
                    
                    Text("Learn to be an Airdrop Hunter or even an Airdrop Sybil, Get your hands dirty, and finally make your fortune.")
                        .font(.system(size: 12))
                    
                    
                    Button("started") {
                        print("get started.....")
                    }
                })
               
                Spacer()
                
                VStack {
                    Image("app")
                        .resizable()
                        .frame(width: 60, height: 60)
                }
            }
        } header: {
            SectionHeaderView(text: "Welcome")
        }
    }
}
