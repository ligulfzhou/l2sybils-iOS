//
//  DistributeETHfromBinance.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/7.
//

import SwiftUI
import MarkdownUI

struct DistributeETHfromBinance: View {
    
    private let code: String = """
```python3
import time
import requests
from binance.spot import Spot

# https://binance-docs.github.io/apidocs/spot/cn/#1f6f90f1a7
# https://binance-connector.readthedocs.io/en/latest/
# pip install binance-connector
class Binacce:

    def __init__(self):
        self.client = Spot(api_key='Your Api Key',
                           api_secret='Your Api Secret')

    def withdraw2(self, amount, toAds):
        data = {
            "coin": "ETH",
            "address": toAds,
            "amount": amount,
        }
        response = self.client.withdraw(**data)
        print(response)


Binacce().withdraw2("0.1", "0x...")
```
"""
    var body: some View {
        VStack {

            Markdown(code)
                .markdownTheme(.gitHub)
            
            Spacer()
            
        }
        .navigationTitle("Distribute ETH")
    }
}

struct DistributeETHfromBinance_Previews: PreviewProvider {
    static var previews: some View {
        DistributeETHfromBinance()
    }
}
