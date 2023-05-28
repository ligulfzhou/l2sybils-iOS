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
        question: "faq_q1",
        answer: "faq_a1"
    ),
    FAQ(
        question: "faq_q2",
        answer: "faq_a2"
    ),
    FAQ(
        question: "faq_q3",
        answer: "faq_a3"
    )
]
