//
//  ProjectsView.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/6.
//

import SwiftUI

struct ProjectsView: View {

    var body: some View {
        HStack {
            Image("welcome")
            
            VStack {
                Text("Optimism").font(.headline)
                Text("Optimistic Ethereum is an EVM-compatible Optimistic Rollup chain. \nIn round one, the protocol distributed a total of 200m OP tokens to 248,699 addresses. \nIn round two, it distributed a total of 11.7 million OP tokens to over 300,000 addresses.").font(.body)
            }
        }
    }
}

