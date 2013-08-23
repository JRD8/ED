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
    
    int victimNumber;
    int murdererNumber;
    int murderLocation;
    int murderWeapon;
    int locationOf38;
    int locationOf45;
    
}

+ (EDGameStateStore *) sharedStore;  // Class method

- (void) createMasterSuspectDirectory;
- (void) killVictim;
- (void) assignMurderer;
- (void) hideWeapons;
- (void) randomizeSuspectsInCity;

- (NSString *)generateLocationString: (int)location;

@end
