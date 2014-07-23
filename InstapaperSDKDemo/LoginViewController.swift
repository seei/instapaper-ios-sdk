//
//  LoginViewController.swift
//  InstapaperSDK
//
//  Created by Sei Kataoka on 7/6/14.
//  Copyright (c) 2014 Sei Kataoka. All rights reserved.
//

import UIKit
import InstapaperSDK

class LoginViewController: UIViewController {

    @IBOutlet var username: UITextField

    @IBOutlet var password: UITextField

    @IBOutlet var indicator: UIActivityIndicatorView

    @IBAction func signin(sender: AnyObject) {
        indicator.startAnimating()
        InstapaperSimpleAPI.sharedAPI.login(username.text, password: password.text, success: {
            response in
            self.indicator.stopAnimating()
            self.dismissViewControllerAnimated(true, completion: nil)
        }, failure: {
            error in
            self.indicator.stopAnimating()
            UIAlertView(title: "Error!", message: "\(error.localizedDescription)", delegate: nil, cancelButtonTitle: "Close").show()
        })
    }

}
