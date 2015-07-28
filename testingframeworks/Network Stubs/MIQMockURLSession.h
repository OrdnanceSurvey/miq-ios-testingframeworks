//
//  MIQMockURLSession.h
//  MIQTestingFramework
//
//  Created by Dave Hardiman on 28/07/2015.
//  Copyright (c) 2015 David Hardiman. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  Object that can be used to mock an NSURLSession
 *  for testing.
 */
@interface MIQMockURLSession : NSObject

/**
 *  Creates a mock URL session object that can be used in place of `NSURLSession`
 *
 *  @return The mock session to pass
 */
+ (id)mockSession;

/**
 *  Expects a call to be made satisfying the passed in request and then returns the passed in data
 *
 *  @param request   The expected request
 *  @param data      The data to return or nil
 *  @param response  The response to return or nil
 *  @param error     The error to return or nil
 *  @param testBlock The block to call to run the test
 */
- (void)stubRequest:(NSURLRequest *)request withData:(NSData *__nullable)data response:(NSURLResponse *__nullable)response error:(NSError *__nullable)error testBlock:(void (^)())testBlock;

@end

NS_ASSUME_NONNULL_END