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
                        Text("random")
                    }
                    NavigationLink(destination: MnemonicAccountView()) {
                        Text("mnemonic_code")
                    }
                } header: {
                    SectionHeaderView(text: "generate")
                }
                                
                Section {
                    NavigationLink(destination: DistributeETHfromOKX()) {
                        Text("from_okx")
                    }
                    NavigationLink(destination: DistributeETHfromBinance()) {
                        Text("from_binance")
                    }
                } header: {
                    SectionHeaderView(text: "distribute_eth")
                }
                
                Banner(bannerID: "ca-app-pub-9174125730777485/9647154992", width: UIScreen.main.bounds.width-50)
            }
            .listStyle(.insetGrouped)
            .navigationTitle("account")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

