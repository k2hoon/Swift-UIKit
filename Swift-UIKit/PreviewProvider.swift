//
//  PreviewProvider.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/06/17.
//

import Foundation

#if canImport(SwiftUI) && DEBUG
import SwiftUI

extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
    
    func toPreview() -> some View {
        Preview(viewController: self)
    }
}
#endif
