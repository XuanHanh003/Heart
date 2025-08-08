//
//  UserList.swift
//  Xuan_Hanh
//
//  Created by ikame on 7/28/25.
//

import UIKit

class UserListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var addButton: UIButton?
        var users: [User] = []
    
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            users = UserStorage.shared.users 
            tableView.reloadData()
      }
    
        override func viewDidLoad() {
            super.viewDidLoad()
           
            setupTableView()
            setupNavigationBar()
        }
    
        func setupNavigationBar() {
            self.title = "List"
            self.navigationItem.hidesBackButton = true
            
            let backImage = UIImage(named: "Back")
            self.navigationController?.navigationBar.backIndicatorImage = backImage
            self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
            self.navigationItem.backButtonTitle = ""
            
            let addButton = UIButton(type: .system)
            addButton.setImage(UIImage(named: "ic_add"), for: .normal)
            addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
            addButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
            
            let barButton = UIBarButtonItem(customView: addButton)
            navigationItem.rightBarButtonItem = barButton

            self.addButton = addButton


    }
        @objc func addTapped() {
            let inforVC = InformationVC(nibName: "InformationVC", bundle: nil)
            inforVC.modalPresentationStyle = .fullScreen
            present(inforVC, animated: true)
        }

    

        private func setupTableView() {
            let nib = UINib(nibName: "UserCellVC", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "UserCellVC")
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tableFooterView = UIView()
            tableView.backgroundColor = UIColor(named: "Background")
            tableView.separatorStyle = .none
        }
    }

  
    extension UserListVC: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return UserStorage.shared.users.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCellVC", for: indexPath) as? UserCellVC else {
                return UITableViewCell()
            }
            let user = users[indexPath.row]
            cell.configure(with: user)
            return cell as UITableViewCell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let profileVC = ProfileVC(nibName: "ProfileVC", bundle: nil)
            let user = UserStorage.shared.users[indexPath.row]
            profileVC.user = user
            profileVC.onDelete = { [weak self] in
                    self?.users.remove(at: indexPath.row)
                    self?.tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            self.navigationController?.pushViewController(profileVC, animated: true)
        }


    }


