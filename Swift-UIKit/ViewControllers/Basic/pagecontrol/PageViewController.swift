//
//  PageViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/09/22.
//

import Foundation
import UIKit

class PageViewController: UIViewController {
    lazy var pageController: UIPageViewController = {
        // spine option occurs crash, use instead delegate
        let page = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: [.interPageSpacing: 10]
        )
        page.isDoubleSided = false
        page.delegate = self
        page.dataSource = self
        return page
    }()
    
    lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.numberOfPages = self.pageContents.count
        control.currentPage = 0
        control.currentPageIndicatorTintColor = .systemBlue
        control.pageIndicatorTintColor = .white
        control.backgroundColor = .systemGray
        control.isUserInteractionEnabled = false
        return control
    }()
    
    private let pageContents: [UIViewController] = (0..<6).map { PageContentsController(number: $0) }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.layoutViews()
    }
}

extension PageViewController {
    private func layoutViews() {
        self.addChildView(pageController)
        pageController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pageController.view.heightAnchor.constraint(equalToConstant: 400),
            pageController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pageController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        self.view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: pageController.view.bottomAnchor, constant: -16),
            pageControl.centerXAnchor.constraint(equalTo: pageController.view.centerXAnchor),
        ])
        
        // set page control configure
        pageController.setViewControllers([pageContents[0]], direction: .forward, animated: true)
        
        pageControl.addAction(for: .valueChanged) { [unowned self] in
            print(pageControl.currentPage)
            let index = pageControl.currentPage
            pageController.setViewControllers([pageContents[index]], direction: .forward, animated: false)
        }
    }
}

// MARK: - PageViewController Delegate
extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    // MARK: UIPageViewControllerDelegate
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pageContents.firstIndex(of: viewController) else {
            return nil
        }
        
        return (index == 0) ? pageContents.last : pageContents[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pageContents.firstIndex(of: viewController) else {
            return nil
        }
        
        return index == pageContents.endIndex - 1 ? pageContents.first : pageContents[index + 1]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageContents.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    // MARK: UIPageViewControllerDataSource
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let content = pageViewController.viewControllers?.first {
            if let index = pageContents.firstIndex(of: content) {
                pageControl.currentPage = index
            }
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, spineLocationFor orientation: UIInterfaceOrientation) -> UIPageViewController.SpineLocation {
        // TODO: Do not use .mid, perhaps it is broken
        return .min
    }
}

class PageContentsController: UIViewController {
    let number: Int
    
    init(number: Int) {
        self.number = number
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow
        
        // label
        let label = UILabel()
        self.view.addSubview(label)
        label.text = String(format: "Page %d", number)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
            label.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
        ])
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct PageViewController_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            PageViewController()
        }
    }
}
#endif
