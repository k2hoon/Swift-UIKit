//
//  CustomTableViewCell.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/06/17.
//

import UIKit

struct CustomCell {
    let title: String
    let subtitle: String
    let imageName: String
}

class CustomTableViewCell: UITableViewCell {
    static let identifier = "CustomCell"
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 8
        stack.alignment = .leading
        return stack
    }()
    
    private lazy var stepperView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [decreaseButton, quantityLabel, increaseButton])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 5
        stack.alignment = .trailing
        return stack
    }()
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let decreaseButton: UIButton = {
        let label = UIButton(type: .custom)
        label.setImage(UIImage(systemName: "minus.circle"), for: .normal)
        label.imageView?.contentMode = .scaleAspectFill
        return label
    }()
    
    private let increaseButton: UIButton = {
        let label = UIButton(type: .custom)
        label.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        label.imageView?.contentMode = .scaleAspectFill
        return label
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.text = "1"
        label.textColor = .black
        return label
    }()
    
    private let profileImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            contentView.layer.borderWidth = 1
            contentView.layer.borderColor = UIColor.red.cgColor
        } else {
            contentView.layer.borderWidth = 1
            contentView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // TODO:
    }
}

extension CustomTableViewCell {    
    func updateCellItem(_ item: CustomCell) {
        if let image = UIImage(systemName: item.imageName) {
            profileImage.image = image
        } else {
            profileImage.image = UIImage(systemName: "exclamationmark.triangle")
        }
        
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
    }
    
    private func layoutViews() {
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
        ])
        
        stackView.addArrangedSubview(profileImage)
        NSLayoutConstraint.activate([
            profileImage.widthAnchor.constraint(equalToConstant: 44),
            profileImage.heightAnchor.constraint(equalToConstant: 44),
        ])
        
        stackView.addArrangedSubview(labelStackView)
        stackView.addArrangedSubview(stepperView)
        
        // update contentView frame
        //        self.contentView.frame = stackView.frame
    }
    
    //    func layoutViews() {
    //        [profileImage, stepperView, labelStackView].forEach {
    //            addSubview($0)
    //            $0.translatesAutoresizingMaskIntoConstraints = false
    //        }
    //
    //        NSLayoutConstraint.activate([
    //            profileImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
    //            profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
    //            profileImage.widthAnchor.constraint(equalToConstant: 44),
    //            profileImage.heightAnchor.constraint(equalToConstant: 44),
    //
    //            stepperView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
    //            stepperView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
    //
    //            labelStackView.topAnchor.constraint(equalTo: self.topAnchor),
    //            labelStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
    //            labelStackView.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 8),
    //            labelStackView.trailingAnchor.constraint(equalTo: stepperView.leadingAnchor, constant: -8)
    //        ])
    //
    //        labelStackView.setContentHuggingPriority(.defaultLow, for: .horizontal)
    //    }
}
