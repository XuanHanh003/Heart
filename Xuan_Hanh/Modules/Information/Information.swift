//
//  Information.swift
//  Xuan_Hanh
//
//  Created by ikame on 7/21/25.
//

import UIKit

class Information: UIViewController, ButtonDelegate {
    
    @IBOutlet weak var formFirstName: Input!
    @IBOutlet weak var formLastName: Input!
    @IBOutlet weak var formWeight: Input!
    @IBOutlet weak var formHeight: Input!
    @IBOutlet weak var saveButton: Button!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        saveButton.delegate = self
        informationForm()
        
       
        
    }
    func setupNavigationBar() {
        self.title = "Information"
        navigationController?.navigationBar.titleTextAttributes = [
                .font: UIFont.systemFont(ofSize: 20, weight: .bold),
                .foregroundColor: UIColor.neutral1]
    }
    func informationForm() {
        formFirstName.title.text = "First Name"
        formLastName.title.text = "Last Name"
        formWeight.title.text = "Weight"
        formHeight.title.text = "Height"
        formFirstName.textField.placeholder = "Enter your first name"
        formLastName.textField.placeholder = "Enter your last name"
        formWeight.textField.placeholder = "Kg"
        formHeight.textField.placeholder = "Cm"
        saveButton.setTitle("Save")
        
    }

    func buttonTapped() {
            let listVC = UserList(nibName: "UserList", bundle: nil)
            navigationController?.pushViewController(listVC, animated: true)
        }

}
