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
    NSArray *suspectNames;
    NSArray *suspectOccupations;
    NSArray *suspectMaritalStatuses;
    NSArray *suspectPrivateQuestionLists;
    NSArray *suspectTypes;
    
    int victimNumber;
    int murdererNumber;
    
    weapon murderWeapon;

    location sceneOfTheCrime;
    location locationOf38;
    location locationOf45;
    location threeSuspectLocation;
    location murdererLocation;
    
    // Helper variables
    NSNumber *num0;
    NSNumber *num1;
    NSNumber *num2;
    NSNumber *num3;
    NSNumber *num4;
    NSNumber *num5;
    NSNumber *num6;
    NSNumber *num7;
    NSNumber *num8;
    NSNumber *num9;
    NSNumber *num10;
    NSNumber *num11;
    NSNumber *num12;
    NSNumber *num13;
    NSNumber *num14;
    
}

@property (nonatomic, strong) NSMutableDictionary *masterSuspectDirectory;
@property (nonatomic, strong) NSMutableDictionary *masterLocationDirectory;

+ (EDGameStateStore *) sharedStore;  // Class method

// Main Methods
- (void) createMasterSuspectDirectory;
- (void) createMasterLocationDirectory;
- (void) killVictim;
- (void) assignMurderer;
- (void) hideWeapons;
- (void) randomizeSuspectsInCity;
- (void) identify3SuspectLocation;
- (void) assignSideAreaToLocation;
- (void) assignAlibiTypesToSuspects;
- (NSString *) askPrivateQuestion: (privateQuestion)questionNumber
                        toSuspect: (int) suspectNumber;

// Helper Methods
- (NSString *)generateLocationString: (location)location;
- (NSString *)generateWeaponString: (weapon)weapon;
- (NSString *)generatePrivateQuestionString: (privateQuestion)question;

- (void) printLocationAssignedSuspects;
- (void) privateQuestionTestRoutine;
- (void) printMasterSuspectDirectory;


@end
