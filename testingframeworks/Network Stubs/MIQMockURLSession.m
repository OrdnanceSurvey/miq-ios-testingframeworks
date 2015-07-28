//
//  MIQMockURLSession.m
//  MIQTestingFramework
//
//  Created by Dave Hardiman on 28/07/2015.
//  Copyright (c) 2015 David Hardiman. All rights reserved.
//

#import "MIQMockURLSession.h"
@import OCMock;

@implementation MIQMockURLSession

+ (id)mockSession {
    return OCMClassMock(NSURLSession.class);
}

- (void)stubRequest:(NSURLRequest *__nonnull)request withData:(NSData *__nullable)data response:(NSURLResponse *__nullable)response error:(NSError *__nullable)error testBlock:(void (^__nonnull)())testBlock {
}

@end

@implementation OCMockObject (MIQMockURLSession)

- (void)stubRequest:(NSURLRequest *__nonnull)request withData:(NSData *__nullable)data response:(NSURLResponse *__nullable)response error:(NSError *__nullable)error testBlock:(void (^__nonnull)())testBlock {
    __block void (^sessionBlock)(NSData *data, NSURLResponse *response, NSError *error) = nil;
    [[self expect] dataTaskWithRequest:[OCMArg checkWithBlock:^BOOL(id obj) {
                       return [obj isEqual:request];
                   }]
                     completionHandler:[OCMArg checkWithBlock:^BOOL(id obj) {
                         sessionBlock = [obj copy];
                         return YES;
                     }]];
    testBlock();
    [self verify];
    sessionBlock(data, response, error);
}

@end
