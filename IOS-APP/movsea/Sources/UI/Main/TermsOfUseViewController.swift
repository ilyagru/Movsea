//
//  TermsOfUseViewController.swift
//  movsea
//
//  Created by Movsea Team on 10/12/16.
//  Copyright © 2017 Movsea Team.
//

import UIKit

class TermsOfUseViewController: BaseViewController {
    
    @IBOutlet weak var closeBarButton: UIBarButtonItem!
    @IBOutlet weak var agreeBarButton: UIBarButtonItem!
    
    @IBOutlet weak var termsBgView: UIView!
    @IBOutlet weak var termsTextView: UITextView!
    
    var isAgreed:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        termsBgView.addShadow()
        
        termsTextView.isScrollEnabled = false
        
        closeBarButton.isEnabled = isAgreed
        agreeBarButton.isEnabled = !isAgreed
        agreeBarButton.title = isAgreed ? "Agreed" : "I've Read & Agree"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        termsTextView.isScrollEnabled = true
    }
    
    @IBAction func onCloseButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion:nil)
    }
    
    @IBAction func onAgreeButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: {
            User.agreeWithTerms()
        })
    }
}
