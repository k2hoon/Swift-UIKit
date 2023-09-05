//
//  LabelViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/06/11.
//

import UIKit

class LabelViewController: UIViewController {
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello, World!"
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.red.cgColor
        label.textAlignment = .left
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(textLabel)
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200),
            textLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct TextViewController_Preview: PreviewProvider {
    static var previews: some View {
        LabelViewController().toPreview()
    }
}
#endif
