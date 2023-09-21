//
//  CompisiteViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/07/14.
//

import UIKit

class CompisiteViewController: UIViewController {
//    enum ViewType: Int, CaseIterable {
//        case text
//        case textScroll
//        case button
//
//        var viewValue: (title: String, vc: UIViewController) {
//            switch self {
//            case .text: return ("Text test", TextViewController())
//            case .textScroll: return ("Text scroll test", TextScrollViewController())
//            case .button: return ("Button test", ButtonViewController())
//            }
//        }
//    }
//    static let identifier = "BasicCollectionView"
//    private let dataSource: [ViewType] = ViewType.allCases
//
//    private let compositionalLayout: UICollectionViewCompositionalLayout = {
//        let itemFractionalWidthFraction = 1.0 / 3.0
//        let groupFractionalHeightFraction = 1.0 / 4.0
//        let itemInset: CGFloat = 2.5
//
//        // Item
//        let itemSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(itemFractionalWidthFraction),
//            heightDimension: .fractionalHeight(1)
//        )
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
//
//        // Group
//        let groupSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1),
//            heightDimension: .fractionalHeight(groupFractionalHeightFraction)
//        )
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//
//        // Section
//        let section = NSCollectionLayoutSection(group: group)
//        section.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
//
//        return UICollectionViewCompositionalLayout(section: section)
//    }()
//
//    private lazy var collectionView: UICollectionView = {
//        let collection = UICollectionView(frame: .zero, collectionViewLayout: self.compositionalLayout)
//        collection.showsHorizontalScrollIndicator = false
//        collection.showsVerticalScrollIndicator = true
//        collection.clipsToBounds = true
//        collection.contentInset = .zero
//        collection.delegate = self
//        collection.dataSource = self
//
//        // Register cell classe
//        collection.register(BasicCollectionViewCell.self, forCellWithReuseIdentifier: BasicCollectionViewCell.identifier)
//        return collection
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view.addSubview(collectionView)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
//            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//        ])
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
////        self.setNavigationTitleIfEmbeded()
////        setNavigationTitle()
//        self.setNavigationBar()
//    }
//
//    private func setNavigationBar() {
//        self.title = "BasicCollectionView"
//        self.navigationController?.navigationBar.prefersLargeTitles = true // defulat is false
////        let appearance = UINavigationBarAppearance()
////        appearance.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 14)] // text can be applied when prefersLargeTitles is false
////        appearance.backgroundColor = .systemGray
////        self.navigationController?.navigationBar.standardAppearance = appearance
////        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
//        //        self.navigationController?.navigationBar.compactAppearance = appearance
//    }
//
//    private func setNavigationTitleIfEmbeded() {
//        // use one of them
//        self.title = "title"
////        self.navigationItem.title = "!!!"
////        self.navigationController?.navigationBar.topItem?.title = "###"
//    }
//
//    private func setNavigationTitle() {
//        self.title = "???" // chagne both navigation title and tab item text when navigation controller embeded in tabBar controller.
//        self.navigationController?.title = "$$$" // change tab item text when navigation controller embeded in tabBar controller.
//    }
}

//extension CompisiteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
////    func numberOfSections(in collectionView: UICollectionView) -> Int {
////        10
////    }
//    
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.dataSource.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasicCollectionViewCell.identifier, for: indexPath) as! BasicCollectionViewCell
//        
//        let viewValue = self.dataSource[indexPath.item].viewValue
//        cell.setLabel(text: viewValue.title)
//        cell.button.addAction { [weak self] in
//            self?.navigationController?.pushViewController(viewValue.vc, animated: true)
//        }
//        return cell
//    }
//}
