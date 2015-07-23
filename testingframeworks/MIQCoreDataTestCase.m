//
//  MIQCoreDataTestBase.m
//
//  Created by David Hardiman on 21/01/2011.
//  Copyright 2011 Mobile IQ. All rights reserved.
//

#import "MIQCoreDataTestCase.h"

@implementation MIQCoreDataTestCase {
    NSPersistentStoreCoordinator *_coord;
    NSManagedObjectModel *_model;
}
@synthesize persistentStoreCoordinator = _coord;

- (void)setupCoreData {
    _model = [NSManagedObjectModel mergedModelFromBundles:self.modelBundles];
    _coord = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
    _store = [_coord addPersistentStoreWithType:NSInMemoryStoreType
                                  configuration:nil
                                            URL:nil
                                        options:nil
                                          error:nil];
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:_coord];
}

- (void)setUp {
    [super setUp];
    [self setupCoreData];
}

- (void)tearDown {
    _coord = nil;
    _managedObjectContext = nil;
    _model = nil;
    _store = nil;
    [super tearDown];
}

//- (void)testThatEnvironmentWorks {
//    expect(_model).toNot.beNil();
//    XCTAssertNotNil(self.managedObjectContext, @"managed object context not created");
//}

@end
