//
//  Text.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/6.
//

import Foundation
import SwiftUI

public extension Text {
    enum AppTextStyle {
        case title, rowTitle, rowDescription, rowDetail
        case sectionHeader
    
    }

    func style(appStyle: AppTextStyle) -> Text {
        switch appStyle {
        case .title: return title()
        case .rowTitle: return rowTitle()
        case .rowDetail: return rowDetail()
        case .sectionHeader: return sectionHeader()
        case .rowDescription: return rowDescription()
        }
    }
}

extension Text {
    private func title() -> Text {
        self.font(.title)
            .fontWeight(.bold)
    }
    
    private func sectionHeader() -> Text {
        self.font(.system(.subheadline, design: .rounded))
            .fontWeight(.bold)
            .foregroundColor(Color.white)
    }
    
    private func rowTitle() -> Text {
        self.font(.headline)
            .fontWeight(.bold)
    }
    
    private func rowDetail() -> Text {
        self.font(.headline)
            .fontWeight(.semibold)
    }
    
    private func rowDescription() -> Text {
        self.font(.subheadline)
    }
}
