//
//  UIColor+.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/09/15.
//

import UIKit

extension UIColor {
    static func random(alpha: CGFloat = 1.0) -> UIColor {
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        return UIColor(red:red, green: green, blue: blue, alpha: alpha)
    }
}
