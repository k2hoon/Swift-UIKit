//
//  AttributedTextViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/10/02.
//

import UIKit
import SnapKit

class AttributedTextViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let originLabel = UILabel()
    private let textLabel = UILabel()
    
    private let sampleText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
    
    lazy var attributes: [NSAttributedString.Key : Any] = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.lineSpacing = 10
        
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.systemFont(ofSize: 20.0, weight: .semibold),
            .foregroundColor: UIColor.systemBlue,
            .paragraphStyle: paragraphStyle,
            .backgroundColor: UIColor.lightGray,
            .underlineStyle: NSNumber(value: 1),
        ]
        return attributes
    }()
    
    lazy var attributedString: AttributedString = {
        var attributed = AttributedString(sampleText)
        attributed.foregroundColor = .systemBlue
        attributed.backgroundColor = .systemGray4
        attributed.font = .boldSystemFont(ofSize: 16)
        
        return attributed
    }()
    
    var message: AttributedString {
        var result = Date.now.formatted(.dateTime.weekday(.wide).day().month(.wide).attributed)
        result.foregroundColor = .secondary
        
        let weekday = AttributeContainer.dateField(.weekday)
        let weekdayStyling = AttributeContainer.foregroundColor(.primary)
        result.replaceAttributes(weekday, with: weekdayStyling)
        
        return result
    }
    
    var message2: AttributedString {
        var components = PersonNameComponents()
        components.givenName = "Taylor"
        components.familyName = "Swift"
        
        var result = components.formatted(.name(style: .long).attributed)
        
        let familyNameStyling = AttributeContainer.font(.headline)
        let familyName = AttributeContainer.personNameComponent(.familyName)
        result.replaceAttributes(familyName, with: familyNameStyling)
        
        return result
    }
    
    var message3: AttributedString {
        let amount = Measurement(value: 200, unit: UnitLength.kilometers)
        var result = amount.formatted(.measurement(width: .wide).attributed)
        
        let distanceStyling = AttributeContainer.font(.title)
        let distance = AttributeContainer.measurement(.value)
        result.replaceAttributes(distance, with: distanceStyling)
        
        return result
    }
    
    var message4: AttributedString {
        let string = "The letters go up and down"
        var result = AttributedString()
        
        for (index, letter) in string.enumerated() {
            var letterString = AttributedString(String(letter))
            letterString.baselineOffset = sin(Double(index)) * 10
            result += letterString
        }
        
        result.font = .largeTitle
        return result
    }
    
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
        originLabel.attributedText = NSAttributedString(attributedString)
        originLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(24)
            make.leading.trailing.equalTo(contentView).inset(16)
        }
        
        // text label
        contentView.addSubview(textLabel)
        textLabel.numberOfLines = 0
        textLabel.attributedText = NSAttributedString(message)
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(originLabel.snp.bottom).offset(16)
            make.leading.trailing.equalTo(contentView).inset(16)
        }
    }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct AttributedTextViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            AttributedTextViewController()
        }
    }
}
#endif
