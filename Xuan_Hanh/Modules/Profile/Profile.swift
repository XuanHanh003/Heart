//
//  Profile.swift
//  Xuan_Hanh
//
//  Created by ikame on 7/28/25.
//

import UIKit

class Profile: UIViewController, ButtonDelegate {
    
    @IBOutlet weak var resulView: UIStackView!
    @IBOutlet weak var editButton: Button!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        editButton.setTitle("Edit")
        editButton.delegate = self
        resulView.layer.cornerRadius = 16
        
        let deleteImage = UIImage(named: "Delete")
        let deleteButton = UIBarButtonItem(
            image: deleteImage,
            style: .plain,
            target: self,
            action: #selector(deleteTapped)
        )
        navigationItem.rightBarButtonItem = deleteButton
    }
    func setupNavigationBar() {
        self.title = "Profile"
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 20, weight: .bold),
            .foregroundColor: UIColor.neutral1]
    }
    @objc func deleteTapped() {
        navigationItem.rightBarButtonItem?.isEnabled = false
        showAlert()
    }
    func showAlert() {
        let alertView = Alert()
        
        
        alertView.frame = view.bounds
        alertView.backgroundColor = UIColor.black.withAlphaComponent(0.5) // làm mờ background
        alertView.tag = 999
        
        // Gán action
        alertView.cancelButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        alertView.yesButton.addTarget(self, action: #selector(confirmDelete), for: .touchUpInside)
        
        view.addSubview(alertView)
    }
    @objc func dismissAlert() {
        navigationItem.rightBarButtonItem?.isEnabled = true
        if let alertView = view.viewWithTag(999) {
            alertView.removeFromSuperview()
        }
    }
    
    @objc func confirmDelete() {
        dismissAlert()
        
        // Chuyển về Intro
        let introVC = Intro(nibName: "Intro", bundle: nil)
        navigationController?.setViewControllers([introVC], animated: true)
    }
    func buttonTapped() {
        let InforVC = Information(nibName: "Information", bundle: nil)
        navigationController?.pushViewController(InforVC, animated: true)
        
    }
    
}
    
