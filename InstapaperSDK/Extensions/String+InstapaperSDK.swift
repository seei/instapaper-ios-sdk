//
//  String+InstapaperSDK.swift
//  InstapaperSDK
//
//  Created by Sei Kataoka on 7/2/14.
//  Copyright (c) 2014 Sei Kataoka. All rights reserved.
//

import Foundation

extension String {

    func urlEncodedStringWithEncoding(encoding: NSStringEncoding) -> String {
        let charactersToBeEscaped = ":/?&=;+!#$()',*" as CFStringRef
        let charactersToLeaveUnescaped = "[]." as CFStringRef
        let result = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, self.bridgeToObjectiveC(), charactersToLeaveUnescaped, charactersToBeEscaped, CFStringConvertNSStringEncodingToEncoding(encoding)) as String
        return result
    }

}
