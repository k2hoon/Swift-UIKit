//
//  BasicViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/05/01.
//

import UIKit

class BasicViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 20
        view.distribution = .fillEqually
        
        return view
    }()
    
    lazy var basicCollections = BasicCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    func configure() {
        self.configScrollView()
        self.configContentView()
        self.configButtonsStack()
    }
    
    private func configScrollView() {
        self.view.addSubview(self.scrollView)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func configContentView() {
        self.scrollView.addSubview(self.contentView)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let contentHeight = self.contentView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor)
        contentHeight.priority = UILayoutPriority(250)
        contentHeight.isActive = true
        
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
        ])
        
        self.contentView.addSubview(self.stackView)
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        ])
    }
    
    private func configButtonsStack() {
        if let view = self.basicCollections.view {
            self.addChild(self.basicCollections)
            self.stackView.addArrangedSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: self.stackView.topAnchor),
                view.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor),
                view.bottomAnchor.constraint(equalTo: self.stackView.bottomAnchor),
            ])
        }
    }
    
    //    /*
    //    // MARK: - Navigation
    //
    //    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        // Get the new view controller using segue.destination.
    //        // Pass the selected object to the new view controller.
    //    }
    //    */
}
