//
//  SearchBar.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/09/30.
//

import UIKit

class SearchBar: UIView {
    var isKeyboardActive = false
    
    private let icon: UIImageView = UIImageView(image: UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysTemplate))
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.borderStyle = .none
        textField.placeholder = "Search"
        textField.clearButtonMode = .always
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 16.0
        
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        self.layoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutView() {
        self.addSubview(self.icon)
        self.icon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            icon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            icon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: 24),
            icon.heightAnchor.constraint(equalToConstant: 24),
        ])
        icon.tintColor = .gray
        
        self.addSubview(self.textField)
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.topAnchor),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
        ])
    }
    
    func clearText() {
        self.textField.text = nil
        self.dismissKeyboard()
    }
    
    func setKeyboadrState(active: Bool) {
        self.isKeyboardActive = active
    }
    
    func dismissKeyboard() {
        self.textField.resignFirstResponder()
    }
}
