//
//  UserList.swift
//  Xuan_Hanh
//
//  Created by ikame on 7/28/25.
//

import UIKit

struct User {
    let name: String
    let status: String
}

class UserList: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    // Dữ liệu mẫu
        let users = [
            User(name: "John Weak", status: "W: 86kg - H: 190cm"),
            User(name: "John Unowned", status: "W: 86kg - H: 190cm"),
            User(name: "John Strong", status: "W: 86kg - H: 190cm")
        ]

        override func viewDidLoad() {
            super.viewDidLoad()
            self.title = "List"
            setupTableView()
            setupNavigationBar()
        }
    
        func setupNavigationBar() {
            self.navigationItem.hidesBackButton = true
            
            // Sửa icon back của màn kế tiếp (Information)
            let backImage = UIImage(named: "Back")
            self.navigationController?.navigationBar.backIndicatorImage = backImage
            self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage

            // Ẩn chữ "Back" nếu muốn
            self.navigationItem.backButtonTitle = ""

    }

        private func setupTableView() {
            let nib = UINib(nibName: "UserCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "UserCell")
            tableView.delegate = self
            tableView.dataSource = self
//            tableView.rowHeight = 80
            tableView.tableFooterView = UIView()
            tableView.backgroundColor = UIColor(named: "Background")
            tableView.separatorStyle = .none
        }
    }

  
    extension UserList: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return users.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell else {
                return UITableViewCell()
            }
            let user = users[indexPath.row]
            cell.configure(with: user)
            return cell as UITableViewCell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let profileVC = Profile(nibName: "Profile", bundle: nil)
            self.navigationController?.pushViewController(profileVC, animated: true)
        }


    }


