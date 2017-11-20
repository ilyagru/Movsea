//
//  VideoProcessing.swift
//  movsea
//
//  Created by Movsea Team on 5/4/16.
//  Copyright © 2017 Movsea Team.
//

import UIKit
import Alamofire
import Font_Awesome_Swift

class SearchVideoController: ModalBaseViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    let kRotationAnimationKey = "com.movsea.rotationanimationkey"
    var request:Request?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.setFAIconWithName(icon: FAType.FASpinner, textColor: UIColor.white)
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    override var preferredStatusBarUpdateAnimation : UIStatusBarAnimation {
        return .slide
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        uploadVideo()
    }
    
    fileprivate func animateRotation() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Double.pi * 2.0
        rotationAnimation.duration = 2
        rotationAnimation.repeatCount = Float.infinity
        self.imageView.layer.add(rotationAnimation, forKey:kRotationAnimationKey)
    }
    
    func uploadVideo() {
        animateRotation()
        request = Networking.sharedInstance.porcessMovie() { result in
            self.imageView.layer.removeAnimation(forKey: self.kRotationAnimationKey)
            switch result {
                case .success(let movie) :
                    guard let movieDetailsViewController = R.storyboard.main.movieDetailsViewController() else { return }
                    movieDetailsViewController.movie = movie
                    self.navigationController?.pushViewController(movieDetailsViewController, animated: true)
                case .failure(let error):
                    guard let notFoundController = R.storyboard.main.notFoundController() else { return }
                    notFoundController.error = error as NSError!
                    self.navigationController?.pushViewController(notFoundController, animated: true)
            }
        }
    }
    
    @IBAction override func onCloseButton(_ sender: AnyObject) {
        self.request?.cancel()
        super.onCloseButton(sender)
    }
}



class NotFoundController: ModalBaseViewController {
    
    @IBOutlet weak var tryButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!

    var error:NSError!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)

        tryButton.setFAIcon(icon: FAType.FAUndo, iconSize: 54, forState: UIControlState())
        tryButton.setFATitleColor(color: UIColor.white)

        
        showAlert(self.error)
    }
    
    fileprivate func showAlert(_ error: NSError) {
        self.errorLabel.text = error.localizedDescription
        UIView.animate(withDuration: 10, animations: {
            self.errorLabel.alpha = 0
        }) 

        
    }
    
    override var prefersStatusBarHidden : Bool {
        return false
    }
    
    override var preferredStatusBarUpdateAnimation : UIStatusBarAnimation {
        return .slide
    }
    
    @IBAction func onTryButton(_ sender: AnyObject) {
        guard let cameraController = R.storyboard.main.cameraViewController() else { return }
        navigationController?.pushViewController(cameraController, animated: true)
    }
    
}
