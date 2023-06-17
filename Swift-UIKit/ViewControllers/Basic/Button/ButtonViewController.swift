//
//  ButtonViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/01/10.
//

import UIKit

class ButtonViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 30
        stack.alignment = .center
        
        self.view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stack.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            stack.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
        
        stack.addArrangedSubview(setDefaultButton())
        stack.addArrangedSubview(setFilledButton())
        stack.addArrangedSubview(setTintedButton())
        stack.addArrangedSubview(setGrayButton())
        stack.addArrangedSubview(setPlainButton())
        stack.addArrangedSubview(setBorderlessButton())
        stack.addArrangedSubview(setBorderedButton())
        stack.addArrangedSubview(setBorderedTintedButton())
        stack.addArrangedSubview(setBorderedProminentButton())
        
    }
    
    func setDefaultButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Button", for: .normal)
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        button.backgroundColor = .darkGray
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.borderWidth = 2
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

        return button
    }
    
    func setFilledButton() -> UIButton {
        var config = UIButton.Configuration.filled()
        config.title = "Title"
        config.subtitle = "Subtitle"
        config.image = UIImage(systemName: "swift")
        config.titlePadding = 10
        config.imagePadding = 10

        return UIButton(configuration: config)
    }
    
    
    func setTintedButton() -> UIButton {
        var config = UIButton.Configuration.tinted()
        var container = AttributeContainer()
        container.font = UIFont.boldSystemFont(ofSize: 20)
        config.attributedTitle = AttributedString("Title", attributes: container)
        config.baseBackgroundColor = .darkGray
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

        return UIButton(configuration: config)
    }
    
    func setGrayButton() -> UIButton {
        var config = UIButton.Configuration.gray()
        var container = AttributeContainer()
        container.font = UIFont.boldSystemFont(ofSize: 20)
        config.attributedSubtitle = AttributedString("Subtitle", attributes: container)
        config.baseBackgroundColor = .darkGray
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

        return UIButton(configuration: config)
    }
    

    func setPlainButton() -> UIButton {
        var config = UIButton.Configuration.plain()
        var container = AttributeContainer()
        container.font = UIFont.boldSystemFont(ofSize: 20)
        config.attributedSubtitle = AttributedString("Subtitle", attributes: container)
        config.baseBackgroundColor = .darkGray
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

        return UIButton(configuration: config)
    }
    
    func setBorderlessButton() -> UIButton {
        var config = UIButton.Configuration.borderless()
        config.image = UIImage(systemName: "swift")
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 30)
        config.imagePadding = 10
        config.baseBackgroundColor = .darkGray
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        return UIButton(configuration: config)
    }
    
    func setBorderedButton() -> UIButton {
        var config = UIButton.Configuration.bordered()
        config.baseBackgroundColor = .darkGray
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let button = UIButton(configuration: config)
        button.setTitle("Button", for: .normal)
        button.backgroundColor = .red
        return button
    }
    
    func setBorderedTintedButton() -> UIButton {
        var config = UIButton.Configuration.borderedTinted()
        config.baseBackgroundColor = .darkGray
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let button = UIButton(configuration: config)
        button.setTitle("Button", for: .normal)
        return button
    }
    
    func setBorderedProminentButton() -> UIButton {
        var config = UIButton.Configuration.borderedProminent()
        config.baseBackgroundColor = .darkGray
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        config.cornerStyle = .dynamic
        config.background.cornerRadius = 10
        let button = UIButton(configuration: config)
        button.setTitle("Button", for: .normal)
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
