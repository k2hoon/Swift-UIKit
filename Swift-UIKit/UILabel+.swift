//
//  UILabel+.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/08/17.
//

import UIKit

extension UILabel {
    func clipShape() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.bounds.size.height / 2
    }
    
    func border(color: UIColor = .black, width: CGFloat = 1) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}
