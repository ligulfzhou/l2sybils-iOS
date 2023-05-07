//
//  UIState.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/5.
//

import Foundation

class UIState: ObservableObject {
    public static let shared = UIState()
    
    enum Tab: Int {
        case welcome, accounts, projects, lite, era
    }
    
    @Published var selectedTab = Tab.welcome
}
