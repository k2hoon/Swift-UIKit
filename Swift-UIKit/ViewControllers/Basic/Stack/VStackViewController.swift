//
//  VStackViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/07/14.
//

import UIKit

class VStackViewController: UIViewController {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 20
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var leftView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    lazy var centerView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    lazy var rightView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.leftView)
        self.stackView.addArrangedSubview(self.centerView)
        self.stackView.addArrangedSubview(self.rightView)
        
        NSLayoutConstraint.activate([
            self.stackView.heightAnchor.constraint(equalToConstant: 300),
            self.stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.stackView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.stackView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct VStackViewController_Preview: PreviewProvider {
    static var previews: some View {
        VStackViewController().toPreview()
    }
}
#endif
