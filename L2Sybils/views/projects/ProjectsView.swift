//
//  ProjectsView.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/6.
//

import SwiftUI


enum Tabs: String, CaseIterable, CustomStringConvertible {
    case zksynclite, zksyncera
        
    var description: String {
        switch self {
        case .zksynclite:
            return "zkSync Lite"
        case .zksyncera:
            return "zkSync Era"
        }
    }
}



struct ProjectsView: View {

    @State private var selectedTab: Tabs = .zksynclite
    
    var body: some View {
        NavigationView {
            List {
                Section(content: {
                    NavigationLink(destination: RandomGenerateAccountView()) {
                       Text("zkSync Lite")
                   }
                   NavigationLink(destination: MnemonicAccountView()) {
                       Text("zkSync Era")
                   }
                }, header: {
                    picker
                })
            }

            .listStyle(.insetGrouped)

            .navigationTitle("Projects")
        }
    }
    
    private var picker: some View {
        Picker(selection: $selectedTab, label: Text("")) {
            ForEach(Tabs.allCases, id: \.self) { tab in
                Text(tab.description)
//                Text(LocalizedStringKey(tab.rawValue.capitalized)).textCase(nil)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }

}

