//
//  EDSuspect.m
//  ElectronicDetective
//
//  Created by James Diener on 8/22/13.
//  Copyright (c) 2013 James Diener. All rights reserved.
//

#import "EDSuspect.h"

@implementation EDSuspect

@synthesize  suspectNumber, suspectType, suspectName, suspectOccupation, suspectMaritalStatus, suspectAlibi, suspectSide, suspectArea, suspectLocation, suspectPrivateQuestionList, victim, murderer;

- (id)initWithInitialValues:(int)sNumber suspectType:(type)sType name:(NSString *)sName occupation:(NSString *)sOccupation maritalStatus:(NSString *)sMaritalStatus privateQuestionList:(NSArray *)sQuestionList
{
    self = [super init];
    
    [self setSuspectNumber:sNumber];
    [self setSuspectType:sType];
    [self setSuspectName:sName];
    [self setSuspectOccupation:sOccupation];
    [self setSuspectMaritalStatus:sMaritalStatus];
    [self setSuspectArea:nil];
    [self setSuspectSide:nil];
    [self setSuspectLocation:nil];
    [self setSuspectPrivateQuestionList:sQuestionList];
    [self setVictim:NO];
    [self setMurderer:NO];
    
    return self;
};

- (NSString *)description
{
    NSString *privateQuestionForDescription = [NSString stringWithFormat:@"Questions: %@, %@, %@, %@ & %@", [suspectPrivateQuestionList objectAtIndex:0], [suspectPrivateQuestionList objectAtIndex:1], [suspectPrivateQuestionList objectAtIndex:2], [suspectPrivateQuestionList objectAtIndex:3], [suspectPrivateQuestionList objectAtIndex:4]];
    
    return [NSString stringWithFormat:@"Suspect Number: %d, Suspect Type = %d, Name = %@, Occupation = %@, Marital Status = %@, Private Question List = %@, Victim = %@, Murderer = %@", suspectNumber, suspectType, suspectName, suspectOccupation, suspectMaritalStatus, privateQuestionForDescription, victim ? @"YES" : @"NO", murderer ? @"YES" : @"NO"];
}

@end
