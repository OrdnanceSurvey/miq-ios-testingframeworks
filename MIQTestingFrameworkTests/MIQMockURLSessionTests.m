//
//  MIQMockURLSessionTests.m
//  MIQTestingFramework
//
//  Created by Dave Hardiman on 28/07/2015.
//

@import MIQTestingFramework;
#import "MIQMockURLSession.h"

@interface MIQTestFetcher : NSObject

@property (nonatomic, strong) NSURLSession *session;

- (instancetype)initWithSession:(NSURLSession *)session;

- (void)fetchRequest:(NSURLRequest *)request withCallback:(void (^)(NSData *data, NSURLResponse *response, NSError *error))callback;

- (void)downloadRequest:(NSURLRequest *)request withCallback:(void (^)(NSURL *url, NSURLResponse *response, NSError *error))callback;

@end

@interface MIQMockURLSessionTests : XCTestCase

@end

@implementation MIQMockURLSessionTests

- (void)testItIsPossibleToGetAMockURLSession {
    id mockSession = MIQMockURLSession.mockSession;
    expect(mockSession).notTo.beNil();
}

- (void)testItIsPossibleToStubAURLRequest {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://davidhardiman.me"]];
    NSData *expectedData = [@"test" dataUsingEncoding:NSUTF8StringEncoding];
    NSHTTPURLResponse *expectedResponse = [[NSHTTPURLResponse alloc] initWithURL:request.URL statusCode:200 HTTPVersion:@"HTTP/1.1" headerFields:nil];
    NSError *expectedError = [NSError errorWithDomain:@"me.davidhardiman" code:12 userInfo:nil];
    id mockSession = MIQMockURLSession.mockSession;
    [mockSession stubRequest:request withData:expectedData response:expectedResponse error:expectedError testBlock:^{
        MIQTestFetcher *fetcher = [[MIQTestFetcher alloc] initWithSession:mockSession];
        [fetcher fetchRequest:request withCallback:^(NSData *data, NSURLResponse *response, NSError *error) {
            expect(data).to.equal(expectedData);
            expect(response).to.equal(expectedResponse);
            expect(error).to.equal(expectedError);
        }];
    }];
}

- (void)testItIsPossibleToStubAURL {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://davidhardiman.me"]];
    NSData *expectedData = [@"test" dataUsingEncoding:NSUTF8StringEncoding];
    NSHTTPURLResponse *expectedResponse = [[NSHTTPURLResponse alloc] initWithURL:request.URL statusCode:200 HTTPVersion:@"HTTP/1.1" headerFields:nil];
    NSError *expectedError = [NSError errorWithDomain:@"me.davidhardiman" code:12 userInfo:nil];
    id mockSession = MIQMockURLSession.mockSession;
    [mockSession stubRequest:request withData:expectedData response:expectedResponse error:expectedError testBlock:^{
        MIQTestFetcher *fetcher = [[MIQTestFetcher alloc] initWithSession:mockSession];
        [fetcher fetchRequest:request withCallback:^(NSData *data, NSURLResponse *response, NSError *error) {
            expect(data).to.equal(expectedData);
            expect(response).to.equal(expectedResponse);
            expect(error).to.equal(expectedError);
        }];
    }];
}

- (void)testItIsPossibleToStubADownloadURLRequest {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://davidhardiman.me"]];
    NSData *expectedData = [@"test" dataUsingEncoding:NSUTF8StringEncoding];
    NSHTTPURLResponse *expectedResponse = [[NSHTTPURLResponse alloc] initWithURL:request.URL statusCode:200 HTTPVersion:@"HTTP/1.1" headerFields:nil];
    NSError *expectedError = [NSError errorWithDomain:@"me.davidhardiman" code:12 userInfo:nil];
    id mockSession = MIQMockURLSession.mockSession;
    [mockSession stubDownloadRequest:request withData:expectedData response:expectedResponse error:expectedError testBlock:^{
        MIQTestFetcher *fetcher = [[MIQTestFetcher alloc] initWithSession:mockSession];
        [fetcher downloadRequest:request withCallback:^(NSURL *tempURL, NSURLResponse *response, NSError *error) {
            NSString *string = [NSString stringWithContentsOfURL:tempURL encoding:NSUTF8StringEncoding error:nil];
            expect(string).to.equal(@"test");
            expect(response).to.equal(expectedResponse);
            expect(error).to.equal(expectedError);
        }];
    }];
}

@end

@implementation MIQTestFetcher

- (instancetype)initWithSession:(NSURLSession *)session {
    if ((self = [super init])) {
        _session = session;
    }
    return self;
}

- (void)fetchRequest:(NSURLRequest *)request withCallback:(void (^)(NSData *, NSURLResponse *, NSError *))callback {
    [[self.session dataTaskWithRequest:request completionHandler:callback] resume];
}

- (void)downloadRequest:(NSURLRequest *)request withCallback:(void (^)(NSURL *, NSURLResponse *, NSError *))callback {
    [[self.session downloadTaskWithRequest:request completionHandler:callback] resume];
}

@end
