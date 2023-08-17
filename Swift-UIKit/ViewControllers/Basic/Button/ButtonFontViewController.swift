//
//  ButtonFontViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/08/08.
//

import UIKit

class ButtonFontViewController: UIViewController {
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 10
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private var buttons: [UIButton] {
        [
            getButton(title: "Bold", font: .boldSystemFont(ofSize: 14)),
            getButton(title: "Italic", font: .italicSystemFont(ofSize: 14)),
            getButton(subtitle: "Bold", font: .boldSystemFont(ofSize: 14)),
            getButton(subtitle: "Italic", font: .italicSystemFont(ofSize: 14)),
            getButton(symbol: .init(pointSize: 50))
        ]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .white
        self.setNavigationTitle(title: "Button Font")
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
    
    func getButton(title: String, font: UIFont) -> UIButton {
        var container = AttributeContainer()
        container.font = font
        
        var config = UIButton.Configuration.plain()
        // attributedTitle
        config.attributedTitle = AttributedString(title, attributes: container)
        
        // base color
        config.baseBackgroundColor = UIColor.blue
        config.baseForegroundColor = UIColor.black
        
        // background configuration
        config.background.backgroundColor = UIColor.gray
        config.background.strokeColor = UIColor.red
        config.background.strokeWidth = 1
        
        return UIButton(configuration: config)
    }
    
    
    func getButton(subtitle: String, font: UIFont) -> UIButton {
        var container = AttributeContainer()
        container.font = font
        
        var config = UIButton.Configuration.plain()
        // attributedSubtitle
        config.attributedSubtitle = AttributedString(subtitle, attributes: container)
        
        // base color
        config.baseBackgroundColor = UIColor.blue
        config.baseForegroundColor = UIColor.black
        
        // background configuration
        config.background.backgroundColor = UIColor.gray
        config.background.strokeColor = UIColor.red
        config.background.strokeWidth = 1
        
        return UIButton(configuration: config)
    }
    
    
    func getButton(symbol: UIImage.SymbolConfiguration) -> UIButton {
        var config = UIButton.Configuration.borderless()
        config.image = UIImage(systemName: "swift")
        config.preferredSymbolConfigurationForImage = symbol
        
        // base color
        config.baseBackgroundColor = UIColor.blue
        config.baseForegroundColor = UIColor.black
        
        // background configuration
        config.background.backgroundColor = UIColor.gray
        config.background.strokeColor = UIColor.red
        config.background.strokeWidth = 1
        
        return UIButton(configuration: config)
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ButtonFontViewController_Preview: PreviewProvider {
    static var previews: some View {
        ButtonFontViewController().toPreview()
    }
}
#endif
