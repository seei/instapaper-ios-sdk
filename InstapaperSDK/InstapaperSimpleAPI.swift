//
//  InstapaperSimpleAPI.swift
//  InstapaperSDK
//
//  Created by Sei Kataoka on 6/30/14.
//  Copyright (c) 2014 Sei Kataoka. All rights reserved.
//

import Foundation

class InstapaperSimpleAPI: NSObject {

    class var sharedAPI: InstapaperSimpleAPI {

        struct Singleton {
            static let instance = InstapaperSimpleAPI()
        }

        return Singleton.instance
    }

    let client: ISHTTPClient

    let store: ISCredentialStore

    init() {
        self.client = ISHTTPClient()
        self.store = ISCredentialStore()
    }

    func login(username: String, password: String?, success: ((NSURLResponse!) -> Void)?, failure: ((NSError!) -> Void)?) {
        self.client.authenticate(username, password: password, success: {
            response in
            self.store.save(username, password: password)
            success?(response)
        }, failure: failure)
    }

    func logout() {
        self.store.clear()
    }

    func isLoggedIn() -> Bool {
        let (username, password) = self.store.get()

        return username ? true : false
    }

    func saveURL(url: NSURL, success: ((NSURLResponse!) -> Void)?, failure: ((NSError!) -> Void)?) {
        self.saveURL(url, title: nil, selection: nil, success: success, failure: failure)
    }

    func saveURL(url: NSURL, title: String?, success: ((NSURLResponse!) -> Void)?, failure: ((NSError!) -> Void)?) {
        self.saveURL(url, title: title, selection: nil, success: success, failure: failure)
    }

    func saveURL(url: NSURL, title: String?, selection: String?, success: ((NSURLResponse!) -> Void)?, failure: ((NSError!) -> Void)?) {
        let (username, password) = self.store.get()

        self.client.add(username, password: password, url: url, title: title, selection: selection, success: success, failure: failure)
    }

}
