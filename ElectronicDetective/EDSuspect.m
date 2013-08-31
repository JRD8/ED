//
//  EDSuspect.m
//  ElectronicDetective
//
//  Created by James Diener on 8/22/13.
//  Copyright (c) 2013 James Diener. All rights reserved.
//

#import "EDSuspect.h"

@implementation EDSuspect

@synthesize  suspectNumber, suspectType, suspectName, suspectOccupation, suspectMaritalStatus, suspectAlibi, suspectPrivateQuestionList, suspectLocation, suspectSide, suspectArea, assignedAlibiType, victim, murderer, assignedYet;

- (id)initWithInitialValues:(int)sNumber suspectType:(type)sType name:(NSString *)sName occupation:(NSString *)sOccupation maritalStatus:(NSString *)sMaritalStatus privateQuestionList:(NSArray *)sQuestionList
{
    self = [super init];
    
    [self setSuspectNumber:sNumber];
    [self setSuspectType:sType];
    [self setSuspectName:sName];
    [self setSuspectOccupation:sOccupation];
    [self setSuspectMaritalStatus:sMaritalStatus];
    [self setSuspectPrivateQuestionList:sQuestionList];
    [self setAssignedAlibiType:unassigned];
    [self setVictim:NO];
    [self setMurderer:NO];
    [self setAssignedYet:NO];
    
    return self;
};

- (NSString *)description
{
    NSString *privateQuestionForDescription = [NSString stringWithFormat:@"%@, %@, %@, %@ & %@", [suspectPrivateQuestionList objectAtIndex:0], [suspectPrivateQuestionList objectAtIndex:1], [suspectPrivateQuestionList objectAtIndex:2], [suspectPrivateQuestionList objectAtIndex:3], [suspectPrivateQuestionList objectAtIndex:4]];
    
    return [NSString stringWithFormat:@"Suspect #%d, Name: %@, Occupation: %@, Marital Status: %@, Location: %@, Private Question List: %@, AlibiType: %d, Victim: %@, Murderer: %@, Assigned Yet: %@, SuspectType: %@\r", suspectNumber, suspectName, suspectOccupation, suspectMaritalStatus, [self generateLocationString:suspectLocation], privateQuestionForDescription, assignedAlibiType, victim ? @"YES" : @"NO", murderer ? @"YES" : @"NO", assignedYet ? @"YES" : @"NO", [self generateTypeString:suspectType]];
}

- (NSString *)generateTypeString: (type) type
{
    NSString *suspectTypeString;
    
    switch (type)
    {
        case 0:
            suspectTypeString = @"0 - Odd Male";
            break;
        case 1:
            suspectTypeString = @"1 - Even Male";
            break;
        case 2:
            suspectTypeString = @"2 - Odd Female";
            break;
        case 3:
            suspectTypeString = @"3 - Even Female";
            break;
        default:
            break;
    }
    
    return suspectTypeString;
}

- (NSString *)generateLocationString: (location)location
{
    NSString *outputLocationString;
    
    switch (location)
    {
        case 0:
            outputLocationString = @"0 - Art Show";
            break;
        case 1:
            outputLocationString = @"1 - Box At Theatre";
            break;
        case 2:
            outputLocationString = @"2 - Card Party";
            break;
        case 3:
            outputLocationString = @"3 - Docks";
            break;
        case 4:
            outputLocationString = @"4 - Embassy";
            break;
        case 5:
            outputLocationString = @"5 - Factory";
            break;
        case 6:
            outputLocationString = @"6 - Morgue (VICTIM)";
            break;
        default:
            break;
    };
    
    return outputLocationString;
}

// TODO: generate AlibiString
/* - (NSString *)generateAlibiString: (alibiType) alibiType
{
    
}*/

@end
