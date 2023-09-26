//
//  LabelCollectionViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/08/18.
//

import UIKit

class LabelCollectionViewController: UIViewController {
    enum ViewType: Int, CaseIterable {
        case `default`
        case padding
        case scroll
        
        var viewValue: (title: String, vc: UIViewController) {
            switch self {
            case .`default`: return ("Default UILabel", LabelViewController())
            case .padding: return ("UILabel with padding", LabelPaddingViewController())
            case .scroll: return ("UILabel with scrolling", LabelScrollViewController())
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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        
        return tableView
    }()
    
    private let dataSource: [ViewType] = ViewType.allCases
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.layoutNavigationBar()
        self.layoutTableView()
    }
    
    private func layoutNavigationBar() {
        // set navigation bar items
        let naviItem = UINavigationItem(title: "Text Collection")
        naviItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(dismissView))
        
        // add navigation bar items
        navigationBar.items = [naviItem]
        
        // autolayout
        view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
    
    func layoutTableView() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    @objc func dismissView(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

// MARK: - UINavigationBarDelegate
extension LabelCollectionViewController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

// MARK: - UITableViewDelegate
extension LabelCollectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
}

// MARK: - UITableViewDataSource
extension LabelCollectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Text collection"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let viewValue = self.dataSource[indexPath.item].viewValue
        cell.selectionStyle = .none
        cell.textLabel?.text = viewValue.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewType = self.dataSource[indexPath.item]
        self.navigationController?.pushViewController(viewType.viewValue.vc, animated: true)
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct TextCollectionViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            LabelCollectionViewController()
        }
    }
}
#endif
