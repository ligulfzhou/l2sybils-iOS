//
//  FAQRowView.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/6.
//

import SwiftUI

struct FAQRowView: View {
    
    let isExpanded: Bool
    let faq: FAQ
    
    var body: some View {
        HStack {
            content
            Spacer()
        }
            .contentShape(Rectangle())
    }

    private var content: some View {
        VStack(alignment: .leading) {
            Text(faq.question)
                .font(.headline)
                    
            if isExpanded {
                Spacer()
                
                VStack(alignment: .leading) {
                    Text(faq.answer)
                }

                Spacer()
            }
        }
    }
    
}

