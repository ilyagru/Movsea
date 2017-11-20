//
//  UIView+Shadow.swift
//  movsea
//
//  Created by Movsea Team on 5/4/16.
//  Copyright © 2017 Movsea Team.
//

import UIKit

extension UIView {
    
    func addShadow() {
        let layer = self.layer
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 4)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 4
        layer.masksToBounds = false
        self.clipsToBounds = false
    }
    
}
