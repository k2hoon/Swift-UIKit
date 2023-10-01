//
//  SearchBarViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/09/30.
//

import UIKit

class SearchBarViewController: UIViewController {
    lazy var searchBar = SearchBar()
    
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewLayout.default())
        collection.keyboardDismissMode = .onDrag
        collection.delegate = self
        collection.dataSource = self
        collection.register(UserCollectionCell.self, forCellWithReuseIdentifier: UserCollectionCell.identifier)
        
        return collection
    }()
    
    lazy var dataSource: [User] = {
        guard let users: [User] = try? ModelDataLoader().load("UserFake.json") else {
            return []
        }
        return users
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.layoutView()
    }
    
    func layoutView() {
        [searchBar, collectionView].forEach {
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 44),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

extension SearchBarViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCollectionCell.identifier, for: indexPath) as! UserCollectionCell
        cell.setCellItem(dataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.searchBar.isKeyboardActive {
            self.searchBar.dismissKeyboard()
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct SearchViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            SearchBarViewController()
        }
    }
}
#endif

