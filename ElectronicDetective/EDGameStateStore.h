//
//  EDGameStateStore.h
//  ElectronicDetective
//
//  Created by James Diener on 8/22/13.
//  Copyright (c) 2013 James Diener. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDTypedefEnums.h"

@class EDSuspect;

@interface EDGameStateStore : NSObject
{
    
    NSMutableDictionary *masterSuspectDirectory;
    NSMutableDictionary *masterLocationDirectory;
    
    NSArray *suspectNames;
    NSArray *suspectOccupations;
    NSArray *suspectMaritalStatuses;
    NSArray *suspectPrivateQuestionLists;
    NSArray *suspectTypes;
    
    int victimNumber;
    int murdererNumber;
    
    weapon murderWeapon;

    location murderLocation;
    location locationOf38;
    location locationOf45;
    
}

+ (EDGameStateStore *) sharedStore;  // Class method

- (void) createMasterSuspectDirectory;
- (void) createMasterLocationDirectory;
- (void) killVictim;
- (void) assignMurderer;
- (void) hideWeapons;
- (void) randomizeSuspectsInCity;
- (void) identify3SuspectLocation;

- (NSString *)generateLocationString: (location)location;
- (NSString *)generateWeaponString: (weapon)weapon;


@end
