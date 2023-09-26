//
//  CollectionCompositeViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/09/22.
//

import UIKit

class CollectionCompositeViewController: UIViewController {
    let dataSource: [DataSource] = {
        let colors = (0...20).map { _ in ColorItem() }
        let pages = (0...5).map { PageItem(imageName: "image-\($0 + 1)")}
        let numbers = (0...20).map { NumberItem(numer: $0) }
        return [DataSource.color(colors)] + [DataSource.page(pages)] + [DataSource.number(numbers)]
    }()
    
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout)
        collection.delegate = self
        collection.dataSource = self
        
        // register cell
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collection.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collection.register(
            CollectionHeaderReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CollectionHeaderReusableView.identifier)
        
        collection.register(
            CollectionFooterReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: CollectionFooterReusableView.identifier)
        
        // scroll setting
        collection.isScrollEnabled = true
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = true
        collection.scrollIndicatorInsets = UIEdgeInsets(top: -2, left: 0, bottom: 0, right: 4)
        collection.contentInset = .zero
        collection.backgroundColor = .clear
        collection.clipsToBounds = true
        
        return collection
    }()
    
    lazy var compositionalLayout:UICollectionViewCompositionalLayout = {
        UICollectionViewCompositionalLayout { section, config in
            switch self.dataSource[section] {
            case .color: return self.setColorSection()
            case .page: return self.setPageSection()
            case .number: return self.setNumberSection()
            }
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        self.layoutViews()
    }
    
    func layoutViews() {
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

extension CollectionCompositeViewController {
    private func setColorSection() -> NSCollectionLayoutSection {
        // set Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // set Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(70),
            heightDimension: .absolute(70)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        section.contentInsets = .init(top: 30, leading: 10, bottom: 30, trailing: 10)
        section.boundarySupplementaryItems = [
            // header
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44)),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            ),
            
            // footer
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(150)),
                elementKind: UICollectionView.elementKindSectionFooter,
                alignment: .bottom
            )
        ]
        return section
    }
    
    private func setPageSection() -> NSCollectionLayoutSection {
        // set Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.3),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        // set Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.3)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        section.boundarySupplementaryItems = [
            // header
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44)),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            ),
            
            // footer
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(150)),
                elementKind: UICollectionView.elementKindSectionFooter,
                alignment: .bottom
            )
        ]
        return section
    }
    
    private func setNumberSection() -> NSCollectionLayoutSection {
        // set Item
        let itemFractionalWidth: CGFloat = 1 / 3
        let itemInset: CGFloat = 2.5
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemFractionalWidth),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
        
        // set Group
        let groupFractionalHeight: CGFloat = 1 / 4
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(groupFractionalHeight)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // set Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
        section.boundarySupplementaryItems = [
            // header
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100)),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            ),
            // footer
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/4)),
                elementKind: UICollectionView.elementKindSectionFooter,
                alignment: .bottom
            )
        ]
        return section
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension CollectionCompositeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch dataSource[section] {
        case .color(let items):
            return items.count
        case .page(let items):
            return items.count
        case .number(let items):
            return items.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        
        switch dataSource[indexPath.section] {
        case .color(let items):
            cell.setItems(color: items[indexPath.item].color)
        case .page(let items):
            cell.setImage(name: items[indexPath.item].imageName)
        case .number(let items):
            cell.setItems(number: items[indexPath.item].numer, border: true)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return getHeaderView(collectionView, kind: kind, at: indexPath)
        case UICollectionView.elementKindSectionFooter:
            return getFooterView(collectionView, kind: kind, at: indexPath)
        default:
            return UICollectionReusableView()
        }
    }
    
    private func getHeaderView(_ collectionView: UICollectionView, kind: String, at indexPath: IndexPath) -> CollectionHeaderReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: CollectionHeaderReusableView.identifier,
            for: indexPath
        ) as! CollectionHeaderReusableView
        view.setItems(title: "Header view")
        return view
    }
    
    private func getFooterView(_ collectionView: UICollectionView, kind: String, at indexPath: IndexPath) -> CollectionFooterReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: CollectionFooterReusableView.identifier,
            for: indexPath
        ) as! CollectionFooterReusableView
        view.setItems(title: "Footer view")
        return view
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
