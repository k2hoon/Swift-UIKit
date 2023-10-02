//
//  NSAttributedTextViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/10/03.
//

import UIKit

class NSAttributedTextViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    // labels
    private let originLabel = UILabel()
    private let textLabel = UILabel()
    private let replaceLabel = UILabel()
    private let regrexLabel = UILabel()
    
    private let attributes: [NSAttributedString.Key : Any] = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.lineSpacing = 8
        
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.red
        shadow.shadowBlurRadius = 5
        
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .bold),
            .foregroundColor: UIColor.systemBlue,
            .backgroundColor: UIColor.systemGray4,
            .paragraphStyle: paragraphStyle,
            .underlineStyle: NSNumber(value: 1),
            .underlineColor: UIColor.black,
            .shadow: shadow,
        ]
        return attributes
    }()
    
    private let sampleText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.layoutView()
        self.setContent()
    }
    
    func layoutView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
            make.height.equalTo(80)
        }
        
        // add content view
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
    }
    
    func setContent() {
        // origin label
        contentView.addSubview(originLabel)
        originLabel.numberOfLines = 0
        originLabel.attributedText = self.sampleText.toAttributed()
        originLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(24)
            make.leading.trailing.equalTo(contentView).inset(16)
        }
        
        // text label
        contentView.addSubview(textLabel)
        textLabel.numberOfLines = 0
        textLabel.attributedText = self.sampleText.toAttributed().addAttributes(attributes)
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(originLabel.snp.bottom).offset(16)
            make.leading.trailing.equalTo(contentView).inset(16)
        }
        
        // replace label
        contentView.addSubview(replaceLabel)
        replaceLabel.numberOfLines = 0
        replaceLabel.attributedText = self.sampleText.toAttributed()
            .replaceAttribute("Lorem Ipsum", key: .font, value: UIFont.preferredFont(forTextStyle: .headline))
        
        replaceLabel.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(16)
            make.leading.trailing.equalTo(contentView).inset(16)
        }
        
        // regrex label
        contentView.addSubview(regrexLabel)
        regrexLabel.attributedText = "(?:^|\\s|$|[.])@[\\p{L}0-9_]*\n hashtag Regular Expression.\n @hashtag"
            .toAttributed()
            .regrexAttribute(using: "(?:^|\\s|$|[.])@[\\p{L}0-9_]*", key: .foregroundColor, value: UIColor.systemBlue)
        regrexLabel.numberOfLines = 0
        regrexLabel.snp.makeConstraints { make in
            make.top.equalTo(replaceLabel.snp.bottom).offset(20)
            make.left.right.equalTo(contentView).inset(20)
            make.bottom.equalTo(contentView)
        }
    }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct NSAttributedTextViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            NSAttributedTextViewController()
        }
    }
}
#endif
