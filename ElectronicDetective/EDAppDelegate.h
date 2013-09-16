//
//  EDAppDelegate.h
//  ElectronicDetective
//
//  Created by James Diener on 8/22/13.
//  Copyright (c) 2013 James Diener. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EDViewController;

@interface EDAppDelegate : UIResponder <UIApplicationDelegate>
{
       NSUserDefaults *defaults;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) EDViewController *viewController;

- (void) redirectConsoleLogToDocumentFolder;

@end
