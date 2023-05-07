//
//  PreviousBigAirdrops.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/6.
//

import SwiftUI


let airdrops: [Airdrop] = [
    Airdrop(
        name: "Optimism",
        icon: "optimism",
        tags: ["Layer2", "Ethereum"],
        description: """
Optimistic Ethereum is an EVM-compatible Optimistic Rollup chain.
In round one, the protocol distributed a total of 200m OP tokens to 248,699 addresses.
In round two, it distributed a total of 11.7 million OP tokens to over 300,000 addresses.
"""),
    Airdrop(
        name: "Arbitrum",
        icon: "arbitrum",
        tags:  ["Layer2", "Ethereum"],
        description: """
Arbitrum One is also an Optimistic Rollup chain.
1.162 billion ARB tokens were airdropped to 625,143 eligible addresses. See detail statistics.
Its airdrop rules can be found here.
"""),
    Airdrop(
        name: "Aptos",
        icon: "aptos",
        tags: ["Layer1", "Move"],
        description: """
20,076,150 APT tokens will be airdropped to 110,235 participants.
""")
]

struct PreviousBigAirdropsView: View {
    var body: some View {
        Section {
            ForEach(airdrops) { airdrop in
                AirdropInfoView(airdrop: airdrop)
            }
        } header: {
            SectionHeaderView(text: "Previous Big Airdrops")
        }
    }
}

struct PreviousBigAirdropsView_Previews: PreviewProvider {
    static var previews: some View {
        PreviousBigAirdropsView()
    }
}
