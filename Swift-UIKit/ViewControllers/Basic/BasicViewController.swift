//
//  BasicViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/05/01.
//

import UIKit

class BasicViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let collection = UINavigationController(rootViewController: BasicCollectionView())
        collection.view.frame = self.view.bounds // set frame
        self.addChild(collection)
        self.view.addSubview(collection.view)
        self.view.addConstraints(collection.view.constraints)
        collection.didMove(toParent: self)
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct BasicViewController_Preview: PreviewProvider {
    static var previews: some View {
        BasicViewController().toPreview()
    }
}
#endif
