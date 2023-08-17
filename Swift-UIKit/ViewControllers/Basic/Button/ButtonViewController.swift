//
//  ButtonViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/01/10.
//

import UIKit

class ButtonViewController: UIViewController {
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
            getButton(title: "Bordered", with: .bordered()),
            getButton(title: "Bordered Prominent", with: .borderedProminent()),
            getButton(title: "Bordered Tinted", with: .borderedTinted()),
            getButton(title: "Borderless", with: .borderless()),
            getButton(title: "Filled", with: .filled()),
            getButton(title: "Gray", with: .gray()),
            getButton(title: "Plain", with: .plain()),
            getButton(title: "Tinted", with: .tinted()),
        ]
    }
    
    private let configHandler: UIButton.ConfigurationUpdateHandler = { button in
        switch button.state {
        case .selected, .highlighted:
            button.configuration?.title = "select and highlight"
        case .selected:
            button.configuration?.title = "Selected"
        case .highlighted:
            button.configuration?.title = "Highlighted"
        case .disabled:
            button.configuration?.title = "Disabled"
        default:
            break
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .white
        self.setNavigationTitle(title: "Button")
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
    
    func getButton(title: String = "Title", subtitle: String = "Subtitle", with configuration: UIButton.Configuration) -> UIButton {
        var config = configuration
        config.title = title
        config.subtitle = subtitle
        config.image = UIImage(systemName: "swift")
        config.titlePadding = 10
        config.imagePadding = 10
        config.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let button = UIButton(configuration: config)
        button.configurationUpdateHandler = configHandler
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.borderWidth = 1
        
        return button
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ButtonViewController_Preview: PreviewProvider {
    static var previews: some View {
        ButtonViewController().toPreview()
    }
}
#endif
