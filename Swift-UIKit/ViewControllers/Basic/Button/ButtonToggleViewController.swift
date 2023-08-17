//
//  ButtonToggleViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/08/17.
//

import UIKit

class ButtonToggleViewController: UIViewController {
    // Toggle button
    private lazy var togglePrimartButton: UIButton = {
        let button = UIButton(primaryAction: togglePrimaryAction)
        button.setImage(UIImage(systemName: "list.bullet.below.rectangle"), for: .normal)
        button.tintColor = .red

        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOpacity = 1.0
        button.layer.shadowOffset = CGSize.zero
        button.layer.shadowRadius = 6
        
        button.changesSelectionAsPrimaryAction = true
        return button
    }()
    
    private lazy var toggleConfigButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseForegroundColor = .black
        config.baseBackgroundColor = .systemGray
        config.contentInsets = .init(top: 12, leading: 12, bottom: 12, trailing: 12)
        
        let button = UIButton(configuration: config, primaryAction: toggleConfigAction)
        button.tintColor = .red
        button.layer.cornerRadius = 12
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOpacity = 1.0
        button.layer.shadowOffset = CGSize.zero
        button.layer.shadowRadius = 6
        
        button.changesSelectionAsPrimaryAction = true
        
        return button
    }()
    
    private lazy var toggleConfigHandlerButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseForegroundColor = .black
        config.baseBackgroundColor = .systemGray
        config.contentInsets = .init(top: 12, leading: 12, bottom: 12, trailing: 12)
        
        let button = UIButton(configuration: config)
        button.configurationUpdateHandler = toggleHandler
        button.tintColor = .red
        button.layer.cornerRadius = 12
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOpacity = 1.0
        button.layer.shadowOffset = CGSize.zero
        button.layer.shadowRadius = 6
        
        button.changesSelectionAsPrimaryAction = true
        
        return button
    }()
    
    let togglePrimaryAction = UIAction { action in
        if let button = action.sender as? UIButton {
            // TODO: update button using toggle state
        }
    }
    
    private let toggleHandler: UIButton.ConfigurationUpdateHandler = { button in
        var config = button.configuration
        config?.title = button.isSelected ? "Toggle on" : "Toggle off"
        config?.baseForegroundColor = button.isSelected ? .white : .black
        config?.baseBackgroundColor = button.isSelected ? .systemIndigo : .systemGray
        button.configuration = config
    }
    
    private let toggleConfigAction = UIAction(title: "Toggle off") { action in
        // toggle state
        if let button = action.sender as? UIButton {
            var config = button.configuration
            config?.title = button.isSelected ? "Toggle on" : "Toggle off"
            config?.baseForegroundColor = button.isSelected ? .white : .black
            config?.baseBackgroundColor = button.isSelected ? .systemIndigo : .systemGray
            button.configuration = config
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
        self.setNavigationTitle(title: "Button Toggle")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.layoutToggleWithPrimary()
        self.layoutToggleWithConfiguration()
        self.layoutToggleWithConfigurationHandler()
    }
    
    private func layoutToggleWithPrimary() {
        view.addSubview(togglePrimartButton)
        
        togglePrimartButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            togglePrimartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            togglePrimartButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    
    private func layoutToggleWithConfiguration() {
        view.addSubview(toggleConfigButton)
        
        toggleConfigButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toggleConfigButton.topAnchor.constraint(equalTo: togglePrimartButton.bottomAnchor, constant: 16),
            toggleConfigButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func layoutToggleWithConfigurationHandler() {
        view.addSubview(toggleConfigHandlerButton)
        
        toggleConfigHandlerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toggleConfigHandlerButton.topAnchor.constraint(equalTo: toggleConfigButton.bottomAnchor, constant: 16),
            toggleConfigHandlerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ButtonToggleViewController_Previews: PreviewProvider {
    static var previews: some View {
        ButtonToggleViewController().toPreview()
    }
}
#endif
