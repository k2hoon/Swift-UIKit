//
//  CustomTableViewCell.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/06/17.
//

import UIKit

struct CustomCell {
    let image: String
    let name: String
    let title: String
}

class CustomTableViewCell: UITableViewCell {
    static let identifier = "CustomCell"
    
    var item : CustomCell? {
        didSet {
            image.image = UIImage(systemName: item?.image ?? "")
            titleLabel.text = item?.title
            nameLabel.text = item?.name
        }
    }
    
    private let titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let decreaseButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(systemName: "minus.circle"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        return btn
    }()
    
    private let increaseButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        return btn
    }()
    
    var quantity: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.text = "1"
        label.textColor = .black
        return label
    }()
    
    private let image : UIImageView = {
        let imgView = UIImageView(image: UIImage(systemName: "star.fill"))
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(image)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(nameLabel)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: self.safeAreaInsets.top + 5),
            image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -(self.safeAreaInsets.bottom + 5)),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.safeAreaInsets.left + 5),
            image.widthAnchor.constraint(equalToConstant: 90),
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: self.safeAreaInsets.top + 20),
            titleLabel.leadingAnchor.constraint(equalTo: self.image.trailingAnchor, constant: self.safeAreaInsets.left + 10),
        ])

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: self.image.trailingAnchor, constant: safeAreaInsets.left + 10),
        ])


        let stackView = UIStackView(arrangedSubviews: [decreaseButton, quantity, increaseButton])
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.spacing = 5
        self.contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: safeAreaInsets.top + 15),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -(safeAreaInsets.bottom + 15)),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -(safeAreaInsets.right + 10)),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        let stack = UIStackView()
        stack.axis = .horizontal
        let image = UIImageView(image: UIImage(systemName: "star.fill"))
        let vStack = UIStackView()
        vStack.axis = .vertical
        
        stack.addArrangedSubview(image)
        stack.addArrangedSubview(vStack)
        
        let title = UILabel()
        title.text = "title"
        title.translatesAutoresizingMaskIntoConstraints = false
        
        let name = UILabel()
        name.text = "name"
    }
    
    //    override func setSelected(_ selected: Bool, animated: Bool) {
    //        super.setSelected(selected, animated: animated)
    //
    //        if selected {
    //            contentView.layer.borderWidth = 2
    //            contentView.layer.borderColor = UIColor.blue.cgColor
    //        } else {
    //            contentView.layer.borderWidth = 1
    //            contentView.layer.borderColor = UIColor.lightGray.cgColor
    //        }
    //    }
    
    //    override func layoutSubviews() {
    //        super.layoutSubviews()
    //        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 16.0, left: 16, bottom: 16, right: 16))
    //    }
}
