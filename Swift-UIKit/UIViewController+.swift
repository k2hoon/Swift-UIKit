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
    
    func setNavigationAppearance(largeTitle: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = largeTitle
        let appearance = UINavigationBarAppearance()
        if !largeTitle {
            // text can be applied when prefersLargeTitles is false
            appearance.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 14)]
        }
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.compactAppearance = appearance
    }
    
    func addChildView(_ child: UIViewController?) {
        guard let child = child else {
            return
        }
        
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func removeChildView() {
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
