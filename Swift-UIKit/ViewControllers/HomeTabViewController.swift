//
//  HomeTabViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/05/01.
//

import UIKit

class HomeTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let basicVC = BasicViewController()
        basicVC.tabBarItem = UITabBarItem(title: "Basic", image: UIImage(systemName: "square.text.square"), tag: 0)
        
        let testVC = UINavigationController(rootViewController: TestViewController())
        testVC.tabBarItem = UITabBarItem(title: "Test", image: UIImage(systemName: "hammer"), tag: 2)
        
        let advancedVC = AdvancedViewController()
        advancedVC.tabBarItem = UITabBarItem(title: "Advanced", image: UIImage(systemName: "square.3.layers.3d"), tag: 1)

        let settingsVC = SettingsViewController()
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 3)
        
        self.viewControllers = [basicVC, advancedVC, testVC, settingsVC]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.setTabBarAppearance()
//        self.setTabItemAppearance()
    }
    
    private func setTabBarAppearance() {
        let apperance: UITabBarAppearance = UITabBarAppearance()
        let tabBar = UITabBar.appearance()
//        apperance.configureWithDefaultBackground()
        apperance.configureWithTransparentBackground()
//        apperance.configureWithOpaqueBackground()
//        apperance.backgroundColor = UIColor.gray
        
        tabBar.standardAppearance = apperance
        tabBar.scrollEdgeAppearance = apperance
                
//        UITabBar.appearance().isTranslucent = true
//        UITabBar.appearance().barTintColor = .green // tab bar color
//        UITabBar.appearance().backgroundColor = .yellow // view background color
//        UITabBar.appearance().tintColor = .red // bar item color
//        UITabBar.appearance().unselectedItemTintColor = .blue // unselected bar item color
        
//        let tabBar = UITabBar.appearance()
//        tabBar.tintColor = .red
//        tabBar.isTranslucent = true
//        tabBar.backgroundColor = .gray
    }
    
    private func setTabItemAppearance() {
        let tabItem = UITabBarItem.appearance()
        tabItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)
        tabItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .disabled)
        tabItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)], for: .normal)
    }
    
    /// not working anymore after iOS 15
    private func setTabBarTintColor() {
        self.tabBar.barTintColor = .gray
        self.tabBar.isTranslucent = false
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct HomeTabViewController_Preview: PreviewProvider {
    static var previews: some View {
        HomeTabViewController().toPreview()
    }
}
#endif
