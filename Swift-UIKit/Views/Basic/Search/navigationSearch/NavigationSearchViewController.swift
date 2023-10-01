//
//  NavigationSearchViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/09/30.
//

import UIKit

class NavigationSearchViewController: UIViewController {
    lazy var searchController: UISearchController = {
        let searchResult = SearchResultViewController(collectionViewLayout: CollectionViewLayout.default())
        let search = UISearchController(searchResultsController: searchResult)
        search.hidesNavigationBarDuringPresentation = true
        search.obscuresBackgroundDuringPresentation = true
        search.searchResultsUpdater = self
        search.searchBar.delegate = self
        search.searchBar.scopeButtonTitles = ["All", "swift"]
        
        self.definesPresentationContext = true
        return search
    }()
    
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewLayout.default())
        
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
    
    private var filteredDataSource: [User] = []
    
    private var isSearching: Bool {
        let isActive = self.searchController.isActive
        let isNotEmpty = self.searchController.searchBar.text?.isEmpty == false
        
        return isActive && isNotEmpty
    }
    
    private var hasSearchResult: Bool {
        return self.searchController.searchResultsController != nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.setNavigationBar()
        self.layoutView()
    }
    
    func setNavigationBar() {
        self.title = "NavigationSearch"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func layoutView() {
        [collectionView].forEach {
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

extension NavigationSearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.isSearching ? filteredDataSource.count : dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCollectionCell.identifier, for: indexPath) as! UserCollectionCell
        
        if hasSearchResult {
            cell.setCellItem(dataSource[indexPath.row])
        } else {
            if self.isSearching {
                cell.setCellItem(filteredDataSource[indexPath.row])
            } else {
                cell.setCellItem(dataSource[indexPath.row])
            }
        }
        
        return cell
    }
}

extension NavigationSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchBar::textDidChange")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarCancelButtonClicked")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarSearchButtonClicked")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidEndEditing")
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarBookmarkButtonClicked")
    }
}

extension NavigationSearchViewController: UISearchResultsUpdating {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        if let scopes = searchBar.scopeButtonTitles {
            let scopeText = scopes[selectedScope]
            if scopeText == "All" {
                searchBar.text = ""
            } else {
                searchBar.text = scopeText
            }
        }
        updateSearchResults(for: self.searchController)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        
        let searchResults = self.dataSource
        let filteredResults = searchResults.filter{ $0.name.localizedCaseInsensitiveContains(text) }
        if let resultController = searchController.searchResultsController as? SearchResultViewController {
            resultController.filteredDataSource = filteredResults
            resultController.collectionView.reloadData()
            
            resultController.resultLabel.text = resultController.filteredDataSource.isEmpty ?
            NSLocalizedString("NoItemsFoundTitle", comment: "") :
            String(format: NSLocalizedString("Items found: %ld", comment: ""),
                   resultController.filteredDataSource.count)
        } else {
            self.filteredDataSource = self.dataSource.filter{ $0.name.localizedCaseInsensitiveContains(text) }
            self.collectionView.reloadData()
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct NavigationSearchViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            UINavigationController(rootViewController: NavigationSearchViewController())
        }
    }
}
#endif
