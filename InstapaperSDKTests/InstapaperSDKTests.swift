//
//  InstapaperSDKTests.swift
//  InstapaperSDKTests
//
//  Created by Sei Kataoka on 6/29/14.
//  Copyright (c) 2014 Sei Kataoka. All rights reserved.
//

import XCTest
import InstapaperSDK

class InstapaperSDKTests: XCTestCase {

    let username = "Enter your username"

    let password = "Enter your password"

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testLogin() {
        let expectation = self.expectationWithDescription("logged in")

        InstapaperSimpleAPI.sharedAPI.login(username, password: password, success: {
            response in
            expectation.fulfill()
        }, failure: {
            error in
            XCTFail("\(error)")
            expectation.fulfill()
        })

        self.waitForExpectationsWithTimeout(5, handler: nil)
    }

    func testIsLoggedIn() {
        let expectation = self.expectationWithDescription("is logged in")

        InstapaperSimpleAPI.sharedAPI.logout()
        XCTAssertFalse(InstapaperSimpleAPI.sharedAPI.isLoggedIn(), "not logged in")

        InstapaperSimpleAPI.sharedAPI.login(username, password: password, success: {
            response in
            XCTAssertTrue(InstapaperSimpleAPI.sharedAPI.isLoggedIn(), "logged in")
            expectation.fulfill()
        }, failure: {
            error in
            XCTFail("\(error)")
            expectation.fulfill()
        })

        self.waitForExpectationsWithTimeout(5, handler: nil)
    }

    func testLogout() {
        let expectation = self.expectationWithDescription("not logged in")

        InstapaperSimpleAPI.sharedAPI.login(username, password: password, success: {
            response in
            XCTAssertTrue(InstapaperSimpleAPI.sharedAPI.isLoggedIn(), "logged in")
            InstapaperSimpleAPI.sharedAPI.logout()
            XCTAssertFalse(InstapaperSimpleAPI.sharedAPI.isLoggedIn(), "not logged in")
            expectation.fulfill()
            }, failure: {
                error in
                XCTFail("\(error)")
                expectation.fulfill()
            })

        self.waitForExpectationsWithTimeout(5, handler: nil)
    }

}
