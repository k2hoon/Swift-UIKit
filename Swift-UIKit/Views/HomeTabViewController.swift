//
//  HomeTabViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/05/01.
//

import UIKit

class HomeTabViewController: UITabBarController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let basicVC = UINavigationController(rootViewController: BasicCollectionViewController())
        basicVC.tabBarItem = UITabBarItem(title: "Basic", image: UIImage(systemName: "square.text.square"), tag: 0)
        
        let testVC = UINavigationController(rootViewController: TestViewController())
        testVC.tabBarItem = UITabBarItem(title: "Test", image: UIImage(systemName: "hammer"), tag: 2)
        
        let advancedVC = AdvancedViewController()
        advancedVC.tabBarItem = UITabBarItem(title: "Advanced", image: UIImage(systemName: "square.3.layers.3d"), tag: 1)

        let settingsVC = SettingsViewController()
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 3)
        
        self.viewControllers = [basicVC, advancedVC, testVC, settingsVC]
    }
    
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct HomeTabViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            HomeTabViewController()
        }
    }
}
#endif
