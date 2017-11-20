//
//  MainViewController.swift
//  movsea
//
//  Created by Movsea Team on 4/27/16.
//  Copyright © 2017 Movsea Team.
//

import UIKit
import Font_Awesome_Swift

class MainViewController: BaseViewController {
    
    @IBOutlet weak var bottomViewContainer: NSLayoutConstraint!
    @IBOutlet weak var logoWidth: NSLayoutConstraint!
    @IBOutlet weak var logoTop: NSLayoutConstraint!
    
    
    @IBOutlet weak var findingsBarButton: UIBarButtonItem!
    @IBOutlet weak var searchButton: UIButton!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let typedInfo = R.segue.mainViewController.showTermsOfUse(segue: segue) {
            let termsViewController = typedInfo.destination.viewControllers.first as! TermsOfUseViewController
            termsViewController.isAgreed = true
        }
    }
    
    override func loadView() {
        super.loadView()
        
        let mainRect = UIScreen.main.bounds
        
        logoWidth.constant = mainRect.width / 2.5
        logoTop.constant = mainRect.width / 6
        bottomViewContainer.constant = mainRect.height / 3
        
        let findings = UIButton(type: .custom)
        findings.addTarget(self, action: #selector(onFindingsButton), for: .touchUpInside)
        findings.setFAText(prefixText: "", icon: FAType.FAFilm, postfixText: " Findings", size: 16, forState: UIControlState())
        findings.setFATitleColor(color: UIColor.white)
        findings.sizeToFit()        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: findings)
        
        let settings = UIButton(type: .custom)
        settings.addTarget(self, action: #selector(onSettingsButton), for: .touchUpInside)
        settings.setFAText(prefixText: "Settings ", icon: FAType.FACog, postfixText: "", size: 16, forState: UIControlState())
        settings.setFATitleColor(color: UIColor.white)
        settings.sizeToFit()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: settings)
        
        searchButton.setFAText(prefixText: "", icon: FAType.FASearch, postfixText: " SEARCH MOVIE", size: 18, forState: UIControlState())
        searchButton.setFATitleColor(color: UIColor.white)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkFirstLaunch()
    }
    
    @objc func onFindingsButton() {
        self.performSegue(withIdentifier: R.segue.mainViewController.showFindings, sender: self)
    }
    
    @objc func onSettingsButton() {
        self.performSegue(withIdentifier: R.segue.mainViewController.showSettings, sender: self)
    }
    
    func checkFirstLaunch() {
        if !User.getUser().isAgreed {
            let termsOfUseController = R.storyboard.main.termsOfUseViewController()
            self.present(termsOfUseController!, animated: true, completion: nil)
        }
    }

}
