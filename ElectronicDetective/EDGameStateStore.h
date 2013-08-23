//
//  EDGameStateStore.h
//  ElectronicDetective
//
//  Created by James Diener on 8/22/13.
//  Copyright (c) 2013 James Diener. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EDSuspect;

@interface EDGameStateStore : NSObject
{
    
    NSMutableDictionary *masterSuspectDirectory;
    NSArray *suspectNames;
    NSArray *suspectOccupations;
    NSArray *suspectMaritalStatuses;
    NSArray *suspectPrivateQuestionLists;

}

+ (EDGameStateStore *) sharedStore;  // Class method

- (void) createMasterSuspectDirectory;

@end
