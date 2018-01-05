//
//  ViewController.swift
//  Activity Indicator
//
//  Created by Nishanth P on 7/23/17.
//  Copyright © 2017 Nishapp. All rights reserved.
//


import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
            showActivityIndicatory()

    }ss

    func showActivityIndicatory(uiView: UIView) {
        var container: UIView = UIView()
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColorFromHex(0xffffff, alpha: 0.3)

        var loadingView: UIView = UIView()
        loadingView.frame = CGRectMake(0, 0, 80, 80)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColorFromHex(0x444444, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10

        var actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        actInd.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.WhiteLarge
        actInd.center = CGPointMake(loadingView.frame.size.width / 2,
                                    loadingView.frame.size.height / 2);
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        actInd.startAnimating()
    }


}


