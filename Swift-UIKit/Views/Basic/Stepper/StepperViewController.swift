//
//  StepperViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/09/14.
//

import UIKit

final class StepperViewController: UIViewController {
    private lazy var stepperView: UIStepper = {
        let stepper = UIStepper()
        stepper.autorepeat = true
        stepper.isContinuous = false
        return stepper
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 20
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        return stackView
    }()
    
    private let valueLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        self.layoutStepperView()
        self.layoutStackView()
        self.layoutValueLabel()
    }
    
    private func layoutStepperView() {
        view.addSubview(stepperView)
        stepperView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stepperView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stepperView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
        
        self.stepperView.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
        self.stepperValueRange()
    }
    
    private func layoutStackView() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // update button
        let updateButton = UIButton()
        updateButton.configuration = .filled()
        updateButton.setTitle("Update Stride to 10", for: .normal)
        updateButton.addAction { [unowned self] in
            self.updateValueStride(10)
        }
        
        // break button
        let breakButton = UIButton()
        breakButton.configuration = .filled()
        breakButton.setTitle("Break", for: .normal)
        breakButton.addAction { [unowned self] in
            self.breakInvariant()
        }
        
        // reset button
        let resetButton = UIButton()
        resetButton.configuration = .filled()
        resetButton.setTitle("Reset", for: .normal)
        resetButton.addAction { [unowned self] in
            self.reset()
        }
        
        self.stackView.addArrangedSubview(updateButton)
        self.stackView.addArrangedSubview(breakButton)
        self.stackView.addArrangedSubview(resetButton)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: stepperView.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
    
    private func layoutValueLabel() {
        view.addSubview(valueLabel)
        valueLabel.text = String(0)
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            valueLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: stepperView.topAnchor, constant: -16),
        ])
    }
}

// MARK: StepperViewController + Private
extension StepperViewController {
    private func reset() {
        self.stepperValueRange()
    }
    
    private func updateValueStride(_ value: Double) {
        self.stepperView.stepValue = value
    }
    
    private func stepperValueRange(min: Double = 0, max: Double = 100) {
        stepperView.minimumValue = min
        stepperView.maximumValue = max
        stepperView.value = min
        setValueLabel(String(stepperView.value))
    }
    
    private func breakInvariant() {
        stepperView.minimumValue = 200
        stepperView.maximumValue = 100
        stepperView.value = 150
        setValueLabel(String(stepperView.value))
    }
    
    private func setValueLabel(_ text: String) {
        self.valueLabel.text = text
    }
    
    @objc private func stepperValueChanged(_ sender: UIStepper) {
        setValueLabel(String(sender.value))
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct StepperViewController_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            StepperViewController()
        }
    }
}
#endif
