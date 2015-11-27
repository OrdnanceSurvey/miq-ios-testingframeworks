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

- (void)stubRequest:(NSURLRequest *)request withData:(NSData *_Nullable)data response:(NSURLResponse *_Nullable)response error:(NSError *_Nullable)error testBlock:(void (^)())testBlock {
}

- (void)stubRequestForURL:(NSURL *)url withData:(NSData *)data response:(NSURLResponse *)response error:(NSError *)error testBlock:(void (^)())testBlock {
}

- (void)stubDownloadRequest:(NSURLRequest *)request withData:(NSData *)data response:(NSURLResponse *)response error:(NSError *)error testBlock:(void (^)())testBlock {
}

- (void)stubDownloadForURL:(NSURL *)url withData:(NSData *)data response:(NSURLResponse *)response error:(NSError *)error testBlock:(void (^)())testBlock {
}

@end

@implementation OCMockObject (MIQMockURLSession)

- (void)stubRequestWithCheck:(BOOL (^)(NSURLRequest *obj))checkBlock withData:(NSData *)data response:(NSURLResponse *)response error:(NSError *)error testBlock:(void (^)())testBlock {
    __block void (^sessionBlock)(NSData *data, NSURLResponse *response, NSError *error) = nil;
    [[self expect] dataTaskWithRequest:[OCMArg checkWithBlock:^BOOL(id obj) {
                       return checkBlock(obj);
                   }]
                     completionHandler:[OCMArg checkWithBlock:^BOOL(id obj) {
                         sessionBlock = [obj copy];
                         return YES;
                     }]];
    testBlock();
    [self verify];
    sessionBlock(data, response, error);
}

- (void)stubRequestForURL:(NSURL *)url withData:(NSData *)data response:(NSURLResponse *)response error:(NSError *)error testBlock:(void (^)())testBlock {
    [self stubRequestWithCheck:^BOOL(NSURLRequest *obj) {
        return [obj.URL isEqual:url];
    } withData:data response:response
                         error:error
                     testBlock:testBlock];
}

- (void)stubRequest:(NSURLRequest *)request withData:(NSData *_Nullable)data response:(NSURLResponse *_Nullable)response error:(NSError *_Nullable)error testBlock:(void (^)())testBlock {
    [self stubRequestWithCheck:^BOOL(NSURLRequest *obj) {
        return [obj isEqual:request];
    } withData:data response:response
                         error:error
                     testBlock:testBlock];
}

- (void)stubDownloadWithCheck:(BOOL (^)(NSURLRequest *obj))checkBlock withData:(NSData *)data response:(NSURLResponse *)response error:(NSError *)error testBlock:(void (^)())testBlock {
    __block void (^sessionBlock)(NSURL *tempURL, NSURLResponse *response, NSError *error) = nil;
    [[self expect] downloadTaskWithRequest:[OCMArg checkWithBlock:^BOOL(id obj) {
                       return checkBlock(obj);
                   }]
                         completionHandler:[OCMArg checkWithBlock:^BOOL(id obj) {
                             sessionBlock = [obj copy];
                             return YES;
                         }]];
    testBlock();
    [self verify];
    NSString *tempFile = [NSTemporaryDirectory() stringByAppendingPathComponent:@"miq-testing-frameworks-temp"];
    NSURL *tempURL = [NSURL fileURLWithPath:tempFile];
    [data writeToURL:tempURL atomically:YES];
    sessionBlock(tempURL, response, error);
    [NSFileManager.defaultManager removeItemAtURL:tempURL error:nil];
}

- (void)stubDownloadRequest:(NSURLRequest *)request withData:(NSData *)data response:(NSURLResponse *)response error:(NSError *)error testBlock:(void (^)())testBlock {
    [self stubDownloadWithCheck:^BOOL(NSURLRequest *obj) {
        return [obj isEqual:request];
    } withData:data response:response
                          error:error
                      testBlock:testBlock];
}

- (void)stubDownloadForURL:(NSURL *)url withData:(NSData *)data response:(NSURLResponse *)response error:(NSError *)error testBlock:(void (^)())testBlock {
    [self stubDownloadWithCheck:^BOOL(NSURLRequest *obj) {
        return [obj.URL isEqual:url];
    } withData:data response:response
                          error:error
                      testBlock:testBlock];
}

@end
