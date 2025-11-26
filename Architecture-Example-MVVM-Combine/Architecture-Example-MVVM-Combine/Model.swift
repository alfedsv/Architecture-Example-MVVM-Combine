//
//  Model.swift
//  Architecture-Example-MVVM-Combine
//
//  Created by  Alexander Fedoseev on 26.11.2025.
//

import Foundation

struct Model {
    enum Light: String {
        case red = "RED"
        case yellow = "YELLOW"
        case green = "GREEN"
    }
    enum Direction {
        case up
        case down
    }
    var currentLight: Light = .yellow
    var direction: Direction = .up
}
