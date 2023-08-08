//
//  UIViewController+.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/08/08.
//

import Foundation
import UIKit

extension UIViewController {
    func setNavigationTitle(title: String, isLargeTitle: Bool = false) {
        self.navigationItem.title = title
        self.navigationItem.largeTitleDisplayMode = .never
    }
}
