//
//  CustomTableViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/06/17.
//

import UIKit

class CustomTableViewController: UIViewController {
    var customCells = [CustomCell]()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        
        // Because it is assumed that it is made in `Interface Builder`
        // tableView.rowHeight = UITableView.automaticDimension
        // tableView.estimatedRowHeight = 80
        return table
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white

        //
        self.createCustomCells()
        
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
        self.customCells.append(CustomCell(image: "app.fill", name: "AAA", title: "Hello, AAA"))
        self.customCells.append(CustomCell(image: "app.fill", name: "BBB", title: "Hello, BBB"))
        self.customCells.append(CustomCell(image: "app.fill", name: "CCC", title: "Hello, CCC"))
        self.customCells.append(CustomCell(image: "app.fill", name: "DDD", title: "Hello, DDD"))
        self.customCells.append(CustomCell(image: "app.fill", name: "EEE", title: "Hello, EEE"))
        self.customCells.append(CustomCell(image: "app.fill", name: "FFF", title: "Hello, FFF"))
        self.customCells.append(CustomCell(image: "app.fill", name: "GGG", title: "Hello, GGG"))
        self.customCells.append(CustomCell(image: "app.fill", name: "HHH", title: "Hello, HHH"))
        self.customCells.append(CustomCell(image: "app.fill", name: "III", title: "Hello, III"))
    }
}

extension CustomTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.customCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        let custom = self.customCells[indexPath.row]
        cell.item = custom
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

