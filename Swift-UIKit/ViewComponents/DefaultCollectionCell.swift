//
//  DefaultCollectionCell.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/09/30.
//

import UIKit

class DefaultCollectionCell: UICollectionViewCell {
    static let identifier = "DefaultCollectionCell"
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutView() {
        [textLabel, lineView].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            lineView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 16),
            lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            lineView.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    
    func setCellItem(_ item: String) {
        self.textLabel.text = item
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.textLabel.text = ""
    }
    
}
