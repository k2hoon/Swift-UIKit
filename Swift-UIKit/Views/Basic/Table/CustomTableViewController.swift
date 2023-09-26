//
//  CustomTableViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/06/17.
//

import UIKit

class CustomTableViewController: UIViewController {
    private var customCells = [CustomCell]()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.createCustomCells()
        self.layoutViews()
    }
    
    private func layoutViews() {
        // set table view auto layout.
        self.view.addSubview(self.tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    func createCustomCells() {
        self.customCells.append(CustomCell(title: "Hello, AAA", subtitle: "AAA", imageName: ""))
        self.customCells.append(CustomCell(
            title: "Hello, BBB",
            subtitle: "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB\nBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB",
            imageName: "app.fill")
        )
        self.customCells.append(contentsOf: [
            CustomCell(title: "Hello, CCC", subtitle: "CCC", imageName: "app.fill"),
            CustomCell(title: "Hello, DDD", subtitle: "DDD", imageName: "app.fill"),
            CustomCell(title: "Hello, EEE", subtitle: "EEE", imageName: "app.fill"),
            CustomCell(title: "Hello, FFF", subtitle: "FFF", imageName: "app.fill"),
            CustomCell(title: "Hello, GGG", subtitle: "GGG", imageName: "app.fill"),
            CustomCell(title: "Hello, HHH", subtitle: "HHH", imageName: "app.fill"),
            CustomCell(title: "Hello, III", subtitle: "III", imageName: "app.fill"),
            CustomCell(title: "Hello, JJJ", subtitle: "JJJ", imageName: "app.fill"),
        ])
    }
}

// MARK: - CustomTableViewController Table methods
extension CustomTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.customCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        let item = self.customCells[indexPath.row]
        cell.updateCellItem(item)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct CustomTableViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            CustomTableViewController()
        }
    }
}
#endif
