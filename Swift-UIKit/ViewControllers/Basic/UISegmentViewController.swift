//
//  UISegmentViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/08/17.
//

import UIKit

class UISegmentViewController: UIViewController {
    
    let segmentItems = ["Red", "Green", "Blue"]
    
    lazy var segmentView: UISegmentedControl = {
        let segment = UISegmentedControl(items: self.segmentItems)
        segment.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }()
    
    lazy var colorLabel: UILabel = {
        let label = UILabel(frame: .init(x: 0, y: 0, width: 200, height: 200))
        label.backgroundColor = .white
        label.textColor = .black
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = label.frame.width / 2
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Segment"
        self.view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(segmentView)
        NSLayoutConstraint.activate([
            segmentView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            segmentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18)
        ])
        
        self.view.addSubview(colorLabel)
        NSLayoutConstraint.activate([
            colorLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            colorLabel.topAnchor.constraint(equalTo: segmentView.bottomAnchor, constant: 18),
            colorLabel.widthAnchor.constraint(equalToConstant: 200),
            colorLabel.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    @objc func segmentChanged(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            colorLabel.backgroundColor = .red
            colorLabel.text = segmentItems[0]
        case 1:
            colorLabel.backgroundColor = .green
            colorLabel.text = segmentItems[1]
        case 2:
            colorLabel.backgroundColor = .blue
            colorLabel.text = segmentItems[2]
        default:
            break
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct UISegmentViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            UISegmentViewController()
        }
    }
}
#endif
