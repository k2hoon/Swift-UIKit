//
//  ButtonPopUpViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/08/10.
//

import UIKit

class ButtonPopUpViewController: UIViewController {
    private lazy var popupButton: UIButton = {
        let sortMenu = UIMenu(title: "Sort By", options: .singleSelection, children: [
            UIAction(title: "Title", handler: sortClosure),
            UIAction(title: "Date", handler: sortClosure),
            UIAction(title: "Size", handler: sortClosure)
        ])
        
        let button = UIButton(primaryAction: nil)
        button.setTitle("Popup Button", for: .normal)
        button.showsMenuAsPrimaryAction = true
        button.changesSelectionAsPrimaryAction = true
        
        button.menu = UIMenu(children: [sortMenu])
        return button
    }()
    
    let sortClosure = { (action: UIAction) in }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setNavigationTitle(title: "Button Popup")
        
        self.view.addSubview(popupButton)
        popupButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popupButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ButtonPopUpViewController_Preview: PreviewProvider {
    static var previews: some View {
        ButtonPopUpViewController().toPreview()
    }
}
#endif
