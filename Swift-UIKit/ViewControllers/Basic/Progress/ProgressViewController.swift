//
//  ProgressViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/09/21.
//

import UIKit

class ProgressViewController: UIViewController {
    private var progressValue: Float = 0.1
    private var timer: Timer?
    
    lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.trackTintColor = .lightGray
        view.progressTintColor = .systemBlue
        return view
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.title = "Start"
        button.configuration = config
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.layoutViews()
        self.setTargetActions()
    }
}

// MARK: ProgressViewController
extension ProgressViewController {
    private func layoutViews() {
        [progressView, startButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            // progressView button
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            progressView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // start button
            startButton.bottomAnchor.constraint(equalTo: progressView.topAnchor, constant: -24),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setTargetActions() {
        startButton.addAction { [unowned self] in
            progressView.progress = progressValue
            timer = Timer.scheduledTimer(
                timeInterval: 0.05,
                target: self,
                selector: #selector(setProgress),
                userInfo: nil,
                repeats: true
            )
        }
    }
    
    @objc func setProgress() {
        progressValue += 0.05
        progressView.setProgress(progressValue, animated: true)
        if progressValue >= 1.0 {
            timer?.invalidate()
            timer = nil
            progressValue = 0.1
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ProgressViewController_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            ProgressViewController()
        }
    }
}
#endif
