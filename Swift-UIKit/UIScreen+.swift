//
//  UIScreen+.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/06/17.
//

import Foundation
import UIKit

extension UIScreen {
    static var centerX: CGFloat {
        UIScreen.main.bounds.size.width * 0.5
    }
    
    static var centerY: CGFloat {
        UIScreen.main.bounds.size.height * 0.5
    }
    
    static var center: CGPoint {
        CGPoint(x: centerX, y: centerY)
    }
    
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
}
