//
//  MnemonicAccountView.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/7.
//

import SwiftUI
import MarkdownUI

struct MnemonicAccountView: View {
    
    
    private let mnemonicCode = """
```python3
# generate mnemonic code
from eth_account import Account
Account.enable_unaudited_hdwallet_features()

def gen_mnemonic_code() -> str:
    _, mnemonic = Account.create_with_mnemonic()
    return mnemonic
```
"""
    
    private let mnemonicAccountCode = """
```python3
# generate private key from mnemonic code
from eth_account import Account
from eth_account.signers.local import LocalAccount
from eth_account.hdaccount import ETHEREUM_DEFAULT_PATH

rpc_url = 'https://mainnet.infura.io/v3/<your-infura-key>'
w3 = Web3(Web3.HTTPProvider(rpc_url))
w3.eth.account.enable_unaudited_hdwallet_features()

def from_mnemonic(mnemonic: str, idx: int = 0) -> LocalAccount:
    account: LocalAccount = w3.eth.account.from_mnemonic(
        mnemonic,
        account_path=f'{ETHEREUM_DEFAULT_PATH}/{idx}'
    )
    return account
```
"""
    var body: some View {
        VStack(alignment: .leading, content: {
            
            List {
                Section {
                    Markdown(mnemonicCode)
                        .markdownTheme(.gitHub)
                } header: {
                    SectionHeaderView(text: "generate_mnemonic")
                }
                
                Banner(bannerID: "ca-app-pub-9174125730777485/9647154992", width: UIScreen.main.bounds.width-50)
                            
                Section {
                    Markdown(mnemonicAccountCode)
                        .markdownTheme(.gitHub)
                } header: {
                    SectionHeaderView(text: "generate_from_mnemonic")
                }
            }
            .listStyle(.grouped)
            

            Spacer()
        })
        .navigationTitle("mnemonic_code")
    }
}

struct MnemonicAccountView_Previews: PreviewProvider {
    static var previews: some View {
        MnemonicAccountView()
    }
}
