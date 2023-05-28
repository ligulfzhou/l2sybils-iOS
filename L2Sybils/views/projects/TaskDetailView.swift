//
//  TaskDetailView.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/9.
//

import SwiftUI
import MarkdownUI

struct TaskDetailView: View {
    let task: Task
    @State var showSafari = false

    var body: some View {
        List {
            HStack(alignment: .center) {
                Spacer()
                Image(task.icon)
                    .resizable()
                    .frame(width: 32, height: 32)
                    .cornerRadius(12)
                    .shadow(radius: 12)
                Spacer()
            }
            .padding()
            
            HStack(alignment: .bottom, content: {
                Text("Name")
                Spacer()
                Text(LocalizedStringKey(task.name))
            })

            if let site = task.site {
                HStack(alignment: .center, content: {
                    Text("Site")
                    Spacer()
                    Button {
                        self.showSafari = true
                    } label: {
                        Text(site)
                    }
                    .sheet(isPresented: $showSafari) {
                        SafariView(url: URL(string: site)!)
                    }
                })
            }
            
            if let doc = task.doc {
                HStack(alignment: .center, content: {
                    Text("Doc")
                    Spacer()
                    Button {
                        self.showSafari = true
                    } label: {
                        Text(doc)
                    }
                    .sheet(isPresented: $showSafari) {
                        SafariView(url: URL(string: doc)!)
                    }
                   
                })
            }

            Banner(bannerID: "ca-app-pub-9174125730777485/9647154992", width: UIScreen.main.bounds.width-50)

            if (task.code != nil) {
                Section {
                    Markdown(task.code ?? "")
                        .markdownTheme(.gitHub)
                    
                } header: {
                    SectionHeaderView(text: "Code")
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationBarTitle(Text(LocalizedStringKey(task.name)), displayMode: .automatic)
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TaskDetailView(task: Task(
                name: "Activate",
                icon: "zksync",
                code: """
    ```python3
    # deposit eth from Ethereum mainnet to zkSync Lite
    from eth_account.signers.local import LocalAccount
    from eth_account.datastructures import SignedTransaction
    from web3.types import TxReceipt

    def deposit_to_zksync_lite(account: LocalAccount, value_in_wei: int)-> bool:
        contract_address = '0xaBEA9132b05A70803a4E85094fD0e1800777fBEF'
        contract=w3.eth.contract(address=contract_address, abi=lite_abi)
        nonce = w3.eth.get_transaction_count(account.address)
        gas_price = w3.eth.gas_price
        tx = contract.functions.depositETH(
            account.address
        ).build_transaction({
            'from': Web3.to_checksum_address(account.address),
            'value': value_in_wei,
            'nonce': nonce,
            'gas': gas,
            'gasPrice': gas_price
        })
        
        signed_tx = w3.eth.account.sign_transaction(tx, account.key)
        h = w3.eth.send_raw_transaction(signed_tx.rawTransaction)
        r: TxReceipt = w3.eth.wait_for_transaction_receipt(h)
        if r.status:
            return True
        return False
    ```
    """,
                doc: "https://docs.zksync.io/api/sdk/python/tutorial/#unlocking-zksync-account"
            ))
        }
    }
}
