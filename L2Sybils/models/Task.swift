//
//  Task.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/9.
//

import Foundation

struct Task: Identifiable {
    let id = UUID()

    public var name: String
    public var icon: String
    public var site: String?
    public var code: String?
}
