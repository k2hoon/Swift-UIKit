//
//  BasicCollectionView.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/06/11.
//

import UIKit

class BasicCollectionView: UIViewController {
    static let identifier = "BasicCollectionView"
    
    enum ViewType: Int, CaseIterable {
        case text
        case textScroll
        case button
        case vstack
        case hstack
        
        var viewValue: (title: String, vc: UIViewController) {
            switch self {
            case .text: return ("Text", TextViewController())
            case .textScroll: return ("Text scroll", TextScrollViewController())
            case .button: return ("Button test", ButtonViewController())
            case .vstack: return ("VStack", VStackViewController())
            case .hstack: return ("HStack", HStackViewController())
            }
        }
    }
    
    private let dataSource: [ViewType] = ViewType.allCases
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collection.delegate = self
        collection.dataSource = self
        // Register cell classes
        collection.register(BasicCollectionViewCell.self, forCellWithReuseIdentifier: BasicCollectionViewCell.identifier)
        return collection
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationTitle()
    }
    
    private func setNavigationTitle() {
        self.title = "BasicCollectionView"
        self.navigationController?.navigationBar.prefersLargeTitles = true // defulat is false
    }
}

extension BasicCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 8.0, bottom: 1.0, right: 8.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let width = (collectionView.frame.width / 3) - layout.minimumInteritemSpacing
        return CGSize(width: width, height: width);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasicCollectionViewCell.identifier, for: indexPath) as! BasicCollectionViewCell
        
        let viewValue = self.dataSource[indexPath.item].viewValue
        cell.setLabel(text: viewValue.title)
        cell.button.addAction { [weak self] in
            self?.navigationController?.pushViewController(viewValue.vc, animated: true)
        }
        return cell
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct BasicCollectionView_Preview: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BasicCollectionView().toPreview()
        }
    }
}
#endif
