//
//  MovieListCollectionCell.swift
//  movsea
//
//  Created by Movsea Team on 4/28/16.
//  Copyright © 2017 Movsea Team.
//

import UIKit
import AlamofireImage
import Font_Awesome_Swift

class MovieListCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var yearTitle: UILabel!
    @IBOutlet weak var durationTitle: UILabel!
    @IBOutlet weak var posterHeight: NSLayoutConstraint!
    
    var movie: Movie?
    
    func prepareCell(_ info: Movie) {
        posterHeight.constant = self.bounds.height * 0.6
        
        self.addShadow()
        
        movie = info
        
        let syncString = DateFormatter.getSyncString(info.syncDate)
        
        movieTitle.text = info.title
        yearTitle.text = info.year
        durationTitle.setFAText(prefixText: "", icon: FAType.FAClockO, postfixText: " " + syncString, size: 16)
        
        if let url = URL(string: info.poster) {
            posterImage.af_setImage(withURL: url)
        }
    }
    
}
