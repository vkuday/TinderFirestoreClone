//
//  ViewController.swift
//  TinderFirestoreClone
//
//  Created by Volkan Kuday on 3/10/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let subviews = [UIColor.gray, UIColor.darkGray, UIColor.black].map { color -> UIView in
            let v = UIView()
            v.backgroundColor = color
            return v
        }
        
        let topStackView = UIStackView(arrangedSubviews: subviews)
        topStackView.distribution = .fillEqually
        topStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let blueView = UIView()
        blueView.backgroundColor = .systemBlue
        
        let yellowView = UIView()
        yellowView.backgroundColor = .systemYellow
        yellowView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [topStackView, blueView, yellowView])
        stackView.axis = .vertical
        view.addSubview(stackView)
        
        stackView.fillSuperview()
        
    }


}

