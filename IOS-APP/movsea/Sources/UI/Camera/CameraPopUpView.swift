//
//  CameraPopUpView.swift
//  movsea
//
//  Created by Movsea Team on 10/12/16.
//  Copyright © 2017 Movsea Team.
//

import UIKit

class CameraPopUpView: UIView {
    
    var textLabel:UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        textLabel = UILabel()
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        textLabel.text = "Point the camera at the screen with a movie. Try to shoot straight and without movements"
        textLabel.textColor = UIColor.lightSeaColor()
        textLabel.font = UIFont.systemFont(ofSize: 18)
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.transform = CGAffineTransform(rotationAngle: (CGFloat)(Double.pi / 2));
        
        self.addSubview(textLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel.frame = self.bounds.insetBy(dx: self.bounds.width * 0.2, dy: self.bounds.height * 0.1)
    }

}
