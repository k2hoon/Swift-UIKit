//
//  BasicCollectionViewCell.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/07/14.
//

import UIKit

class BasicCollectionViewCell: UICollectionViewCell {
    static let identifier = "BasicCollectionViewCell"
    
    lazy var button: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        button.backgroundColor = .lightGray
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16.0
        
        button.setTitle("Button", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.lineBreakMode = .byWordWrapping
        
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(self.button)
        NSLayoutConstraint.activate([
            self.button.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.button.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.button.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.button.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.button.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.button.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
        ])        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.setLabel(text: "")
    }
    
    
    func setLabel(text: String) {
        self.button.setTitle(text, for: .normal)
    }
}
