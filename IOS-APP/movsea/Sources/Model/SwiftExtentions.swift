//
//  SwiftExtentions.swift
//  movsea
//
//  Created by Movsea Team on 4/27/16.
//  Copyright © 2017 Movsea Team.
//

import UIKit
import Font_Awesome_Swift

extension UIColor {
    
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
    
    class func lightSeaColor() -> UIColor {
        return UIColor(hex: 0x2BC1BD)
    }
}
