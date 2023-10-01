//
//  BasicCollectionViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/06/11.
//

import UIKit

class BasicCollectionViewController: UIViewController {
    enum ViewType: Int, CaseIterable {
        case label
        case textField
        case button
        case vstack
        case hstack
        case table
        case customTable
        case segment
        case picker
        case alert
        case stepper
        case slider
        case progress
        case search
        
        var viewValue: (title: String, vc: UIViewController) {
            switch self {
            case .label: return ("Label(Text)", LabelCollectionViewController())
            case .textField: return ("Text Field", TextFieldViewController())
            case .button: return ("Button", ButtonCollectionViewController())
            case .vstack: return ("VStack", VStackViewController())
            case .hstack: return ("HStack", HStackViewController())
            case .table: return ("Table", TableViewController())
            case .customTable: return ("Custom Table", CustomTableViewController())
            case .segment: return ("Segment", UISegmentViewController())
            case .picker: return ("Picker", PickerInputViewController())
            case .alert: return ("Alert", AlertViewController())
            case .stepper: return ("Stepper", StepperViewController())
            case .slider: return ("Slider", SliderViewController())
            case .progress: return ("Progress", ProgressViewController())
            case .search: return ("Search", SearchCollections())
            }
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collection.delegate = self
        collection.dataSource = self
        // Register cell classes
        collection.register(BasicCollectionViewCell.self, forCellWithReuseIdentifier: BasicCollectionViewCell.identifier)
        return collection
    }()
    
    private let dataSource: [ViewType] = ViewType.allCases
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Basic Collection"
        self.navigationController?.navigationBar.prefersLargeTitles = true // defulat is false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.layoutCollectionView()
    }
    
    private func layoutCollectionView() {
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}

extension BasicCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        
        let viewType = self.dataSource[indexPath.item]
        cell.setLabel(text: viewType.viewValue.title)
        cell.button.addAction { [weak self] in
            if viewType == .button || viewType == .label || viewType == .search {
                let vc = UINavigationController(rootViewController: viewType.viewValue.vc)
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc, animated: true)
            } else {
                self?.navigationController?.pushViewController(viewType.viewValue.vc, animated: true)
            }            
        }
        return cell
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct BasicCollectionViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            UINavigationController(rootViewController: BasicCollectionViewController())
        }
    }
}
#endif
