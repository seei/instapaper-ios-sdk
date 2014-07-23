//
//  Instapaper-Bridging-Header.h
//  InstapaperSDK
//
//  Created by Sei Kataoka on 6/29/14.
//  Copyright (c) 2014 Sei Kataoka. All rights reserved.
//

#import "SSKeychainQuery.h"
#import "SSKeychain.h"

#if TARGET_IPHONE_SIMULATOR
#define IPHONE_SIMULATOR 1
#else
#define IPHONE_SIMULATOR 0
#endif
