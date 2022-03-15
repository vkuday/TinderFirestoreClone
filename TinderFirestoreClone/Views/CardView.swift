//
//  CardView.swift
//  TinderFirestoreClone
//
//  Copyright © 2022 Volkan Kuday. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "lady5c"))
    let informationLabel = UILabel()
    
    fileprivate let threshold: CGFloat = 80

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.fillSuperview()
        
        addSubview(informationLabel)
        informationLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
        informationLabel.textColor = .white
        informationLabel.font = UIFont.systemFont(ofSize: 34, weight: .heavy)
        informationLabel.numberOfLines = 0
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            handleChanged(gesture)
        case .ended:
            handleEnded(gesture)
        default:
            break
        }
    }
    
    fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        let degrees: CGFloat = translation.x / 20
        let angle = degrees * .pi / 180
        
        let rotationalTransformation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransformation.translatedBy(x: translation.x, y: translation.y)
    }
    
    fileprivate func handleEnded(_ gesture: UIPanGestureRecognizer) {
        let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
        let shouldDismissCard = abs(gesture.translation(in: nil).x) > threshold
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut) {
            if shouldDismissCard {
                let offScreenTransform = self.transform.translatedBy(x: 600 * translationDirection, y: 0)
                self.transform = offScreenTransform
            } else {
                self.transform = .identity
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
