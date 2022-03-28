//
//  RegistrationController.swift
//  TinderFirestoreClone
//
//  Created by yupana on 3/28/22.
//  Copyright © 2022 Volkan Kuday. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {
    
    let selectPhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select Photo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        button.backgroundColor = #colorLiteral(red: 0.8548915668, green: 0.8548915668, blue: 0.8548915668, alpha: 1)
        button.setTitleColor(.black, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 275).isActive = true
        button.layer.cornerRadius = 16
        return button
    }()
    
    let fullNameTextField: UITextField = {
        let tf = CustomTextField(padding: 16)
        tf.placeholder = "Enter full name"
        tf.backgroundColor = #colorLiteral(red: 0.8548915668, green: 0.8548915668, blue: 0.8548915668, alpha: 1)
        return tf
    }()
    
    let emailTextField: UITextField = {
        let tf = CustomTextField(padding: 16)
        tf.placeholder = "Enter email"
        tf.keyboardType = .emailAddress
        tf.backgroundColor = #colorLiteral(red: 0.8548915668, green: 0.8548915668, blue: 0.8548915668, alpha: 1)
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = CustomTextField(padding: 16)
        tf.placeholder = "Enter password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = #colorLiteral(red: 0.8548915668, green: 0.8548915668, blue: 0.8548915668, alpha: 1)

        return tf
    }()
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        button.backgroundColor = #colorLiteral(red: 1, green: 0.1340694979, blue: 0.5010345965, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradientLayer()
        
        let stackView = UIStackView(arrangedSubviews: [selectPhotoButton, fullNameTextField, emailTextField, passwordTextField, registerButton])
        stackView.axis = .vertical
        stackView.spacing = 8
        
        view.addSubview(stackView)
        stackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 0, right: 50))
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    fileprivate func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        let topColor = #colorLiteral(red: 0.9784484506, green: 0.3712607026, blue: 0.3656714559, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.8921012282, green: 0.130292207, blue: 0.4520844221, alpha: 1)
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = view.bounds
        view.layer.addSublayer(gradientLayer)
    }
}
