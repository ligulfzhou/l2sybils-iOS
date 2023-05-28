//
//  AccountsView.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/5.
//

import SwiftUI

struct AccountsView: View {
    var body: some View {

        NavigationView {
            List {
                Section {
                    NavigationLink(destination: RandomGenerateAccountView()) {
                        Text("Random")
                    }
                    NavigationLink(destination: MnemonicAccountView()) {
                        Text("Mnemonic Code")
                    }
                } header: {
                    SectionHeaderView(text: "Generate")
                }
                                
                Section {
                    NavigationLink(destination: DistributeETHfromOKX()) {
                        Text("From Okx")
                    }
                    NavigationLink(destination: DistributeETHfromBinance()) {
                        Text("From Binance")
                    }
                } header: {
                    SectionHeaderView(text: "Distribute ETH")
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Account")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

