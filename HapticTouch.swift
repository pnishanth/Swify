//
//  ViewController.swift
//  Haptic Touch
//
//  Created by Nishanth P on 7/4/17.
//  Copyright © 2017 Nishapp. All rights reserved.
//


class ViewController : UIViewController {

    var feedbackGen : UINotificationFeedbackGenerator?

override func viewDidLoad()
{
    super.viewDidLoad()
    feedbackGen = UINotificationFeedbackGenerator()

    let singleTap = UITapGestureRecognizer(target:self, action:#selector(self.handleSingleTap))
    singleTap.numberOfTouchesRequired = 1
    singleTap.addTarget(self, action:#selector(self.handleSingleTap))
    view.isUserInteractionEnabled = true
    view.addGestureRecognizer(singleTap)
}

    func handleSingleTap(sender:UITapGestureRecognizer)
    {
        feedbackGen?.notificationOccurred(.success)
    }
}

