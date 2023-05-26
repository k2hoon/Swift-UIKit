//
//  AdvancedViewController.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/05/22.
//

import UIKit

class AdvancedViewController: UIViewController {
    @IBOutlet weak var verticalStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStackView()
        // Do any additional setup after loading the view.
    }
    
    private func configureStackView() {
        for _ in 0..<10 {
            let dummyView = randomColoredView()
            self.verticalStackView.addArrangedSubview(dummyView)
        }
    }
    
    private func randomColoredView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 1.0, green: .random(in: 0...1), blue: .random(in: 0...1), alpha: .random(in: 0...1))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: .random(in: 100...400)).isActive = true
        return view
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
