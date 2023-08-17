//
//  ButtonPullDownViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/08/10.
//

import UIKit

class ButtonPullDownViewController: UIViewController {
    
    // MARK: - PullDown single selection
    private lazy var singleMenu: UIMenu = {
        let items: [UIAction] = [
            UIAction(title: "first", image: UIImage(systemName: "pencil.circle"), attributes: [], state: .off, handler: didSignleMenuSelectAction),
            UIAction(title: "second", image: UIImage(systemName: "pencil.circle"), attributes: [.destructive], state: .on) { _ in },
            UIAction(title: "third", image: UIImage(systemName: "pencil.circle"), attributes: [], state: .off) { _ in },
            UIAction(title: "fourth", image: UIImage(systemName: "pencil.circle"), attributes: [.disabled], state: .off) { _ in },
        ]
        
        let menu = UIMenu(title: "Title", subtitle: "subtitle", image: nil, identifier: nil, options: .singleSelection, children: items)
        
        return menu
    }()
    
    private lazy var singleMenuButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Single Button", for: .normal)
        button.backgroundColor = .systemBlue
        
        button.layer.cornerRadius = 12
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOpacity = 1.0
        button.layer.shadowOffset = CGSize.zero
        button.layer.shadowRadius = 6
        
        button.showsMenuAsPrimaryAction = true
        button.changesSelectionAsPrimaryAction = false
        button.menu = singleMenu
        return button
    }()
    
    // MARK: - PullDown menu
    private let defaultMenuHandler = { (action: UIAction) in }
    
    private lazy var mainMenuButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Menu Button", for: .normal)
        button.backgroundColor = .systemBlue
        
        button.layer.cornerRadius = 12
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOpacity = 1.0
        button.layer.shadowOffset = CGSize.zero
        button.layer.shadowRadius = 6
        
        button.showsMenuAsPrimaryAction = true
        button.changesSelectionAsPrimaryAction = false
        button.menu = mainMenu
        return button
    }()
    
    // main menu cannot use subtitle, image and options
    private lazy var mainMenu = UIMenu(title: "Main", children: [defaultMenu, permissionMenu])
    
    private lazy var defaultMenu: UIMenu = {
        let items: [UIAction] = [
            UIAction(title: "Add", image: UIImage(systemName: "plus.circle"), state: .off, handler: defaultMenuHandler),
            UIAction(title: "Delete", image: UIImage(systemName: "minus.circle"), attributes: [.destructive], state: .off) { _ in },
            UIAction(title: "Save", subtitle: "store in document", image: UIImage(systemName: "arrow.down.circle"), attributes: [.disabled], state: .off) { _ in },
            UIAction(title: "Load", subtitle: "load from document", attributes: [.hidden], state: .off) { _ in },
        ]
        
        let menu = UIMenu(title: "Default", options: .displayInline, children: items)
        
        return menu
    }()
    
    private lazy var permissionMenu: UIMenu = {
        let items: [UIAction] = [
            UIAction(title: "Camera", image: UIImage(systemName: "camera"), attributes: [], state: .off) { _ in },
            UIAction(title: "Photo", image: UIImage(systemName: "photo.on.rectangle.angled"), attributes: [], state: .off) { _ in },
        ]
        
        let menu = UIMenu(title: "Permission", options: .singleSelection,  children: items)
        
        return menu
    }()
    
    private lazy var deferredMenu = UIDeferredMenuElement { (menuElements) in
        let items: [UIAction] = [
            UIAction(title: "fifth", image: UIImage(systemName: "pencil.circle"), attributes: [], state: .off) { _ in },
            UIAction(title: "sixth", image: UIImage(systemName: "pencil.circle"), attributes: [], state: .off) { _ in },
        ]
        
        let menu = UIMenu(title: "Welcome", options: .displayInline,  children: items)
        menuElements([menu])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setNavigationTitle(title: "Button Pulldown")
        
        self.layoutSingleSelectionButton()
        self.layoutMenuButton()
    }
    
    private func layoutSingleSelectionButton() {
        view.addSubview(singleMenuButton)
        singleMenuButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            singleMenuButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            singleMenuButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            singleMenuButton.widthAnchor.constraint(equalToConstant: 200),
            singleMenuButton.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
    
    private func layoutMenuButton() {
        view.addSubview(mainMenuButton)
        mainMenuButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainMenuButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainMenuButton.topAnchor.constraint(equalTo: singleMenuButton.bottomAnchor, constant: 12),
            mainMenuButton.widthAnchor.constraint(equalToConstant: 200),
            mainMenuButton.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
    
    func didSignleMenuSelectAction(_ action: UIAction) {
        var items = self.singleMenu.children
        items.append(deferredMenu)
        self.singleMenu = self.singleMenu.replacingChildren(items)
        self.singleMenuButton.menu = self.singleMenu
    }
    
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ButtonPullDownViewController_Preview: PreviewProvider {
    static var previews: some View {
        ButtonPullDownViewController().toPreview()
    }
}
#endif
