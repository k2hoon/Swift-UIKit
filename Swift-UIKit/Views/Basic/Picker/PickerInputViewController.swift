//
//  PickerInputViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/08/09.
//

import UIKit

class PickerInputViewController: UIViewController {
    lazy var labelVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .leading
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var yearLabelStack: UIStackView = {
        let label = UILabel()
        label.text = "Selected Year:"
        
        let stack = UIStackView(arrangedSubviews: [label, yearLabel])
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .leading
        stack.distribution = .equalSpacing
        return stack
    }()
    
    lazy var monthLabelStack: UIStackView = {
        let label = UILabel()
        label.text = "Selected Month:"
        
        let stack = UIStackView(arrangedSubviews: [label, monthLabel])
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .leading
        stack.distribution = .equalSpacing
        return stack
    }()
    
    lazy var textField: UITextField = {
        let textField: UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 300.00, height: 30.00));
        textField.placeholder = "Place holder text"
        textField.borderStyle = .line
        textField.backgroundColor = .white
        textField.textColor = .black
        
        return textField
    }()
    
    lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.text = "year"
        return label
    }()
    
    lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.text = "month"
        
        return label
    }()
    
    private var yearItems: [Int] = []
    private var monthItems: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    private var selectedYear = 0
    private var selectedMonth = 0
    private var currentYear = "0"
    private var currentMonth = "0"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(textField)
        textField.center = self.view.center
        setAvailableDate()
        createPickerView()
        
        labelVStack.addArrangedSubview(yearLabelStack)
        labelVStack.addArrangedSubview(monthLabelStack)
        self.view.addSubview(labelVStack)
        NSLayoutConstraint.activate([
            labelVStack.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -16),
            labelVStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            labelVStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        textField.tintColor = .clear
        
        // set toolbar
        let toolBar = UIToolbar()
        toolBar.isTranslucent = true
        toolBar.tintColor = .black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onPickDone))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(onPickCancel))
        toolBar.setItems([cancelButton , space , doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        // assign customs
        textField.inputView = pickerView
        textField.inputAccessoryView = toolBar
    }
    
    func updateSelectedLabels() {
        yearLabel.text = "\(selectedYear)"
        monthLabel.text = "\(selectedMonth)"
    }
    
    @objc func onPickDone() {
        self.updateSelectedLabels()
        textField.resignFirstResponder()
    }
    
    @objc func onPickCancel() {
        // use endEditing or resignFirstResponder
        textField.endEditing(true) // textField.resignFirstResponder()
    }
    
    func setAvailableDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        currentYear = dateFormatter.string(from: Date())
        for year in 2020...Int(currentYear)! {
            self.yearItems.append(year)
        }
        
        dateFormatter.dateFormat = "MM"
        currentMonth = dateFormatter.string(from: Date())
        
        selectedYear = Int(currentYear)!
        selectedMonth = Int(currentMonth)!
        
        self.updateSelectedLabels()
    }
    
}

extension PickerInputViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        switch component {
        case 0: return NSAttributedString(string: String(yearItems[row]), attributes: [.foregroundColor: UIColor.systemBlue])
        case 1: return NSAttributedString(string: String(monthItems[row]), attributes: [.foregroundColor: UIColor.black])
        default: return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return yearItems.count
        case 1: return monthItems.count
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0: return "\(yearItems[row])"
        case 1: return "\(monthItems[row])"
        default: return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0: selectedYear = yearItems[row]
        case 1: selectedMonth = monthItems[row]
        default: break
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct PickerInputViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            PickerInputViewController()
        }
    }
}
#endif
