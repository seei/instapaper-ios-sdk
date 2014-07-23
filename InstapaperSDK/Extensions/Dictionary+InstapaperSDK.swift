//
//  Dictionary+InstapaperSDK.swift
//  InstapaperSDK
//
//  Created by Sei Kataoka on 7/1/14.
//  Copyright (c) 2014 Sei Kataoka. All rights reserved.
//

import Foundation

extension Dictionary {

    func queryStringWithEncoding() -> String {
        var parts = [String]()

        for (key, val) in self {
            let keyString: String = "\(key)"
            let valString: String = "\(val)"
            let query: String = "\(keyString)=\(valString)"
            parts.append(query)
        }

        return parts.bridgeToObjectiveC().componentsJoinedByString("&") as String
    }

}
