//
//  DistributeETHfromOKX.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/7.
//

import SwiftUI
import MarkdownUI

struct DistributeETHfromOKX: View {
    private var text: String  = """
```python3
# distribute eth from okx
from okx import Funding
api_key = "<YOUR-API-KEY>"
secret_key = "<YOUR-SECRET-KEY>"
passphrase = "<YOUR-PASSPHRASE>"

fundingAPI = Funding.FundingAPI(api_key, secret_key, passphrase, False, flag)

# withdraw eth in ether
withdraw_eth = "1"

# withdraw to zkSync lite
res = fundingAPI.withdrawal("ETH", withdraw_eth, "4", address, "0.0002", "ETH-zkSync Lite")

# withdraw to ethereum mainnet
res = fundingAPI.withdrawal("ETH", withdraw_eth, "4", address, "0.001456")
```

"""
    var body: some View {
        
        VStack {
            Banner(bannerID: "ca-app-pub-9174125730777485/9647154992", width: UIScreen.main.bounds.width-50)

            Markdown(text)
                .markdownTheme(.gitHub)
            
            Spacer()
            
        }
        .navigationTitle("distribute_eth")
    }
}

struct DistributeETHfromOKX_Previews: PreviewProvider {
    static var previews: some View {
        DistributeETHfromOKX()
    }
}
