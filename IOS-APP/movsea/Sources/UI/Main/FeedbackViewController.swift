//
//  FeedbackViewController.swift
//  movsea
//
//  Created by Movsea Team on 10/12/16.
//  Copyright © 2017 Movsea Team.
//

import UIKit

class FeedbackViewController: BaseViewController, UITextViewDelegate {
    
    @IBOutlet weak var sendBarButton: UIBarButtonItem!
    @IBOutlet weak var subjectBGView: UIView!
    @IBOutlet weak var messageBGView: UIView!
    @IBOutlet weak var subjectTextView: UITextView!
    @IBOutlet weak var messageTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subjectBGView.addShadow()
        messageBGView.addShadow()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        sendBarButton.isEnabled = subjectTextView.hasText && messageTextView.hasText
    }
    
    func clearFeedback() {
        subjectTextView.text = ""
        messageTextView.text = ""
    }
    
    @IBAction func onSendBarButton(_ sender: AnyObject) {
        Networking.sharedInstance.sendFeedback(subject: subjectTextView.text, message: messageTextView.text) { result in
            switch result {
            case .success( _) :
                self.showMessage(message: "Thank you for your feedback!") { (action) in
                    self.dismiss(animated: true, completion: nil)
                }
            case .failure(let error):
                self.showMessage(message: error.localizedDescription)
            }
        }
    }
    
    @IBAction func onCloseBarButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


