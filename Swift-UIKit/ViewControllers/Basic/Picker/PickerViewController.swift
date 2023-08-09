//
//  PickerViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/08/09.
//

import UIKit

class PickerViewController: UIViewController {
    lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    lazy var selectionLabel: UILabel = {
       let label = UILabel()
        label.text = self.testItems[0]
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textField: UITextField = {
        // Create UITextField
        let textField: UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 300.00, height: 30.00));
        textField.placeholder = "Place holder text"
        textField.borderStyle = UITextField.BorderStyle.line
        textField.backgroundColor = UIColor.white
        textField.textColor = UIColor.blue
        
        return textField
    }()
    
    private let testItems = ["Item1", "Item2", "Item3", "Item4", "Item5"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .white
        self.setNavigationTitle(title: "PickerViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(selectionLabel)
        NSLayoutConstraint.activate([
            selectionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            selectionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            selectionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        self.view.addSubview(pickerView)
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: selectionLabel.bottomAnchor),
            pickerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.testItems.count
    }
        
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.testItems[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectionLabel.text = self.testItems[row]
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct PickerViewController_Preview: PreviewProvider {
    static var previews: some View {
        PickerViewController().toPreview()
    }
}
#endif


