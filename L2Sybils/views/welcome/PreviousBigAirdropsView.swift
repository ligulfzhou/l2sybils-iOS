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
        description: "optimism_description"),
    Airdrop(
        name: "Arbitrum",
        icon: "arbitrum",
        tags:  ["Layer2", "Ethereum"],
        description: "arbitrum_description"),
    Airdrop(
        name: "Aptos",
        icon: "aptos",
        tags: ["Layer1", "Move"],
        description: "aptos_description")
]

struct PreviousBigAirdropsView: View {
    var body: some View {
        Section {
            ForEach(airdrops) { airdrop in
                AirdropInfoView(airdrop: airdrop)
            }
        } header: {
            SectionHeaderView(text: "previous_big_airdrops")
        }
    }
}

struct PreviousBigAirdropsView_Previews: PreviewProvider {
    static var previews: some View {
        PreviousBigAirdropsView()
    }
}
