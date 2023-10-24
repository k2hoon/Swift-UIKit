//
//  ImageResizeViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/10/24.
//

import UIKit

class DownSampleOptionView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "DownSample Option"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let widthLabel: UILabel = {
        let label = UILabel()
        label.text = "Width:"
        return label
    }()
    
    private let heightLabel: UILabel = {
        let label = UILabel()
        label.text = "Height:"
        return label
    }()
    
    private(set) lazy var widthField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .never
        return textField
    }()
    
    
    private(set) lazy var heightField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .never
        return textField
    }()
    
    let button: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.title = "Confirm"
        button.configuration = config
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.layoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutView() {
        [titleLabel, widthLabel, widthField, heightLabel, heightField, button].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            
            widthLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            widthLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            
            widthField.leadingAnchor.constraint(equalTo: widthLabel.trailingAnchor, constant: 8),
            widthField.centerYAnchor.constraint(equalTo: widthLabel.centerYAnchor),
            widthField.widthAnchor.constraint(equalToConstant: 80),
            
            heightLabel.leadingAnchor.constraint(equalTo: widthField.trailingAnchor, constant: 8),
            heightLabel.centerYAnchor.constraint(equalTo: widthLabel.centerYAnchor),
            
            heightField.leadingAnchor.constraint(equalTo: heightLabel.trailingAnchor, constant: 8),
            heightField.centerYAnchor.constraint(equalTo: widthLabel.centerYAnchor),
            heightField.widthAnchor.constraint(equalToConstant: 80),
            
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            button.centerYAnchor.constraint(equalTo: widthLabel.centerYAnchor),
        ])
    }
}

class ScaleOptionView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Scale Option"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let widthLabel: UILabel = {
        let label = UILabel()
        label.text = "Width:"
        return label
    }()
    
    private(set) lazy var widthField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .never
        return textField
    }()
    
    let button: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.title = "Confirm"
        button.configuration = config
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.layoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutView() {
        [titleLabel, widthLabel, widthField, button].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            
            widthLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            widthLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            
            widthField.leadingAnchor.constraint(equalTo: widthLabel.trailingAnchor, constant: 8),
            widthField.centerYAnchor.constraint(equalTo: widthLabel.centerYAnchor),
            widthField.widthAnchor.constraint(equalToConstant: 80),
            
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            button.centerYAnchor.constraint(equalTo: widthLabel.centerYAnchor),
        ])
    }
}

class ImageResizeViewController: UIViewController {
    private let imageResizer = ImageResizer()
    private let downSampleView = DownSampleOptionView()
    private let scaleView = ScaleOptionView()
    private let imageView = UIImageView()
    
    private let dimensionLabel: UILabel = {
        let label = UILabel()
        label.text = "dimension value"
        return label
    }()
    
    private let originLabel: UILabel = {
        let label = UILabel()
        label.text = "Init value"
        return label
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "No results"
        return label
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.layoutView()
    }
}

extension ImageResizeViewController {
    private func layoutView() {
        [downSampleView, scaleView, dimensionLabel, originLabel, resultLabel, imageView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            downSampleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            downSampleView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            downSampleView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            downSampleView.heightAnchor.constraint(equalToConstant: 100),
            
            scaleView.topAnchor.constraint(equalTo: downSampleView.bottomAnchor, constant: 16),
            scaleView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scaleView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scaleView.heightAnchor.constraint(equalToConstant: 100),
            
            dimensionLabel.topAnchor.constraint(equalTo: scaleView.bottomAnchor, constant: 8),
            dimensionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            
            originLabel.topAnchor.constraint(equalTo: dimensionLabel.bottomAnchor, constant: 8),
            originLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            
            resultLabel.topAnchor.constraint(equalTo: originLabel.bottomAnchor, constant: 8),
            resultLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            resultLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            imageView.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 8),
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
        
        scaleView.button.addAction { [unowned self] in
            self.setScaleImage()
        }
        
        downSampleView.button.addAction { [unowned self] in
            self.setDownsample()
        }
    }
    
    private func setScaleImage() {
        let width = Double(self.scaleView.widthField.text ?? "") ?? 0
        imageView.image = self.getImage()?.scale(newWidth: CGFloat(width))
        imageView.layer.borderColor = UIColor.red.cgColor
        imageView.layer.borderWidth = 1.0
        self.resultLabel.text = String(format: "result: %d", imageView.image?.pngData()?.bytes ?? 0)
    }
    
    private func setDownsample() {
        let width = Double(self.downSampleView.widthField.text ?? "") ?? 0
        let height = Double(self.downSampleView.heightField.text ?? "") ?? 0
        
        DispatchQueue.global().async { [weak self] in
            let downsampled = self?.imageResizer.downSample(
                data: self?.getImage()?.pngData(),
                size: CGSize(width: width, height: height)
            )
            DispatchQueue.main.async {
                self?.imageView.image = downsampled
                self?.resultLabel.text = String(downsampled?.pngData()?.bytes ?? 0)
            }
        }
    }
    
    private func getImage() -> UIImage? {
        guard let url = Bundle.main.url(forResource: "UIImage_10", withExtension: "png"),
              let data = try? Data(contentsOf: url, options: .uncached) else {
            return nil
        }
        self.dimensionLabel.text = String(format: "dimenstion: %@", imageDimensions(url: url))
        self.originLabel.text = String(format: "Init value: %d", data.bytes)
        return UIImage(data: data)
    }
    
    private func imageDimensions(url: URL) -> String {
        guard let imageSource = CGImageSourceCreateWithURL(url as CFURL, nil),
              let imageProperties: [CFString : Any] = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as? Dictionary else {
            return "None"
        }
        let pixelWidth = imageProperties[kCGImagePropertyPixelWidth] as? Int ?? 0
        let pixelHeight = imageProperties[kCGImagePropertyPixelHeight] as? Int ?? 0
        
        return "Width: \(pixelWidth), Height: \(pixelHeight)"
    }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ImageResizeViewController_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview { ImageResizeViewController() }
    }
}

#endif
