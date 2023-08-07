//
//  TableViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/06/17.
//

import UIKit

class TableViewController: UIViewController {
    enum Sections {
        case `default`([DefaultItem])
        case value1([Value1Item])
        case value2([Value2Item])
        case subtitle([SubtitleItem])
        
        struct DefaultItem {
            let value: String
        }
        
        struct Value1Item {
            let value: String
        }
        
        struct Value2Item {
            let value: String
        }
        
        struct SubtitleItem {
            let value: String
        }
        
        var headerTitle: String {
            switch self {
            case .default(_): return "Default"
            case .value1(_): return "Value1"
            case .value2(_): return "Value2"
            case .subtitle(_): return "Subtitle"
            }
        }
        
        var footerTitle: String {
            switch self {
            case .default(_):
                return "A simple style for a cell with a text label (black and left-aligned) and an optional image view."
            case .value1(_):
                return "A style for a cell with a label on the left side of the cell with left-aligned and black text; on the right side is a label that has smaller blue text and is right-aligned."
            case .value2(_):
                return "A style for a cell with a label on the left side of the cell with text that’s right-aligned and blue; on the right side of the cell is another label with smaller text that’s left-aligned and black."
            case .subtitle(_):
                return "A style for a cell with a left-aligned label across the top and a left-aligned label below it in smaller gray text."
            }
        }
    }
    
    private let dataSource: [Sections] = [
        .default((1...10).map(String.init).map(Sections.DefaultItem.init(value:))),
        .value1((1...10).map(String.init).map(Sections.Value1Item.init(value:))),
        .value2((1...10).map(String.init).map(Sections.Value2Item.init(value:))),
        .subtitle((1...10).map(String.init).map(Sections.SubtitleItem.init(value:))),
    ]
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        // set table view auto layout.
        self.view.addSubview(self.tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationAppearance(largeTitle: true)
        self.setNavigationTitle()
    }
    
    private func setNavigationAppearance(largeTitle: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = largeTitle
        let appearance = UINavigationBarAppearance()
        if !largeTitle {
            // text can be applied when prefersLargeTitles is false
            appearance.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 14)]
        }
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.compactAppearance = appearance
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    private func setNavigationTitle() {
        self.title = "UITable test"
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.dataSource[section].headerTitle
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return self.dataSource[section].footerTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.dataSource[section] {
        case .default(let items): return items.count
        case .value1(let items): return items.count
        case .value2(let items): return items.count
        case .subtitle(let items): return items.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        var value: String
        switch self.dataSource[indexPath.section] {
        case .default(let items):
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            value = items[indexPath.row].value
        case .value1(let items):
            cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
            value = items[indexPath.row].value
        case .value2(let items):
            cell = UITableViewCell(style: .value2, reuseIdentifier: "cell")
            value = items[indexPath.row].value
        case .subtitle(let items):
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
            value = items[indexPath.row].value
        }
        
        cell.textLabel?.text = value
        cell.imageView?.image = UIImage(systemName: "exclamationmark.circle")
        cell.detailTextLabel?.text = String("subtitle \(value)")
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct TableViewController_Preview: PreviewProvider {
    static var previews: some View {
        TableViewController().toPreview()
    }
}
#endif
