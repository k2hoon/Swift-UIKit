//
//  SliderViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/09/15.
//

import UIKit

final class SliderViewController: UIViewController {
    private lazy var sliderView: UISlider = {
        let slider = UISlider()
        slider.thumbTintColor = .systemGray
        slider.tintColor = .systemRed
        slider.isContinuous = true
        
        return slider
    }()
    
    private lazy var stepperView: UIStepper = {
        let stepper = UIStepper()
        stepper.autorepeat = true
        stepper.isContinuous = false
        stepper.stepValue = 10
        return stepper
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .black
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 20
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        layoutSliderView()
        layoutStackView()
        layoutStepperView()
    }
    
    func layoutSliderView() {
        view.addSubview(sliderView)
        sliderView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sliderView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            sliderView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            sliderView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
        
        self.setSliderValueRange()
        self.setSliderValueImages(min: "speaker", max: "speaker.3.fill")
        self.sliderView.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    private func layoutStepperView() {
        view.addSubview(stepperView)
        stepperView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stepperView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stepperView.bottomAnchor.constraint(equalTo: sliderView.topAnchor, constant: -16),
        ])
        self.stepperView.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
        
        // value label
        view.addSubview(valueLabel)
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            valueLabel.centerYAnchor.constraint(equalTo: stepperView.centerYAnchor),
            valueLabel.leftAnchor.constraint(equalTo: stepperView.rightAnchor, constant: 16),
        ])
    }
    
    private func layoutStackView() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // background button
        let backgroundButton = UIButton()
        backgroundButton.configuration = .filled()
        backgroundButton.setTitle("background", for: .normal)
        backgroundButton.addAction { [unowned self] in
            self.setSliderBackground()
        }
        
        // Track color button
        let breakButton = UIButton()
        breakButton.configuration = .filled()
        breakButton.setTitle("Track color", for: .normal)
        breakButton.addAction { [unowned self] in
            self.setSliderTrackColor()
        }
        
        self.stackView.addArrangedSubview(backgroundButton)
        self.stackView.addArrangedSubview(breakButton)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: sliderView.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
}

// MARK: SliderViewController + Private
extension SliderViewController {
    private func setSliderValueRange(min: Float = 0, max: Float = 100) {
        self.sliderView.minimumValue = min
        self.sliderView.maximumValue = max
        self.sliderView.value = min
    }
    
    private func setSliderValueImages(min: String, max: String) {
        if let minImage = UIImage(systemName: min) {
            self.sliderView.minimumValueImage = minImage
        }
        
        if let maxImage = UIImage(systemName: max) {
            self.sliderView.maximumValueImage = maxImage
        }
    }
    
    private func setSliderBackground() {
        self.sliderView.backgroundColor = .random()
    }
    
    private func setSliderTrackColor() {
        self.sliderView.minimumTrackTintColor = .random()
        self.sliderView.maximumTrackTintColor = .random()
    }
    
    private func setSliderTrackImage(min: String, max: String, state: UIControl.State) {
        if let minImage = UIImage(systemName: min) {
            self.sliderView.setMinimumTrackImage(minImage, for: state)
        }
        
        if let maxImage = UIImage(systemName: max) {
            self.sliderView.setMaximumTrackImage(maxImage, for: state)
        }
    }
    
    private func setValueLabel(_ text: String) {
        self.valueLabel.text = text
    }
    
    @objc private func sliderValueChanged(_ sender: UISlider, event: UIEvent) {
        setValueLabel(String(sender.value))
    }
    
    @objc private func stepperValueChanged(_ sender: UIStepper) {
        self.setValueLabel(String(sender.value))
        self.sliderView.value = Float(sender.value)
    }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct SliderViewController_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            SliderViewController()
        }
    }
}
#endif
