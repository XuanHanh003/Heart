//
//  Alert.swift
//  Xuan_Hanh
//
//  Created by ikame on 7/29/25.
//

import UIKit

class Alert: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var view: UIView!
    override init(frame: CGRect) {
            super.init(frame: frame)
            loadFromNib()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            loadFromNib()
        }
    func cornerButton() {
        cancelButton.layer.cornerRadius = 16
        yesButton.layer.cornerRadius = 16
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = UIColor.primary1.cgColor
        cancelButton.backgroundColor = .clear
        
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
    }
    
    private func loadFromNib() {
          let nib = UINib(nibName: "Alert", bundle: nil)
          guard let contentView = nib.instantiate(withOwner: self).first as? UIView else { return }

          contentView.frame = self.bounds
          contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
          self.addSubview(contentView)

          cornerButton()
      
    }
}
