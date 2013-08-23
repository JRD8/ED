//
//  EDSuspect.m
//  ElectronicDetective
//
//  Created by James Diener on 8/22/13.
//  Copyright (c) 2013 James Diener. All rights reserved.
//

#import "EDSuspect.h"

@implementation EDSuspect

@synthesize  suspectNumber, suspectName, suspectOccupation, suspectMaritalStatus, suspectAlibi, suspectSide, suspectArea, suspectLocation, suspectPrivateQuestionList, victim;

- (id)initWithInitialValues:(int)sNumber name:(NSString *)sName occupation:(NSString *)sOccupation maritalStatus:(NSString *)sMaritalStatus privateQuestionList:(NSArray *)sQuestionList victim:(BOOL)sVictim
{
    self = [super init];
    
    [self setSuspectNumber:sNumber];
    [self setSuspectName:sName];
    [self setSuspectOccupation:sOccupation];
    [self setSuspectMaritalStatus:sMaritalStatus];
    [self setSuspectArea:nil];
    [self setSuspectSide:nil];
    [self setSuspectLocation:nil];
    [self setSuspectPrivateQuestionList:nil];
    [self setVictim:NO];
    
    return self;
};

@end
