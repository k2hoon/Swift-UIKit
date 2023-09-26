//
//  TextFieldViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/08/17.
//

import UIKit

class TextField: UITextField {
    var edgeInsets: UIEdgeInsets = .zero {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: edgeInsets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: edgeInsets)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: edgeInsets)
    }
}

class TextFieldViewController: UIViewController {
    
    lazy var textField: UITextField = {
        let textfield = TextField()
        textfield.edgeInsets = .init(top: 18, left: 18, bottom: 18, right: 18)
        textfield.placeholder = "Place holder"
        textfield.text = "hello, world!"
        textfield.borderStyle = .roundedRect
        textfield.center = view.center
        textfield.clearsOnBeginEditing = true
        textfield.delegate = self
        
        return textfield
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "empty"
        label.textColor = .black
        label.sizeToFit()
        label.border()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .white
        self.title = "Text Field"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // layout text field
        self.view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        // layout text label
        self.view.addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            textLabel.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -16)
        ])
    }
    
}

extension TextFieldViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        view.backgroundColor = .systemGray
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.backgroundColor = .white
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.backgroundColor = .systemBlue
        textField.resignFirstResponder()
        textLabel.text = textField.text
        
        return true
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct TextFieldViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            TextFieldViewController()
        }
    }
}
#endif
