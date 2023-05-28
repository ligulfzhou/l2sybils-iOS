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
                    Text("welcome_to_sybil_club")
                        .font(.headline)

                    Text("welcome_description")
                        .font(.system(size: 12))
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
