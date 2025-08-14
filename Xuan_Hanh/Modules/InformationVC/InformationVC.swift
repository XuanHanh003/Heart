//
//  Information.swift
//  Xuan_Hanh
//
//  Created by ikame on 7/21/25.
//

import UIKit
import RealmSwift

class InformationVC: UIViewController {
    
    @IBOutlet weak var formFirstName: InputVC!
    @IBOutlet weak var formLastName: InputVC!
    @IBOutlet weak var formWeight: InputVC!
    @IBOutlet weak var formHeight: InputVC!
    @IBOutlet weak var saveButton: PrimaryButtonView!
    @IBOutlet weak var formGender: UISegmentedControl!
    
    var isEditMode = false
    var user: UserObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        saveButton.delegate = self
        informationForm()
        fillDataEdit()
        changeForm()
        validateForm()
        
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
        
        if !isEditMode {
            saveButton.setTitle("Save")
        }
        
        
    }
    
    private func changeForm() {
        formFirstName.textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        formLastName.textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        formWeight.textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        formHeight.textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        formGender.addTarget(self, action: #selector(textFieldChanged), for: .valueChanged)
    }
    
    @objc private func textFieldChanged() {
        validateForm()
    }
    
    private func validateForm() {
        let firstName = formFirstName.textField.text ?? ""
        let lastName = formLastName.textField.text ?? ""
        let weightText = formWeight.textField.text ?? ""
        let heightText = formHeight.textField.text ?? ""
        
        let isAllFilled = !firstName.isEmpty && !lastName.isEmpty && !weightText.isEmpty && !heightText.isEmpty
        
        if isEditMode {
            if let user = user {
                let gender = formGender.titleForSegment(at: formGender.selectedSegmentIndex) ?? "Unknown"
                let height = Int(heightText) ?? 0
                let weight = Int(weightText) ?? 0
                
                let isChanged = firstName != user.firstName ||
                lastName != user.lastName ||
                gender != user.gender ||
                height != user.height ||
                weight != user.weight
                
                saveButton.isEnabled = isAllFilled && isChanged
            }
        } else {
            saveButton.isEnabled = isAllFilled
        }
    }
    
    
    private func fillDataEdit() {
        if isEditMode, let user = user {
            formFirstName.textField.text = user.firstName
            formLastName.textField.text = user.lastName
            formWeight.textField.text = "\(user.weight)"
            formHeight.textField.text = "\(user.height)"
            formGender.selectedSegmentIndex = (user.gender == "Male" ? 0 : 1)
            saveButton.setTitle("Update")
        }
    }
    
    
    @objc func closeTapped() {
        dismiss(animated: true)
    }
}


extension InformationVC: ButtonDelegate {
    func buttonTapped() {
        let firstName = formFirstName.textField.text ?? ""
        let lastName  = formLastName.textField.text ?? ""
        let gender    = formGender.titleForSegment(at: formGender.selectedSegmentIndex) ?? "Unknown"
        let height    = Int(formHeight.textField.text ?? "0") ?? 0
        let weight    = Int(formWeight.textField.text ?? "0") ?? 0

        if isEditMode, let obj = user {
            // UPDATE object Realm hiện có
            DB.write { _ in
                obj.firstName = firstName
                obj.lastName  = lastName
                obj.gender    = gender
                obj.height    = height
                obj.weight    = weight
            }

            // Quay lại List: nếu đang trong nav stack → pop; nếu đang present → dismiss
            if let listVC = navigationController?.viewControllers.first(where: { $0 is UserListVC }) {
                navigationController?.popToViewController(listVC, animated: true)
            } else {
                dismiss(animated: true)
            }

        } else {
            // CREATE object mới trong Realm
            let obj = UserObject()
            obj.firstName = firstName
            obj.lastName  = lastName
            obj.gender    = gender
            obj.height    = height
            obj.weight    = weight
           

            DB.write { $0.add(obj) }

            // Nếu mở bằng present từ UserList → dismiss; nếu push lần đầu từ Intro → push sang List
            if presentingViewController != nil || navigationController?.presentingViewController != nil {
                dismiss(animated: true)
            } else {
                let list = UserListVC(nibName: "UserListVC", bundle: nil)
                navigationController?.pushViewController(list, animated: true)
            }
        }
    }
}
