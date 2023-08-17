//
//  ButtonSwitchViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/08/18.
//

import UIKit

class ButtonSwitchViewController: UIViewController {
    lazy var switchButton: UISwitch = {
        let button = UISwitch()
        button.isOn = false
        button.onTintColor = .systemBlue
        button.thumbTintColor = .black
        button.addTarget(self, action: #selector(onClickSwitch), for: .valueChanged)
        return button
    }()
    
    lazy var colorLabel: UILabel = {
        let label = UILabel(frame: .init(x: 0, y: 0, width: 200, height: 200))
        label.backgroundColor = .white
        label.textColor = .black
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = label.frame.width / 2
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .white
        self.setNavigationTitle(title: "Button Switch")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.layoutSwitchButton()
        self.layoutColorLabel()
        
    }
    
    private func layoutSwitchButton() {
        self.view.addSubview(switchButton)
        
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            switchButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            switchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18)
        ])
    }
    
    private func layoutColorLabel() {
        self.view.addSubview(colorLabel)
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            colorLabel.topAnchor.constraint(equalTo: switchButton.bottomAnchor, constant: 18),
            colorLabel.widthAnchor.constraint(equalToConstant: 200),
            colorLabel.heightAnchor.constraint(equalToConstant: 200),
        ])
    }

    @objc func onClickSwitch(_ sender: UISwitch) {
        if sender.isOn {
            self.colorLabel.text = "On"
            self.colorLabel.backgroundColor = .systemGreen
        } else {
            self.colorLabel.text = "Off"
            self.colorLabel.backgroundColor = .clear
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct SwitchViewController_Preview: PreviewProvider {
    static var previews: some View {
        ButtonSwitchViewController().toPreview()
    }
}
#endif
