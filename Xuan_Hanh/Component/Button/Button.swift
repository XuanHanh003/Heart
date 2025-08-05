//
//  Button.swift
//  Xuan_Hanh
//
//  Created by ikame on 7/21/25.
//

import UIKit


    
protocol ButtonDelegate: AnyObject {
    func buttonTapped()
}

class Button: UIView {
    @IBOutlet weak var button: UIButton!
    weak var delegate: ButtonDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromNib()
    }

    func setTitle(_ title: String) {
        button.setTitle(title, for: .normal)
    }

    @IBAction func didTapButton(_ sender: UIButton) {
        delegate?.buttonTapped()
    }

    private func loadFromNib() {
        let nib = UINib(nibName: "Button", bundle: nil)
        let nibView = nib.instantiate(withOwner: self).first as! UIView
       
        addSubview(nibView)

        nibView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nibView.topAnchor.constraint(equalTo: topAnchor),
            nibView.bottomAnchor.constraint(equalTo: bottomAnchor),
            nibView.leadingAnchor.constraint(equalTo: leadingAnchor),
            nibView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        nibView.layer.cornerRadius = 16
    }
}
