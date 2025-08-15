//
//  UserList.swift
//  Xuan_Hanh
//
//  Created by ikame on 7/28/25.
//

import UIKit
import RealmSwift

class UserListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var users: Results<UserObject>!
    private var token: NotificationToken?
    
    private var addButton: UIButton?
      
    
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
      }
    
        override func viewDidLoad() {
            super.viewDidLoad()
           
            setupTableView()
            setupNavigationBar()
            
            users = DB.realm.objects(UserObject.self)
            token = users.observe { [weak self] changes in
                guard let table = self?.tableView else { return }
                switch changes {
                case .initial:
                    table.reloadData()
                case .update(_, let deletions, let insertions, let modifications):
                    table.performBatchUpdates({
                        table.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                        table.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                        table.reloadRows(at: modifications.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                    })
                case .error(let error):
                    print("Realm error: \(error)")
                }
            }


        }
    deinit {
        token?.invalidate()
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
            let InforVC = InformationVC(nibName: "InformationVC", bundle: nil)
            let backImage = UIImage(named: "Back")?.withRenderingMode(.alwaysOriginal)
               InforVC.navigationItem.leftBarButtonItem = UIBarButtonItem(
                   image: backImage,
                   style: .plain,
                   target: InforVC,
                   action: #selector(InformationVC.closeTapped)
               )
            let nav  = UINavigationController(rootViewController: InforVC)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        }

    

        private func setupTableView() {
            let nib = UINib(nibName: "UserCellVC", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "UserCellVC")
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tableFooterView = UIView()
            tableView.separatorStyle = .none
            tableView.backgroundColor = .background
        }
    }

  
    extension UserListVC: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            users?.count ?? 0
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
                profileVC.user = users[indexPath.row]
                navigationController?.pushViewController(profileVC, animated: true)
            }
}


