//
//  CollectionViewCell.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/09/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let identifier = "CollectionViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.titleLabel.text = nil
        self.imageView.image = nil
        self.backgroundColor = .systemGray
        setBorder()
    }
    
    private func layoutViews() {
        self.backgroundColor = .systemGray
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    func setItems(number: Int? = nil, color: UIColor? = nil, border: Bool = false) {
        if let number = number {
            self.titleLabel.text = String(number)
        }
        if let color = color {
            self.backgroundColor = color
        }
        
        if border {
            setBorder(borderColor: UIColor.black.cgColor, borderWidth: 1.0)
        }
    }
    
    func setImage(name: String) {
        let image = UIImage(named: name)
        self.imageView.image = image
    }
    
    private func setBorder(borderColor: CGColor? = nil, borderWidth: CGFloat = 0) {
        self.layer.borderColor = borderColor
        self.layer.borderWidth = borderWidth
    }
}
