//
//  ScrollPageViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/09/23.
//

import UIKit

class ScrollPageViewController: UIViewController {
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.delegate = self
        scroll.alwaysBounceVertical = false
        scroll.showsVerticalScrollIndicator = false
        scroll.isPagingEnabled = true
        scroll.bounces = false
        return scroll
    }()
    
    lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.frame = CGRect(x: 0, y: view.frame.maxY - 100, width: view.frame.width, height: 50)
        control.numberOfPages = imageItems.count
        control.currentPage = 0
        control.currentPageIndicatorTintColor = .systemBlue
        control.pageIndicatorTintColor = .white
        control.backgroundColor = .systemGray
        control.isUserInteractionEnabled = false
        return control
    }()
    
    private let imageItems = (0...6).map { "image-\($0 + 1)" }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layoutViews()
        setScrollContents()
    }
    
    private func setScrollContents() {
        for (index, name) in imageItems.enumerated() {
            var image = UIImage(named: name)
            let imageView = UIImageView(image: image)
            imageView.frame.origin.x = UIScreen.main.bounds.width * CGFloat(index)
            imageView.frame.size = .init(width: view.frame.width, height: view.frame.height)
            imageView.contentMode = .scaleAspectFit
            
            scrollView.addSubview(imageView)
        }
        
        scrollView.contentSize.width = UIScreen.main.bounds.width * CGFloat(6)
    }
    
    private func layoutViews() {
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        self.view.addSubview(pageControl)
    }
    
}

extension ScrollPageViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(round(value))
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ScrollPageViewController_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            ScrollPageViewController()
        }
    }
}
#endif
