//
//  FAQView.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/6.
//

import SwiftUI


struct ListRowModifier: ViewModifier {
    func body(content: Content) -> some View {
        Group {
            content
            Divider()
        }.offset(x: 20)
    }
}



struct FAQView: View {

    
    @State private var selection: Set<FAQ> = []

    var body: some View {
        Section {
//            scrollForEach
            
            ForEach(faqs) { faq in
                FAQRowView(isExpanded: self.selection.contains(faq), faq: faq)
//                    .modifier(ListRowModifier())
                    .onTapGesture {
                        self.selectDeselect(faq)
                    }
                    .animation(.linear(duration: 0.3))
            }
        } header: {
            SectionHeaderView(text: "FAQ")
        }

    }

//    var scrollForEach: some View {
//            ScrollView {
//                ForEach(faqs) { faq in
//                    FAQRowView(isExpanded: self.selection.contains(faq), faq: faq)
//                        .modifier(ListRowModifier())
//                        .onTapGesture { self.selectDeselect(faq) }
//                        .animation(.linear(duration: 0.3))
//                }
//            }
//        }
    private func selectDeselect(_ faq: FAQ) {
        if selection.contains(faq) {
            selection.remove(faq)
        } else {
            selection.insert(faq)
        }
    }
}

struct FAQView_Previews: PreviewProvider {
    static var previews: some View {
        FAQView()
    }
}
