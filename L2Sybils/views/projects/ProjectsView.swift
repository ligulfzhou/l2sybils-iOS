//
//  ProjectsView.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/6.
//

import SwiftUI

struct ProjectsView: View {

    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink(destination: RandomGenerateAccountView()) {
                        Text("zkSync Lite")
                    }
                    NavigationLink(destination: MnemonicAccountView()) {
                        Text("zkSync Era")
                    }
                } header: {
                    SectionHeaderView(text: "zkSync")
                }
            }

            .listStyle(.insetGrouped)

            .navigationTitle("Projects")
        }
    }
}

