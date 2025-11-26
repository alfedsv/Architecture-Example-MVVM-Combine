//
//  ColoredView.swift
//  Architecture-Example-MVVM-Combine
//
//  Created by  Alexander Fedoseev on 26.11.2025.
//

import UIKit

final class ColoredView: UIView {

    private let color: UIColor
    
    init(color: UIColor) {
        self.color = color
        super.init(frame: .zero)
        self.backgroundColor = .gray
    }
    
    func onOff(isOn: Bool) {
        if isOn {
            self.backgroundColor = color
        } else {
            self.backgroundColor = .gray
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
}
