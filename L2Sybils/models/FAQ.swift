//
//  FAQ.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/6.
//

import Foundation


struct FAQ: Identifiable, Hashable {
    let id = UUID()
    public var question: String
    public var answer: String
}

let faqs: [FAQ] = [
    FAQ(
        question: "Q: What is the sybil attack?",
        answer: "A: Project need real users to participate in their project. But 'sybils' just target in the airdrop tokens. They own hundreds/thousands of accounts to participate in airdrop program."
    ),
    FAQ(
        question: "Q: Is it easy to maintain hundreds/thousands of accounts?",
        answer: "A: If you do not have coding skills, you need patient to keep a list of accounts, manually do the tasks like mint nft, do defi tradings on every account, and write down progress...\nBut you have coding skills, It is not that hard, your script can take care of it."
    ),
    FAQ(
        question: "Q: To participate in Layer2 projects like zkSync or StarkNet, how much eth should i put into one account?",
        answer: "A: It depends on your budget. It minuses 1 point if your balance is less than 0.005ETH in Arbitrum airdrop program."
    )
]
