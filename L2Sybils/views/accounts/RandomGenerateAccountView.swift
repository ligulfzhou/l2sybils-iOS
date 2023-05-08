//
//  RandomGenerateAccountView.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/7.
//

import SwiftUI
import MarkdownUI

struct RandomGenerateAccountView: View {
    
    private var text: String  = """
```python3
# First of ALL, you need accounts
import secrets
from eth_account import Account
from eth_account.signers.local import LocalAccount

def generate_random_account()-> LocalAccount:
    # or simply return Account.create()
    return Account.from_key(f'0x{secrets.token_hex(32)}')
```

"""
    var body: some View {
        
        VStack {

            Markdown(text)
                .markdownTheme(.gitHub)
            
            HStack(alignment: .center) {
                Button {
                    print("asdfasdf")
                } label: {
                    Text("Run")
                }
            }
            Spacer()
            
            
        }
        .navigationTitle("Random")
    }
}

struct RandomGenerateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        RandomGenerateAccountView()
    }
}
