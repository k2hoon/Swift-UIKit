//
//  CollectionViewController+.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/09/27.
//

import UIKit

extension CollectionViewController {
    enum DataSource {
        case color([ColorItem])
        case number([NumberItem])
    }
    
    struct ColorItem {
        var color: UIColor = UIColor(red: CGFloat(drand48()),
                                     green: CGFloat(drand48()),
                                     blue: CGFloat(drand48()),
                                     alpha: 1.0)
    }
    
    struct NumberItem {
        let numer: Int
    }
}
