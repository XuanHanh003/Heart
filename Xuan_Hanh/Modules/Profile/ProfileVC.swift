//
//  Profile.swift
//  Xuan_Hanh
//
//  Created by ikame on 7/28/25.
//

import UIKit
import RealmSwift

class ProfileVC: UIViewController {
    
    @IBOutlet weak var resulView: UIStackView!
    @IBOutlet weak var editButton: PrimaryButtonView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    private var deleteButton: UIButton?
    
    var user: UserObject!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        editButton.setTitle("Edit")
        editButton.delegate = self
        resulView.layer.cornerRadius = 16
        
        if let user = user {
            nameLabel.text = "\(user.firstName) \(user.lastName)"
            
            let heightInMeters = Double(user.height) / 100.0
            let bmi = Double(user.weight) / (heightInMeters * heightInMeters)
            bmiLabel.text = String(format: "%.1f", bmi)
            
            heightLabel.text = "\(user.height) cm"
            weightLabel.text = "\(user.weight) kg"
            genderLabel.text = user.gender
         }
    }
    
    func setupNavigationBar() {
        self.title = "Profile"
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 20, weight: .bold),
            .foregroundColor: UIColor.neutral1]
        self.navigationItem.backButtonTitle = ""
        
        let deleteButton = UIButton(type: .system)
        deleteButton.setImage(UIImage(named: "Delete"), for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        deleteButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24) 

        let barButton = UIBarButtonItem(customView: deleteButton)
        navigationItem.rightBarButtonItem = barButton

        self.deleteButton = deleteButton
    }
    
    
    @objc func deleteTapped() {
        navigationItem.rightBarButtonItem?.isEnabled = false
        showAlert()
    }
    
    
    func showAlert() {
        let alertView = AlertVC()
        
        deleteButton?.isEnabled = false
        deleteButton?.alpha = 0.3

        alertView.frame = view.bounds
        alertView.backgroundColor = UIColor.black.withAlphaComponent(0.5) 
        alertView.tag = 999
        
        alertView.cancelButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        alertView.yesButton.addTarget(self, action: #selector(confirmDelete), for: .touchUpInside)
        
        view.addSubview(alertView)
    }
    
    
    @objc func dismissAlert() {
        deleteButton?.isEnabled = true
        deleteButton?.alpha = 1.0
        if let alertView = view.viewWithTag(999) {
            alertView.removeFromSuperview()
        }
    }
    
    
    @objc func confirmDelete() {
        dismissAlert()
        
        guard let u = self.user else { return }

                // Xoá object khỏi Realm
                DB.write { r in
                    if !u.isInvalidated { r.delete(u) }
                }

                navigationController?.popViewController(animated: true)
            }
        }



extension ProfileVC: ButtonDelegate {
    func buttonTapped() {
        
         let InforVC = InformationVC(nibName: "InformationVC", bundle: nil)
            
            InforVC.user = self.user
            InforVC.isEditMode = true
            
            navigationController?.pushViewController(InforVC, animated: true)
        }
    }
    

