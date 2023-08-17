//
//  UITextField+.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/08/18.
//

import UIKit

extension UITextField {
    func setLeftPadding(_ value: CGFloat = 8) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: value, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPadding(_ value: CGFloat = 8) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: value, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
