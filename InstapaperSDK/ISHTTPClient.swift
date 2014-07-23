//
//  InstapaperSimpleAPIClient.swift
//  InstapaperSDK
//
//  Created by Sei Kataoka on 7/1/14.
//  Copyright (c) 2014 Sei Kataoka. All rights reserved.
//

import Foundation

class ISHTTPClient {

    typealias SuccessHandler = (NSURLResponse!) -> Void
    typealias FailureHandler = (NSError!) -> Void

    var baseURL: NSURL

    var timeoutInterval: NSTimeInterval

    var HTTPShouldHandleCookies: Bool

    var dataEncoding: NSStringEncoding

    init() {
        self.baseURL = NSURL(string: "https://www.instapaper.com/")
        self.timeoutInterval = 60
        self.HTTPShouldHandleCookies = false
        self.dataEncoding = NSUTF8StringEncoding
    }

    func authenticate(username: String?, password: String?, success: SuccessHandler?, failure: FailureHandler?) {
        let path = "api/authenticate"

        self.post(path, username: username, password: password, params: nil, success: success, failure: failure)
    }

    func add(username: String?, password: String?, url: NSURL, title: String?, selection: String?, success: SuccessHandler?, failure: FailureHandler?) {
        let path = "api/add"

        var params = Dictionary<String, AnyObject>()

        params["url"] = url
        if title { params["title"] = title! }
        if selection { params["selection"] = selection! }

        self.post(path, username: username, password: password, params: params, success: success, failure: failure)
    }

    func post(path: String, username: String?, password: String?, params: Dictionary<String, AnyObject>?, success: SuccessHandler?, failure: FailureHandler?) {
        let url = NSURL(string: path, relativeToURL: baseURL)
        let request = NSMutableURLRequest(URL: url)

        request.HTTPMethod = "POST"
        request.timeoutInterval = timeoutInterval
        request.HTTPShouldHandleCookies = HTTPShouldHandleCookies

        let basicCredentials = base64EncodedCredentialsWithKey(username, secret: password)

        request.setValue("Basic \(basicCredentials)", forHTTPHeaderField: "Authorization")

        if params {
            let queryString = params!.queryStringWithEncoding()

            if let data = queryString.dataUsingEncoding(dataEncoding) {
                request.setValue("\(data.length)", forHTTPHeaderField: "Content-Length")
                request.HTTPBody = data
            }
        }

        // UIApplication.sharedApplication().networkActivityIndicatorVisible = true

        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {
            response, data, error in
            // UIApplication.sharedApplication().networkActivityIndicatorVisible = false

            if error {
                failure?(error)
                return
            }

            let statusCode: Int = (response as NSHTTPURLResponse).statusCode

            if statusCode >= 400 {
                let localizedDescription = self.descriptionForHTTPStatus(statusCode)
                let userInfo = [NSLocalizedDescriptionKey: localizedDescription]
                let error = NSError(domain: NSURLErrorDomain, code: statusCode, userInfo: userInfo)

                failure?(error)
                return
            }

            success?(response)
        })
    }

    func base64EncodedCredentialsWithKey(key: String?, secret: String?) -> String? {
        var bearerTokenCredentials = ""

        if key { bearerTokenCredentials += key!.urlEncodedStringWithEncoding(NSUTF8StringEncoding) }
        bearerTokenCredentials += ":"
        if secret { bearerTokenCredentials += secret!.urlEncodedStringWithEncoding(NSUTF8StringEncoding) }

        let data = bearerTokenCredentials.dataUsingEncoding(NSUTF8StringEncoding)

        return data?.base64EncodedStringWithOptions(nil)
    }

    func descriptionForHTTPStatus(status: Int) -> String {
        var description = "HTTP Status \(status)"

        var message: String?
        switch status {
        case 400:
            message = "Bad request or exceeded the rate limit. Probably missing a required parameter."
        case 403:
            message = "Invalid username or password."
        case 500:
            message = "The service encountered an error. Please try again later."
        default:
            message = nil
        }

        if message { description = "\(description): \(message)" }

        return description
    }

}
