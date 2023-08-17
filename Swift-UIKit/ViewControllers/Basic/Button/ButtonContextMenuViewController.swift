//
//  ButtonContextMenuViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/08/17.
//

import UIKit

class ButtonContextMenuViewController: UIViewController {
    
    private lazy var menuButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Button", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOpacity = 1.0
        button.layer.shadowOffset = CGSize.zero
        button.layer.shadowRadius = 6
        
        let interaction = UIContextMenuInteraction(delegate: self)
        button.addInteraction(interaction)
        return button
    }()
    
    private var items: [UIAction] {
        let save = UIAction(title: "Save", image: UIImage(systemName: "plus")) { _ in }
        let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash")) { _ in }
        let Items = [save, delete]
        return Items
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setNavigationTitle(title: "Button context menu")
        
        view.addSubview(menuButton)
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            menuButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            menuButton.widthAnchor.constraint(equalToConstant: 100),
            menuButton.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
}

extension ButtonContextMenuViewController: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { [weak self] menuElements in
            let menu = UIMenu(title: "Menu", children: self?.items ?? [])
            return menu
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ButtonContextMenuViewController_Preview: PreviewProvider {
    static var previews: some View {
        ButtonContextMenuViewController().toPreview()
    }
}
#endif
