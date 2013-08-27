//
//  EDSuspect.m
//  ElectronicDetective
//
//  Created by James Diener on 8/22/13.
//  Copyright (c) 2013 James Diener. All rights reserved.
//

#import "EDSuspect.h"

@implementation EDSuspect

@synthesize  suspectNumber, suspectType, suspectName, suspectOccupation, suspectMaritalStatus, suspectAlibi, suspectSide, suspectArea, suspectLocation, suspectPrivateQuestionList, victim, murderer, assignedYet;

- (id)initWithInitialValues:(int)sNumber suspectType:(type)sType name:(NSString *)sName occupation:(NSString *)sOccupation maritalStatus:(NSString *)sMaritalStatus privateQuestionList:(NSArray *)sQuestionList
{
    self = [super init];
    
    [self setSuspectNumber:sNumber];
    [self setSuspectType:sType];
    [self setSuspectName:sName];
    [self setSuspectOccupation:sOccupation];
    [self setSuspectMaritalStatus:sMaritalStatus];
    // [self setSuspectArea:nil];
    // [self setSuspectSide:nil];
    // [self setSuspectLocation:nil];
    [self setSuspectPrivateQuestionList:sQuestionList];
    [self setVictim:NO];
    [self setMurderer:NO];
    [self setAssignedYet:NO];
    
    return self;
};

- (NSString *)description
{
    NSString *privateQuestionForDescription = [NSString stringWithFormat:@"Questions: %@, %@, %@, %@ & %@", [suspectPrivateQuestionList objectAtIndex:0], [suspectPrivateQuestionList objectAtIndex:1], [suspectPrivateQuestionList objectAtIndex:2], [suspectPrivateQuestionList objectAtIndex:3], [suspectPrivateQuestionList objectAtIndex:4]];
    
    return [NSString stringWithFormat:@"Suspect #%d, Name = %@, Occupation = %@, Marital Status = %@, Location = %d, Private Question List = %@, Victim = %@, Murderer = %@, Assigned Yet = %@, Type = %@\r", suspectNumber, suspectName, suspectOccupation, suspectMaritalStatus, suspectLocation, privateQuestionForDescription, victim ? @"YES" : @"NO", murderer ? @"YES" : @"NO", assignedYet ? @"YES" : @"NO", [self generateTypeString:suspectType]];
}

- (NSString *)generateTypeString: (type) type
{
    NSString *suspectTypeString;
    
    switch (type)
    {
        case 0:
            suspectTypeString = @"0: Odd Male";
            break;
        case 1:
            suspectTypeString = @"1: Even Male";
            break;
        case 2:
            suspectTypeString = @"2: Odd Female";
            break;
        case 3:
            suspectTypeString = @"3: Even Female";
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
            outputLocationString = @"Art Show";
            break;
        case 1:
            outputLocationString = @"Box At Theatre";
            break;
        case 2:
            outputLocationString = @"Card Party";
            break;
        case 3:
            outputLocationString = @"Docks";
            break;
        case 4:
            outputLocationString = @"Embassy";
            break;
        case 5:
            outputLocationString = @"Factory";
            break;
        default:
            break;
    };
}

@end
