//
//  XCTestCase+LoadViewController.m
//  OSMaps
//
//  Created by Dave Hardiman on 05/02/2015.
//  Copyright (c) 2015 David Hardiman. All rights reserved.
//

#import "XCTestCase+LoadViewController.h"
#import <UIKit/UIKit.h>

@implementation XCTestCase (LoadViewController)

- (id)loadViewControllerWithIdentifier:(NSString *)storyboardIdentifier inStoryboardWithName:(NSString *)storyboardName {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName ?: @"Main" bundle:nil];
    id viewController = [storyboard instantiateViewControllerWithIdentifier:storyboardIdentifier];
    [viewController view];
    return viewController;
}

@end
