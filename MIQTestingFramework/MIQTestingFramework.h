//
//  MIQTestingFramework.h
//  MIQTestingFramework
//
//  Created by Dave Hardiman on 23/07/2015.
//  Copyright (c) 2015 Mobile IQ. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for MIQTestingFramework.
FOUNDATION_EXPORT double MIQTestingFrameworkVersionNumber;

//! Project version string for MIQTestingFramework.
FOUNDATION_EXPORT const unsigned char MIQTestingFrameworkVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <MIQTestingFramework/PublicHeader.h>

@import XCTest;
#define EXP_SHORTHAND
@import Expecta;
@import<Expecta / NSObect + Expecta.h> @import Specta;
@import OCMock;
@import OHHTTPStubs.h
#import <MIQTestingFramework/MIQCoreDataTestCase.h>
#import <MIQTestingFramework/SPTCoreDataSpec.h>
#import <MIQTestingFramework/XCTestCase+LoadViewController.h>
