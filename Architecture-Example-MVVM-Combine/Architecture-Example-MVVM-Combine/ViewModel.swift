//
//  ViewModel.swift
//  Architecture-Example-MVVM-Combine
//
//  Created by  Alexander Fedoseev on 26.11.2025.
//

import Foundation
import Combine

final class ViewModel {
    
    private var model = Model()
    @Published var isRedOn = false
    @Published var isYellowOn = false
    @Published var isGreenOn = false
    @Published var title = ""
    
    init() {
        self.colorChanged()
    }
    
    func colorChanged() {
        switch model.currentLight {
        case .red, .green:
            isRedOn = false
            isYellowOn = true
            isGreenOn = false
            model.currentLight = .yellow
        case .yellow:
            if model.direction == .up {
                isRedOn = true
                isYellowOn = false
                isGreenOn = false
                model.direction = .down
                model.currentLight = .red
            } else {
                isRedOn = false
                isYellowOn = false
                isGreenOn = true
                model.direction = .up
                model.currentLight = .green
            }
        }
        title = model.currentLight.rawValue
    }
}
