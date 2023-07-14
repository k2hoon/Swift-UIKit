//
//  TableViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/06/17.
//

import UIKit

class TableViewController: UIViewController {
    private let tests = (0...30).map { $0 }
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationTitleIfEmbeded()
        self.setNavigationBar()
        
    }
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true // defulat is false
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 14)] // text can be applied when prefersLargeTitles is false
        appearance.backgroundColor = .systemGray
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
//        self.navigationController?.navigationBar.compactAppearance = appearance
    }
    
    private func setNavigationTitleIfEmbeded() {
        // use one of them
        self.navigationItem.title = "!!!"
//        self.navigationController?.navigationBar.topItem?.title = "###"
    }
    
    private func setNavigationTitle() {
//        self.title = "???" // chagne both navigation title and tab item text when navigation controller embeded in tabBar controller.
//        self.navigationController?.title = "$$$" // change tab item text when navigation controller embeded in tabBar controller.
    }
    
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Table view data source

//    func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tests.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String(self.tests[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SecondViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        print(indexPath.row)
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

class SecondViewController: UIViewController {
    private let backButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    private func initialSetup() {
        // basic setup
        view.backgroundColor = .white
        navigationItem.title = "Second Controller"
        
        // button customization
        backButton.backgroundColor = .darkGray
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.white, for: .normal)
        backButton.layer.cornerRadius = 8
        backButton.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        
        // adding constraint to button
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc private func handleBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
