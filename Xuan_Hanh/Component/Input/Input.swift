//
//  Input.swift
//  Xuan_Hanh
//
//  Created by ikame on 7/24/25.
//

import UIKit

class Input: UIView {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override init(frame: CGRect) {
         super.init(frame: frame)
         loadFromNib()
     }

     required init?(coder: NSCoder) {
         super.init(coder: coder)
         loadFromNib()
         cornerTextField()
     }
     
     override func layoutSubviews() {
         
     }
    func cornerTextField() {
        textField.layer.cornerRadius = 16
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.neutral4.cgColor
        textField.clipsToBounds = true
    }
     private func loadFromNib() {
         let nib = UINib(nibName: "Input", bundle: nil)
         let nibView = nib.instantiate(withOwner: self).first as! UIView

         addSubview(nibView)
         nibView.translatesAutoresizingMaskIntoConstraints = false
         nibView.topAnchor.constraint(equalTo: topAnchor).isActive = true
         nibView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
         nibView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
         nibView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    
     }
    
 }
