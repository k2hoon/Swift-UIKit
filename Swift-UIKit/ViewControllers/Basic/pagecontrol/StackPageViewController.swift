//
//  StackPageViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/09/23.
//

import UIKit

class StackPageViewController: UIViewController {
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.delegate = self
        scroll.alwaysBounceVertical = false
        scroll.showsVerticalScrollIndicator = false
        scroll.isPagingEnabled = true
        return scroll
    }()
    
    lazy var scrollContents: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        return stack
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
        self.view.backgroundColor = .systemBackground
        self.layoutViews()
        self.setScrollContents()
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
        
        scrollView.addSubview(scrollContents)
        scrollContents.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollContents.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContents.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollContents.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollContents.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollContents.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
        ])
        
        self.view.addSubview(pageControl)
    }
    
    private func setScrollContents() {
        imageItems.forEach { name in
            let image = UIImage(named: name)
            let imageView = UIImageView(image: image)

//            imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
//            imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
            imageView.contentMode = .scaleToFill
            scrollContents.addArrangedSubview(imageView)
        }
    }
    
}

extension StackPageViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = scrollView.contentOffset.x / scrollView.frame.size.width
        self.pageControl.currentPage = Int(round(value))
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct StackPageViewController_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            StackPageViewController()
        }
    }
}
#endif
