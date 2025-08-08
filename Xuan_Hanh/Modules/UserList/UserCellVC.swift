//
//  UserCell.swift
//  Xuan_Hanh
//
//  Created by ikame on 7/28/25.
//

import UIKit

class UserCellVC: UITableViewCell {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userStatusLabel: UILabel!
    @IBOutlet weak var nextImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupContainerView()
     
    }
    func setupContainerView() {
        containerView.layer.cornerRadius = 16
        containerView.layer.masksToBounds = true
        containerView.backgroundColor = UIColor.neutral5
        self.backgroundColor = UIColor.clear
    }
    func configure(with user: User) {
        userNameLabel.text = "\(user.firstName) \(user.lastName)"
        userStatusLabel.text = "W: \(user.weight)kg - H: \(user.height)cm"
        userImageView.image = UIImage(named: "Ava")
        nextImageView.image = UIImage(named: "Right Circle")
    }
}
