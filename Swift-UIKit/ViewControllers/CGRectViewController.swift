//
//  CGRectViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/06/17.
//

import UIKit

class CGRectViewController: UIViewController {
    func getVetricalTextView() -> UIStackView {
        let frame = UILabel()
        frame.text = "label"
        frame.sizeToFit()
        
        let bound = UILabel()
        bound.text = "label"
        bound.sizeToFit()
        
        let vStack = UIStackView()
        vStack.addArrangedSubview(frame)
        vStack.addArrangedSubview(bound)
        
        vStack.axis = .vertical
        vStack.distribution = .fillEqually
        vStack.alignment = .fill
        
        return vStack
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
                
        let rectView = self.addRectanbleView(stack: getVetricalTextView(),
                                             size: .init(width: 300, height: 300),
                                             topPadding: 0)
        
        self.addCircleView(stack: getVetricalTextView(), size: .init(width: 100, height: 100), topPadding: rectView.height)
    }
    
    private func addRectanbleView(stack: UIStackView, size: CGSize, topPadding: CGFloat) -> CGRect {
        let uiview = UIView()
                
        // add stack view
        uiview.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leftAnchor.constraint(equalTo: uiview.leftAnchor),
            stack.rightAnchor.constraint(equalTo: uiview.rightAnchor),
        ])

        // add rectangle
        let rectangle = UIView()
        let stackHeight = self.getStackHeight(stack: stack)
        rectangle.frame.size = size
        rectangle.frame.origin = CGPoint(x: UIScreen.centerX - 150, y: floor(stackHeight))
        rectangle.backgroundColor = .green
        uiview.addSubview(rectangle)
        
        // add view to root
        self.view.addSubview(uiview)
        uiview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            uiview.topAnchor.constraint(equalTo: view.topAnchor, constant: topPadding),
            uiview.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            uiview.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
        
        // set frame and bound
        (stack.arrangedSubviews[0] as? UILabel)?.text = "frame: \(rectangle.frame)"
        (stack.arrangedSubviews[1] as? UILabel)?.text = "bound: \(rectangle.bounds)"
        
        return CGRect(
            x: 0,
            y: 0,
            width: UIScreen.width,
            height: stackHeight + size.height)
    }
    
    private func addCircleView(stack: UIStackView, size: CGSize, topPadding: CGFloat) {
        let uiview = UIView()
        // add stack view
        uiview.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leftAnchor.constraint(equalTo: uiview.leftAnchor),
            stack.rightAnchor.constraint(equalTo: uiview.rightAnchor),
        ])
        
        // add circle
        let circle = UIView()
        let stackHeight = self.getStackHeight(stack: stack)
        circle.frame.size = size
        circle.frame.origin = CGPoint(x: UIScreen.centerX - (size.width * 0.5),
                                      y: floor(stackHeight))
        circle.backgroundColor = .red
        circle.layer.cornerRadius = circle.layer.bounds.width / 2
        circle.clipsToBounds = true
        uiview.addSubview(circle)
        
        // add view to root
        self.view.addSubview(uiview)
        uiview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            uiview.topAnchor.constraint(equalTo: view.topAnchor, constant: topPadding),
            uiview.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            uiview.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
        
        // set frame and bound
        (stack.arrangedSubviews[0] as? UILabel)?.text = "frame: \(circle.frame)"
        (stack.arrangedSubviews[1] as? UILabel)?.text = "bound: \(circle.bounds)"
    }
    
    private func getStackHeight(stack: UIStackView) -> CGFloat {
        var stackHeight: CGFloat = 0
        stack.arrangedSubviews.forEach { view in stackHeight += view.frame.height }
        
        return stackHeight
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct CGRectViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            CGRectViewController()
        }
    }
}
#endif
