//
//  Sheet.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/9.
//

import Foundation
import SwiftUI


struct Sheet: View {
    enum SheetType: Identifiable {
        case safari(URL)
        case about

        var id: String {
        switch self {
            case .safari(let url):
                return url.absoluteString
         
            case .about:
                return "about"
            }
        }
    }
    
    let sheetType: SheetType
    
    @ViewBuilder
    var body: some View {
        switch sheetType {
        case .safari(let url):
            SafariView(url: url)
        case .about:
            AboutView()
        }
    }
}
