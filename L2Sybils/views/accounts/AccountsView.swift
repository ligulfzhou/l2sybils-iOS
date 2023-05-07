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
                    NavigationLink(destination: RandomGenerateAccountView()) {
                        Text("Mnemonic Code")
                    }

                } header: {
                    SectionHeaderView(text: "Generate")
                }
                
                Section {
                    NavigationLink(destination: RandomGenerateAccountView()) {
                        Text("From Okx")
                    }
                    NavigationLink(destination: RandomGenerateAccountView()) {
                        Text("From Binance")
                    }
                } header: {
                    SectionHeaderView(text: "Distribute ETH")
                }
            }

            .listStyle(.insetGrouped)

            .navigationTitle("Account")
        }
    }
}

