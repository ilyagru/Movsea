//
//  MovieDetailsViewController.swift
//  movsea
//
//  Created by Movsea Team on 4/28/16.
//  Copyright © 2017 Movsea Team.
//

import UIKit
import AVKit
import AVFoundation
import AlamofireImage
import Font_Awesome_Swift

class MovieDetailsViewController: ModalBaseViewController {
    
    @IBOutlet weak var shareBarButton: UIBarButtonItem!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var trailerButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var posterHeight: NSLayoutConstraint!
  
    var moviePlayer = AVPlayerViewController()
    
    var movie: Movie?
    var timer:Timer?

    override var prefersStatusBarHidden : Bool {
        return false
    }
    
    override var preferredStatusBarUpdateAnimation : UIStatusBarAnimation {
        return .slide
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer?.invalidate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
        bgView.addShadow()
        navigationController?.setNavigationBarHidden(false, animated: true)
        shareBarButton.setFAIcon(icon: FAType.FAShare, iconSize: 16)

        configureViewWithMovie()
        startDialogTimer()
    }
    
    private func configureViewWithMovie() {
        guard let movie = movie else { return }
        
        posterHeight.constant = (self.view.bounds.height - 64 - 16) * 0.55

        let ratingString = String(format:"%1.1f", movie.rating) + "/10"
        let attributedText = NSMutableAttributedString(string: ratingString, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.semibold)])
        attributedText.addAttributes([NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12)], range: NSRange(location: 3, length: 3))
        
        ratingLabel.attributedText = attributedText
        
        trailerButton.setFAText(prefixText: "", icon: FAType.FAPlayCircle, postfixText: " Watch trailer", size: 12, forState: UIControlState(), iconSize: 16)
        trailerButton.setFATitleColor(color: UIColor.black, forState: UIControlState())
        
        titleLabel.text = movie.title
        countryLabel.text = movie.country + ", " + movie.year
        
        // descriptionLabel.text = String(format: "Director: %@ \nStars: %@ \nDescription: %@", movie.directors, movie.stars, movie.movieDescription)
        
        // Bold headers of description
        let boldAtt = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)]
        
        let fullDescriptionString = "Director: \(movie.directors) \nStars: \(movie.stars) \nDescription: \(movie.movieDescription)" as NSString
        let descriptionAttributedString = NSMutableAttributedString(string: fullDescriptionString as String)
        
        descriptionAttributedString.addAttributes(boldAtt, range: fullDescriptionString.range(of: "Director:"))
        descriptionAttributedString.addAttributes(boldAtt, range: fullDescriptionString.range(of: "Stars:"))
        descriptionAttributedString.addAttributes(boldAtt, range: fullDescriptionString.range(of: "Description:"))
        
        descriptionLabel.attributedText = descriptionAttributedString
        
        if let url = URL(string: movie.poster) {
            posterImage.af_setImage(withURL: url)
        }
    }
    
    private func startDialogTimer() {
        guard let movie = movie else { return }

        if !movie.isMovieStatsSent {
            timer = Timer.scheduledTimer(timeInterval: TimeInterval(2), target:self, selector: #selector(MovieDetailsViewController.showUserDialog), userInfo: nil, repeats: false)
        }
    }
    
    @objc func showUserDialog() {
        timer?.invalidate()
        
        guard let movie = movie else { return }
        
        let alertController = UIAlertController(title: "Have Movsea found the right movie?", message: "Take a minute to write to us a few words about your experience. You can do it in Settings.", preferredStyle: .alert)
        let noAction = UIAlertAction(title: "NO", style: .default) { (action) in
            Networking.sharedInstance.sendFilmStats(movie: movie, statistic: false)
            movie.processFilmStatsSending()
        }
        let yesAction = UIAlertAction(title: "YES", style: .default) { (action) in
            Networking.sharedInstance.sendFilmStats(movie: movie, statistic: true)
            movie.processFilmStatsSending()
        }
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func onTrailerButton(_ sender: AnyObject) {
        guard let movie = movie else { return }
        guard let videoURL = URL(string: movie.trailer) else { return }
        moviePlayer.player = AVPlayer(url: videoURL)

        self.present(moviePlayer, animated: true) {
            self.moviePlayer.player!.play()
        }
    }
    
    @IBAction func onBuyButton(_ sender: AnyObject) {
        guard let movie = movie else { return }
        guard let url = URL(string: movie.buyMovie) else { return }
        
        UIApplication.shared.openURL(url)
    }


    @IBAction func onShareButton(_ sender: AnyObject) {
        guard let movie = movie else { return }

        let excludeActivities = [UIActivityType.airDrop, UIActivityType.print, UIActivityType.assignToContact,UIActivityType.saveToCameraRoll, UIActivityType.addToReadingList, UIActivityType.postToFlickr, UIActivityType.postToVimeo];
        
        let textToShare = "I found the movie \(movie.title) using this awesome application Movsea."
        guard let urlToShare = URL(string: linkToAppStore) else {
            return
        }
        
        let activityViewController = UIActivityViewController(activityItems: [textToShare, urlToShare], applicationActivities: nil)
        activityViewController.excludedActivityTypes = excludeActivities;
        
        self.present(activityViewController, animated: true, completion: nil)
    }
}
