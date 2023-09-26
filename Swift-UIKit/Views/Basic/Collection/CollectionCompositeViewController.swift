//
//  CollectionCompositeViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/09/22.
//

import UIKit

class CollectionCompositeViewController: UIViewController {
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
    
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: setCompositionalLayout())
        collection.isScrollEnabled = true
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = true
        collection.scrollIndicatorInsets = UIEdgeInsets(top: -2, left: 0, bottom: 0, right: 4)
        collection.contentInset = .zero
        collection.backgroundColor = .clear
        collection.clipsToBounds = true
        
        collection.delegate = self
        collection.dataSource = self
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collection.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        
        collection.register(
            FlowHeaderReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: FlowHeaderReusableView.identifier)
        
        collection.register(
            FlowFooterReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: FlowFooterReusableView.identifier)
        
        return collection
    }()
    
    func setCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        UICollectionViewCompositionalLayout { section, config in
            switch self.dataSource[section] {
            case .color:
                let itemFractionalWidthFraction = 1.0 / 3.0
                let groupFractionalHeightFraction = 1.0 / 4.0
                
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(widthDimension: .absolute(70), heightDimension: .absolute(70)),
                    subitems: [item]
                )
                
                // section
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
//                section.interGroupSpacing = 10
                section.contentInsets = .init(top: 30, leading: 10, bottom: 30, trailing: 10)
                section.boundarySupplementaryItems = [
                    NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)),
                        elementKind: UICollectionView.elementKindSectionHeader,
                        alignment: .top
                    ),
                    NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)),
                        elementKind: UICollectionView.elementKindSectionFooter,
                        alignment: .bottom
                    )
                ]
                
//                section.supplementaryContentInsetsReference = .layoutMargins
                
                return section
            case .number:
                let itemFractionalWidthFraction = 1.0 / 3.0
                let groupFractionalHeightFraction = 1.0 / 4.0
                let itemInset: CGFloat = 2.5
                
                let itemSize = NSCollectionLayoutSize(
                          widthDimension: .fractionalWidth(itemFractionalWidthFraction),
                          heightDimension: .fractionalHeight(1)
                        )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
                
                // Group
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(groupFractionalHeightFraction)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                // Section
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
                section.boundarySupplementaryItems = [
                    NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)),
                        elementKind: UICollectionView.elementKindSectionHeader,
                        alignment: .top
                    ),
                    NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)),
                        elementKind: UICollectionView.elementKindSectionFooter,
                        alignment: .bottom
                    )
                ]
                return section
            }
        }
    }
    
//    let compositionalLayout: UICollectionViewCompositionalLayout = {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//
//        let section = NSCollectionLayoutSection(group: group)
//        let layout = UICollectionViewCompositionalLayout(section: section)
//
//        return layout
//    }()
    
    let dataSource: [DataSource] = {
        let colors = (0...20).map { _ in ColorItem() }
        let numbers = (0...20).map { NumberItem(numer: $0) }
        return [DataSource.color(colors)] + [DataSource.number(numbers)]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        // Do any additional setup after loading the view.
        self.layoutCollectionView()
    }
    
    func layoutCollectionView() {
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

extension CollectionCompositeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch dataSource[section] {
        case .color(let items):
            return items.count
        case .number(let items):
            return items.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch dataSource[indexPath.section] {
        case .color(let items):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
            cell.backgroundColor = items[indexPath.item].color
            return cell
        case .number(let items):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
            cell.setItems(title: String(items[indexPath.item].numer))
            cell.contentView.layer.borderColor = UIColor.black.cgColor
            cell.contentView.layer.borderWidth = 1.0
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: FlowHeaderReusableView.identifier,
                for: indexPath
            ) as! FlowHeaderReusableView
            view.setItems(title: "Header view")
            return view
        case UICollectionView.elementKindSectionFooter:
            let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: FlowFooterReusableView.identifier,
                for: indexPath
            ) as! FlowFooterReusableView
            view.setItems(title: "Footer view")
            return view
        default:
            return UICollectionReusableView()
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct CollectionCompositeViewController_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            CollectionCompositeViewController()
        }
    }
}
#endif

