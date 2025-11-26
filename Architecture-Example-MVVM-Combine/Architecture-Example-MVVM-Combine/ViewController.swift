//
//  ViewController.swift
//  Architecture-Example-MVVM-Combine
//
//  Created by  Alexander Fedoseev on 26.11.2025.
//

import UIKit
import Combine

final class ViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = ""
        return label
    }()
    private let viewModel = ViewModel()
    private let topView = ColoredView(color: .red)
    private let middleView = ColoredView(color: .yellow)
    private let bottomView = ColoredView(color: .green)
    private lazy var switchColorButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle("Change color", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addAction(UIAction { [weak self] _ in
            self?.switchColor()
        }, for: .touchUpInside)
        return button
    }()
    private let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        containerStackView.addArrangedSubview(topView)
        containerStackView.addArrangedSubview(middleView)
        containerStackView.addArrangedSubview(bottomView)
        view.addSubview(titleLabel)
        view.addSubview(containerStackView)
        view.addSubview(switchColorButton)
        bindViewModel()
        setupConstraints()
    }
    
    private func bindViewModel() {
        viewModel.$isRedOn
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isOn in
                self?.topView.onOff(isOn: isOn)
            }
            .store(in: &cancellables)
        viewModel.$isYellowOn
            .sink { [weak self] isOn in
                self?.middleView.onOff(isOn: isOn)
            }
            .store(in: &cancellables)
        viewModel.$isGreenOn
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isOn in
                self?.bottomView.onOff(isOn: isOn)
            }
            .store(in: &cancellables)
        viewModel.$title
            .receive(on: DispatchQueue.main)
            .sink { [weak self] title in
                self?.titleLabel.text = title
            }
            .store(in: &cancellables)
    }
    
    private func switchColor() {
        viewModel.colorChanged()
    }

}
extension ViewController {
    private func setupConstraints() {
        let container = containerStackView
        let safeArea = view.safeAreaLayoutGuide
        [
            titleLabel,
            container,
            switchColorButton
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 25),
            titleLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            container.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            container.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: switchColorButton.topAnchor, constant: -55),
            switchColorButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            switchColorButton.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.8),
            switchColorButton.heightAnchor.constraint(equalTo: switchColorButton.widthAnchor, multiplier: 0.2),
            switchColorButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20)
        ])
        [
            topView,
            middleView,
            bottomView
        ].forEach({
            NSLayoutConstraint.activate([
                $0.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.45),
                $0.heightAnchor.constraint(equalTo: $0.widthAnchor)
            ])
        })
    }
}

