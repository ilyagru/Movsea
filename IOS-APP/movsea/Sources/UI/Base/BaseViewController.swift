//
//  BaseViewController.swift
//  movsea
//
//  Created by Movsea Team on 4/27/16.
//  Copyright © 2017 Movsea Team.
//

import UIKit
import Font_Awesome_Swift

class BaseViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        let backImg: UIImage = UIImage(icon: FAType.FALongArrowLeft, size: CGSize(width: 24, height: 24), textColor: UIColor.white)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backIndicatorImage = backImg
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImg
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }
 
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    func showMessage(message: String, complition: ((UIAlertAction) -> Swift.Void)? = nil ) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: complition)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

class ModalBaseViewController: BaseViewController {
    
    @IBOutlet weak var closeBarItem: UIBarButtonItem!
    
    override func loadView() {
        super.loadView()
    
        closeBarItem.setFAIcon(icon: FAType.FAClose, iconSize: 22)
    }
    
    @IBAction func onCloseButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
