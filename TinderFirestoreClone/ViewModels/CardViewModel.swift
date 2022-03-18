//
//  CardViewModel.swift
//  TinderFirestoreClone
//
//  Copyright © 2022 Volkan Kuday. All rights reserved.
//

import UIKit

protocol ProducesCardViewModel {
    func toCardViewModel() -> CardViewModel
}

struct CardViewModel {
    let imageName: String
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
}


