//
//  ViewController.swift
//  InstapaperSDKDemo
//
//  Created by Sei Kataoka on 6/29/14.
//  Copyright (c) 2014 Sei Kataoka. All rights reserved.
//

import UIKit
import InstapaperSDK

class ViewController: UIViewController {
                            
    @IBOutlet var url: UITextField

    @IBOutlet var indicator: UIActivityIndicatorView

    @IBOutlet var check: UILabel

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if !InstapaperSimpleAPI.sharedAPI.isLoggedIn() { self.performSegueWithIdentifier("signin", sender: nil) }
    }

    @IBAction func add(sender: AnyObject) {
        indicator.startAnimating()
        InstapaperSimpleAPI.sharedAPI.saveURL(NSURL(string: url.text), success: {
            response in
            self.url.text = ""
            self.indicator.stopAnimating()
            self.check.hidden = false
            self.check.alpha = 1
            UIView.animateWithDuration(1, animations: { self.check.alpha = 0 }, completion: { _ in self.check.hidden = true })
        }, failure: {
            error in
            self.url.text = ""
            self.indicator.stopAnimating()
            UIAlertView(title: "Error!", message: "\(error.localizedDescription)", delegate: nil, cancelButtonTitle: "Close").show()
        })
    }

    @IBAction func signout(sender: AnyObject) {
        InstapaperSimpleAPI.sharedAPI.logout()
        self.performSegueWithIdentifier("signin", sender: nil)
    }

}

