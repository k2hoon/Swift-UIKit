//
//  ButtonCornerViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/08/09.
//

import UIKit

class ButtonCornerViewController: UIViewController {
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private var buttons: [UIButton] {
        [
            getButton(title: "Fixed", corner: .fixed),
            getButton(title: "Capsule", corner: .capsule),
            getButton(title: "Dynamic", corner: .dynamic),
            getButton(title: "Large", corner: .large),
            getButton(title: "Medium", corner: .medium),
            getButton(title: "Small", corner: .small),
        ]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .white
        self.setNavigationTitle(title: "ButtonViewController")
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
    
    func getButton(title: String = "Title", corner style: UIButton.Configuration.CornerStyle) -> UIButton {
        var config = UIButton.Configuration.plain()
        config.title = title
        
        // corner style
        config.cornerStyle = style
        //        config.background.cornerRadius = 16
        
        // background configuration
        config.background.backgroundColor = .lightGray
        config.background.strokeColor = .red
        config.background.strokeWidth = 1
        
        return UIButton(configuration: config)
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ButtonCornerViewController_Preview: PreviewProvider {
    static var previews: some View {
        ButtonCornerViewController().toPreview()
    }
}
#endif
