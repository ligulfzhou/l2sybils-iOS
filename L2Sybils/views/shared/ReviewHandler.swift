//
//  ReviewHandler.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/9.
//

import Foundation
import StoreKit
import SwiftUI


class ReviewHandler {
    
    static func requestReview() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        }
    }
}
