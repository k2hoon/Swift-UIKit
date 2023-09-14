//
//  AlertViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/08/09.
//

import UIKit

class AlertViewController: UIViewController {
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 10
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .white
        self.setNavigationTitle(title: "AlertViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        stackView.addArrangedSubview(addAlertButton())
        stackView.addArrangedSubview(addActionSheettButton())
        stackView.addArrangedSubview(addAlertTextFieldButton())
    }
    
    func addAlertButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Default Alert", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(defaultAlert), for: .touchUpInside)
        return button
    }
    
    func addActionSheettButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Action sheet", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(defaultActionSheet), for: .touchUpInside)
        return button
    }
    
    func addAlertTextFieldButton() -> UIButton {
        let button = UIButton()
        button.setTitle("TextField alert", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(showTextFieldAlert), for: .touchUpInside)
        return button
    }

}

// MARK: - UIAlertViewController actions
extension AlertViewController {
    @objc func defaultAlert() {
        let alert = UIAlertController(title: "Alert title", message: "This is an alert.", preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: "OK", style: .default) { _ in
                NSLog("\"OK\" alert occured.")
            }
        )
        
        alert.addAction(
            UIAlertAction(title: "Destructive", style: .destructive) { _ in
                NSLog("\"Destructive\" alert occured.")
            }
        )
        
        alert.addAction(
            UIAlertAction(title: "Cancel", style: .cancel) { _ in
                NSLog("\"Cancel\" alert occured.")
            }
        )
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func defaultActionSheet() {
        let alert = UIAlertController(title: "Action sheet Title", message: "Select an action", preferredStyle: .actionSheet)
        alert.addAction(
            UIAlertAction(title: "Default", style: .default) { _ in
                NSLog("Default action occured.")
            }
        )
        
        alert.addAction(
            UIAlertAction(title: "Destructive", style: .destructive) { _ in
                NSLog("Destructive action occured.")
            }
        )
        
        alert.addAction(
            UIAlertAction(title: "Cancel", style: .cancel) { _ in
                NSLog("Cancel action occured.")
            }
        )
        
        self.present(alert, animated: true, completion: nil)
    }

    @objc func showTextFieldAlert() {
        let alert = UIAlertController(title: "Alert title", message: nil, preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: "Confirm", style: .default) { _ in
                if let textField = alert.textFields?.first, let text = textField.text {
                    NSLog("Input text::", text)
                }
            }
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addTextField { textField in
            textField.placeholder = "Any text here"
        }
        
        present(alert, animated: true, completion: nil)
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct AlertViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            AlertViewController()
        }
    }
}
#endif
