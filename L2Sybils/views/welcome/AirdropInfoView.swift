//
//  AirdropInfoView.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/6.
//

import SwiftUI


//Optimistic Ethereum is an EVM-compatible Optimistic Rollup chain.
//In round one, the protocol distributed a total of 200m OP tokens to 248,699 addresses.
//In round two, it distributed a total of 11.7 million OP tokens to over 300,000 addresses.




struct AirdropInfoView: View {
    
    let airdrop: Airdrop
    
    var body: some View {
        VStack(alignment: .leading, content: {
            HStack {
                VStack {
                    Image(airdrop.icon)
                        .resizable()
                        .frame(width: 60, height: 60)
                }
                
                VStack(alignment: .leading, content: {
                    
                    Text(airdrop.name)
                        .font(.headline)
//                        .foregroundColor(.white)
                    
                    HStack {
                        ForEach(airdrop.tags, id: \.self) { tag in
                            Text(tag)
                                .bold()
                                .font(.system(size: 8))
                                .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                                .foregroundColor(Color.blue)
                                .overlay(RoundedRectangle(cornerRadius: 24).stroke(Color.blue, lineWidth: 1.0))
                        }
                    }
                })
            }
            Text(airdrop.description)
                .font(.system(size: 12))
        })

    }
}
