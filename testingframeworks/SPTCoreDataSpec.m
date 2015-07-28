//
//  SPTCoreDataSpec.m
//  MIQTestingFramework
//
//  Created by Dave Hardiman on 03/03/2015.
//  Copyright (c) 2015 David Hardiman. All rights reserved.
//

#import "SPTCoreDataSpec.h"

@implementation SPTCoreDataSpec

- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        self.store = [self.persistentStoreCoordinator addPersistentStoreWithType:NSInMemoryStoreType
                                                                   configuration:nil
                                                                             URL:nil
                                                                         options:nil
                                                                           error:nil];
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    }
    return _managedObjectContext;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (!_persistentStoreCoordinator) {
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.model];
    }
    return _persistentStoreCoordinator;
}

- (NSManagedObjectModel *)model {
    if (!_model) {
        _model = [NSManagedObjectModel mergedModelFromBundles:self.modelBundles];
    }
    return _model;
}

@end
