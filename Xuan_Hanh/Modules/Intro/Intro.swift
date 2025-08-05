//
//  Intro.swift
//  Xuan_Hanh
//
//  Created by ikame on 7/21/25.
//

import UIKit

class Intro: UIViewController, ButtonDelegate {
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var addProfileButton: Button!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        addProfileButton.setTitle("Add Profile")
        addProfileButton.delegate = self
        
        let fullText = "Empty folder, Tap “Add Profile” button to create profile now"
        let keyword = "“Add Profile”"
        highlight(keyword, in: fullText, label: messageLabel, highlightColor: .primary1)
    }
    
    func setupNavigationBar() {
        self.title = "List"
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 20, weight: .bold),
            .foregroundColor: UIColor.neutral1]
        
        let backImage = UIImage(named: "Back")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationItem.backButtonTitle = ""
    }
    
    func highlight(_ keyword: String, in fullText: String, label: UILabel, highlightColor: UIColor) {
        let attributed = NSMutableAttributedString(string: fullText)
        if let range = fullText.range(of: keyword) {
            attributed.addAttribute(.foregroundColor, value: highlightColor, range: NSRange(range, in: fullText))
        }
        label.attributedText = attributed
    }
    
    func buttonTapped() {
        let InforVC = Information(nibName: "Information", bundle: nil)
        navigationController?.pushViewController(InforVC, animated: true)
    }
    
}

  

