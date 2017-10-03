//
//  mailController.swift
//  mailController
//
//  Created by Nishanth P on 10/2/17.
//  Copyright © 2017 Nishapp. All rights reserved.
//

import Foundation
import MessageUI
import UIKit

class mailController: UIViewController, MFMailComposeViewControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !MFMailComposeViewController.canSendMail() {
            print("Mail cannot be sent")
            return
        }
        sendEmail()
    }
    
    func sendEmail() {
        
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        composeVC.setToRecipients(["me@google.com"])
        composeVC.setSubject("Subject")
        composeVC.setMessageBody("Body Message", isHTML: false)
    
        self.present(composeVC, animated: true, completion: nil)
    }
    
    func mailComposeController(controller: MFMailComposeViewController,
                               didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        controller.dismiss(animated: true, completion: nil)
    }
    
}
