//
//  CurrentDateEnvironment.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/5.
//

import Foundation
import SwiftUI

struct CurrentDateKey: EnvironmentKey {
    static let defaultValue = Date()
}

extension EnvironmentValues {
    var currentDate: Date {
        get { self[CurrentDateKey.self] }
        set { self[CurrentDateKey.self] = newValue }
    }
}
