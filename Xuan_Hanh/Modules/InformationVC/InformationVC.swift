//
//  Information.swift
//  Xuan_Hanh
//
//  Created by ikame on 7/21/25.
//

import UIKit

struct User {
    let firstName: String
    let lastName: String
    let gender: String
    let height: Int
    let weight: Int
}

class InformationVC: UIViewController {
    
    @IBOutlet weak var formFirstName: InputVC!
    @IBOutlet weak var formLastName: InputVC!
    @IBOutlet weak var formWeight: InputVC!
    @IBOutlet weak var formHeight: InputVC!
    @IBOutlet weak var saveButton: PrimaryButtonView!
    @IBOutlet weak var formGender: UISegmentedControl!
    
    var isEditMode = false
    var editingIndex: Int?
    var user: User?
    
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
        let lastName = formLastName.textField.text ?? ""
        
        let selectedIndex = formGender.selectedSegmentIndex
        let gender = formGender.titleForSegment(at: selectedIndex) ?? "Unknown"
        
        let height = Int(formHeight.textField.text ?? "0") ?? 0
        let weight = Int(formWeight.textField.text ?? "0") ?? 0
        
        let newUser = User(firstName: firstName, lastName: lastName, gender: gender, height: height, weight: weight)
        
        if isEditMode, let index = editingIndex {
            // UPDATE user cũ
            UserStorage.shared.users[index] = newUser
            
            // Quay lại list cũ: nếu có trong nav stack → pop, nếu đang present → dismiss
            if let listVC = navigationController?.viewControllers.first(where: { $0 is UserListVC }) {
                navigationController?.popToViewController(listVC, animated: true)
            } else {
                dismiss(animated: true)
            }
        } else {
            // CREATE user mới
            UserStorage.shared.users.append(newUser)
            
            // Nếu màn này được mở bằng present từ UserList → dismiss để quay lại list (list sẽ reload ở viewWillAppear)
            // Nếu mở lần đầu bằng push từ Intro → push sang UserList
            if presentingViewController != nil || navigationController?.presentingViewController != nil {
                dismiss(animated: true)
            } else {
                let userListVC = UserListVC(nibName: "UserListVC", bundle: nil)
                navigationController?.pushViewController(userListVC, animated: true)
            }
        }
    }
}

