//
//  Airdrop.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/6.
//

import Foundation


struct Airdrop: Identifiable {
    let id = UUID()

    public var name: String
    public var icon: String
    public var tags: [String]
    public var description: String
}
