//
//  BasicCollectionView.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/06/11.
//

import UIKit

extension UIControl {
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping()->()) {
        addAction(UIAction { (action: UIAction) in closure() }, for: controlEvents)
    }
}

class BasicCollectionView: UIViewController {
    private let scrollView = UIScrollView()
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 20
        view.distribution = .fillEqually
        
        return view
    }()
    
    enum ViewType: Int, CaseIterable {
        case text
        case textScroll
        case button
        
        var viewValue: (title: String, vc: UIViewController) {
            switch self {
            case .text: return ("Text test", TextViewController())
            case .textScroll: return ("Text scroll test", TextScrollViewController())
            case .button: return ("Button test", ButtonViewController())
            }
        }
    }
    
    override func viewDidLoad() {
        self.view.addSubview(scrollView)
        
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        
        self.scrollView.addSubview(self.stackView)
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.stackView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor),
        ])
        
        ViewType.allCases.forEach { viewType in
            let viewValue = viewType.viewValue
            let button = UIButton()
            self.stackView.addArrangedSubview(button)
            
            // button custom
            button.setTitle(viewValue.title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .white
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.cornerRadius = 32
            button.layer.shadowColor = UIColor.gray.cgColor
            button.layer.shadowOpacity = 1.0
            button.layer.shadowOffset = .init(width: 10, height: 10)
            button.layer.shadowRadius = 6
            button.layer.masksToBounds = false
            
            // button action
            button.addAction {
                let presentVC = viewValue.vc
                self.navigationController?.pushViewController(presentVC, animated: true)
            }
            
            // button layout
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 300),
                button.heightAnchor.constraint(equalToConstant: 400),
            ])
        }
    }
}
