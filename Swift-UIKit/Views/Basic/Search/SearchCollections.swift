//
//  SearchCollections.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/09/30.
//

import UIKit

class SearchCollections: UIViewController {
    enum ViewType: Int, CaseIterable {
        case navigationSearch
        case custom
        
        var viewValue: (title: String, vc: UIViewController) {
            switch self {
            case .navigationSearch: return ("Navigation Search", NavigationSearchViewController())
            case .custom: return ("Custom SearchBar", SearchBarViewController())
            }
        }
    }
    
    private lazy var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.delegate = self
        navigationBar.isTranslucent = false
        navigationBar.backgroundColor = .systemBackground
        
        return navigationBar
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createBasicListLayout())
        collection.delegate = self
        collection.dataSource = self
        collection.register(DefaultCollectionCell.self, forCellWithReuseIdentifier: DefaultCollectionCell.identifier)
        
        return collection
    }()
    
    private let dataSource: [ViewType] = ViewType.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.setNavigationBar()
        self.layoutView()
    }
    
    private func layoutView() {
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func setNavigationBar() {
        // set navigation bar items
        let naviItem = UINavigationItem(title: "SearchCollections")
        naviItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(dismissView))
        
        // add navigation bar items
        navigationBar.items = [naviItem]
        
        // autolayout
        view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    func createBasicListLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    @objc func dismissView(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

extension SearchCollections: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DefaultCollectionCell.identifier, for: indexPath) as! DefaultCollectionCell
        
        let viewValue = self.dataSource[indexPath.item].viewValue
        cell.setCellItem(viewValue.title)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewType = self.dataSource[indexPath.item]
        self.navigationController?.pushViewController(viewType.viewValue.vc, animated: true)
    }
}

// MARK: - UINavigationBarDelegate
extension SearchCollections: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct SearchCollections_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            UINavigationController(rootViewController: SearchCollections())
        }
    }
}
#endif
