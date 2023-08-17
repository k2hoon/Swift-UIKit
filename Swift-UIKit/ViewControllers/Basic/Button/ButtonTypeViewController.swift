//
//  ButtonTypeViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/08/08.
//

import UIKit

class ButtonTypeViewController: UIViewController {
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 20
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private var buttons: [UIButton] {
        [
            getButton(type: .close),
            getButton(type: .contactAdd),
            getButton(type: .detailDisclosure),
            getButton(type: .infoDark),
            getButton(type: .infoLight),
            getButton(type: .system),
        ]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .white
        self.setNavigationTitle(title: "Button Type")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
        
        self.buttons.forEach { button in
            stackView.addArrangedSubview(button)
        }
    }
    
    func getButton(type: UIButton.ButtonType) -> UIButton {
        let button = UIButton(type: type)
        button.setTitle("Button", for: .normal)
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.borderWidth = 1
        return button
    }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ButtonTypeViewController_Preview: PreviewProvider {
    static var previews: some View {
        ButtonTypeViewController().toPreview()
    }
}
#endif
