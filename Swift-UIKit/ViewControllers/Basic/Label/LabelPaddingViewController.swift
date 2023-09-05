//
//  LabelPaddingViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/08/10.
//

import UIKit

class PaddingLabel: UILabel {
    var padding = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
    
    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
        
    }
    
    override var intrinsicContentSize: CGSize {
        var intrinsicSize = super.intrinsicContentSize
        intrinsicSize.height += padding.top + padding.bottom
        intrinsicSize.width += padding.left + padding.right
        
        return intrinsicSize
    }
}

class LabelPaddingViewController: UIViewController {
    lazy var label: PaddingLabel = {
        let label = PaddingLabel()
        label.text = "Padding"
        label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(label)
        label.padding = .init(top: 20, left: 20, bottom: 20, right: 20)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct UILabelViewController_Preview: PreviewProvider {
    static var previews: some View {
        LabelPaddingViewController().toPreview()
    }
}
#endif
