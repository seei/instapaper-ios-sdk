//
//  InstapaperSimpleAPIStore.swift
//  InstapaperSDK
//
//  Created by Sei Kataoka on 7/2/14.
//  Copyright (c) 2014 Sei Kataoka. All rights reserved.
//

import Foundation

class ISCredentialStore {

    let serviceName = "InstapaperSDK"

    func get() -> (username: String?, password: String?) {
        let username: AnyObject? = getValueForKey("username")
        let password: AnyObject? = getValueForKey("password")

        return (username as? String, password as? String)
    }

    func save(username: String?, password: String?) {
        self.setValue(username, key: "username")
        self.setValue(password, key: "password")
    }

    func clear() {
        self.setValue(nil, key: "username")
        self.setValue(nil, key: "password")
    }

    func getValueForKey(key: String) -> (key: AnyObject?) {
        // TODO: Use TARGET_IPHONE_SIMULATOR when it become available in Swift.
        if IPHONE_SIMULATOR == 1 {
            return NSUserDefaults.standardUserDefaults().objectForKey("\(serviceName).\(key)")
        } else {
            return SSKeychain.passwordForService(serviceName, account: key)
        }
    }

    func setValue(value: String?, key: String) {
        if value {
            // TODO: Use TARGET_IPHONE_SIMULATOR when it become available in Swift.
            if IPHONE_SIMULATOR == 1 {
                NSUserDefaults.standardUserDefaults().setObject(value, forKey: "\(serviceName).\(key)")
            } else {
                SSKeychain.setPassword(value, forService: serviceName, account: key)
            }
        } else {
            // TODO: Use TARGET_IPHONE_SIMULATOR when it become available in Swift.
            if IPHONE_SIMULATOR == 1 {
                NSUserDefaults.standardUserDefaults().removeObjectForKey("\(serviceName).\(key)")
            } else {
                SSKeychain.deletePasswordForService(serviceName, account: key)
            }
        }
    }

}
