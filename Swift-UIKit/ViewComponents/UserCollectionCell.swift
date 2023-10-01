//
//  UserCollectionCell.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/10/01.
//

import UIKit

class UserCollectionCell: UICollectionViewCell {
    static let identifier = "UserCollectionCell"
    
    let imageView: UIImageView = {
        let image = UIImage(systemName: "person.circle")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    lazy var descriptLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func layoutView(){
        [imageView, nameLabel, descriptLabel].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
            imageView.widthAnchor.constraint(equalToConstant: 44),
            imageView.heightAnchor.constraint(equalToConstant: 44),
            
            nameLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10.0),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0),
            nameLabel.heightAnchor.constraint(equalTo: imageView.heightAnchor),
        ])
    }
    
    func setCellItem(_ item: User) {
        self.nameLabel.text = item.name
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.nameLabel.text = ""
        self.descriptLabel.text = ""
    }
}
