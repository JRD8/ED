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
    [self setAssignedAlibiType:unassignedAlibiType];
    [self setVictim:NO];
    [self setMurderer:NO];
    [self setAssignedYet:NO];
    
    return self;
};

- (NSString *)description
{
    NSString *privateQuestionForDescription = [NSString stringWithFormat:@"%@, %@, %@, %@ & %@", [suspectPrivateQuestionList objectAtIndex:0], [suspectPrivateQuestionList objectAtIndex:1], [suspectPrivateQuestionList objectAtIndex:2], [suspectPrivateQuestionList objectAtIndex:3], [suspectPrivateQuestionList objectAtIndex:4]];
    
    return [NSString stringWithFormat:@"\rSuspect #%d \rName: %@ \rOccupation: %@ \rMarital Status: %@ \rLocation: %@ \rSide: %d \rArea: %d \rPrivate Question List: %@ \rVictim: %@, Murderer: %@ \rAssigned Yet: %@ \rSuspectType: %@ \rAlibiType: %d \rAlibi: %@\r", suspectNumber, suspectName, suspectOccupation, suspectMaritalStatus, [self generateLocationString:suspectLocation], suspectSide, suspectArea, privateQuestionForDescription, victim ? @"YES" : @"NO", murderer ? @"YES" : @"NO", assignedYet ? @"YES" : @"NO", [self generateTypeString:suspectType], assignedAlibiType, suspectAlibi];
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

- (void)generateAlibiString: (int) accompanyingSuspect1
                   suspect2: (int) accompanyingSuspect2;
{
    NSString *insertString1, *insertString2, *outputAlibiString; // Setup helper variables
    
    switch (assignedAlibiType)
    {
        // UnassignedAlibiType    
        case 0: 
            outputAlibiString = @"EEEEE";
            break;
        
        // w/SuspectAndSuspect
        case 1:
            outputAlibiString = [NSString stringWithFormat:@"I was with %d and %d", accompanyingSuspect1, accompanyingSuspect2];
            break;
        
        // areaOnly
        case 2: 
            switch (suspectArea)
            {
                case 0:
                    insertString1 = @"UPTOWN";
                    break;
                case 1:
                    insertString1 = @"MIDTOWN";
                    break;
                case 2:
                    insertString1 = @"DOWNTOWN";
                    break;
                default:
                    break;
            }
            outputAlibiString = [NSString stringWithFormat:@"I was %@", insertString1];
            break;
        
        // sideOnly
        case 3: 
            switch (suspectSide)
            {
                case 0:
                    insertString1 = @"EAST";
                    break;
                case 1:
                    insertString1 = @"WEST";
                    break;
                default:
                    break;
            }
            outputAlibiString = [NSString stringWithFormat:@"I was %@", insertString1];
            break;
         
        // sideArea
        case 4: 
            // Process Side
            switch (suspectSide)
            {
                case 0:
                    insertString1 = @"EAST";
                    break;
                case 1:
                    insertString1 = @"WEST";
                    break;
                default:
                    break;
            }
            // Process Area
            switch (suspectArea)
            {
                case 0:
                    insertString2 = @"UPTOWN";
                    break;
                case 1:
                    insertString2 = @"MIDTOWN";
                    break;
                case 2:
                    insertString2 = @"DOWNTOWN";
                    break;
                default:
                    break;
            }
            outputAlibiString = [NSString stringWithFormat:@"I was %@ %@", insertString1, insertString2];
            break;
        
        // atLocation
        case 5: 
            switch (suspectLocation)
            {
                case 0:
                    insertString1 = @"A - ART SHOW";
                    break;
                case 1:
                    insertString1 = @"B - BOX AT THEATRE";
                    break;
                case 2:
                    insertString1 = @"C - CARD PARTY";
                    break;
                case 3:
                    insertString1 = @"D - DOCKS";
                    break;
                case 4:
                    insertString1 = @"E - EMBASSY";
                    break;
                case 5:
                    insertString1 = @"F - FACTORY";
                    break;
                default:
                    break;
            }
            outputAlibiString = [NSString stringWithFormat:@"I was at %@", insertString1];
            break;
        
        // areaWithSuspect
        case 6: 
            // Process Area
            switch (suspectArea)
             {
                 case 0:
                    insertString1 = @"UPTOWN";
                    break;
                 case 1:
                    insertString1 = @"MIDTOWN";
                    break;
                 case 2:
                    insertString1 = @"DOWNTOWN";
                    break;
                 default:
                    break;
            }
            outputAlibiString = [NSString stringWithFormat: @"I was %@ with %d", insertString1, accompanyingSuspect1];
            break;

        // sideWithSuspect
        case 7:
            // Process Side
            switch (suspectSide)
            {
                case 0:
                    insertString1 = @"EAST";
                    break;
                case 1:
                    insertString1 = @"WEST";
                    break;
                default:
                    break;
            }
            outputAlibiString = [NSString stringWithFormat: @"I was %@ with %d", insertString1, accompanyingSuspect1];;
            break;
        
        // areaAtLocation
        case 8: 
             // Process Area
             switch (suspectArea)
             {
                case 0:
                    insertString1 = @"UPTOWN";
                    break;
                case 1:
                    insertString1 = @"MIDTOWN";
                    break;
                case 2:
                    insertString1 = @"DOWNTOWN";
                    break;
                default:
                    break;
             }
             // Process Location
             switch (suspectLocation)
             {
                case 0:
                    insertString2 = @"A - ART SHOW";
                    break;
                case 1:
                    insertString2 = @"B - BOX AT THEATRE";
                    break;
                case 2:
                    insertString2 = @"C - CARD PARTY";
                    break;
                case 3:
                    insertString2 = @"D - DOCKS";
                    break;
                case 4:
                    insertString2 = @"E - EMBASSY";
                    break;
                case 5:
                    insertString2 = @"F - FACTORY";
                    break;
                default:
                    break;
             }
             outputAlibiString = [NSString stringWithFormat:@"I was %@ at %@", insertString1, insertString2];
             break;
        
        // sideAtLocation
        case 9: 
             // Process Side
             switch (suspectSide)
             {
                case 0:
                    insertString1 = @"EAST";
                    break;
                case 1:
                    insertString1 = @"WEST";
                    break;
                default:
                    break;
             }
            // Process Location
            switch (suspectLocation)
            {
                case 0:
                    insertString2 = @"A - ART SHOW";
                    break;
                case 1:
                    insertString2 = @"B - BOX AT THEATRE";
                    break;
                case 2:
                    insertString2 = @"C - CARD PARTY";
                    break;
                case 3:
                    insertString2 = @"D - DOCKS";
                    break;
                case 4:
                    insertString2 = @"E - EMBASSY";
                    break;
                case 5:
                    insertString2 = @"F - FACTORY";
                    break;
                default:
                    break;
            }
            outputAlibiString = [NSString stringWithFormat:@"I was %@ at %@", insertString1, insertString2];
            break;
        
        // atLocationWithSuspect
        case 10:
            // Process Location
            switch (suspectLocation)
            {
                case 0:
                    insertString1 = @"A - ART SHOW";
                    break;
                case 1:
                    insertString1 = @"B - BOX AT THEATRE";
                    break;
                case 2:
                    insertString1 = @"C - CARD PARTY";
                    break;
                case 3:
                    insertString1 = @"D - DOCKS";
                    break;
                case 4:
                    insertString1 = @"E - EMBASSY";
                    break;
                case 5:
                    insertString1 = @"F - FACTORY";
                    break;
                default:
                    break;
            }
            outputAlibiString = [NSString stringWithFormat:@"I was %@ with %d", insertString1, accompanyingSuspect1];
            break;
        
        // sideWithSuspectAndSuspect
        case 11:
            // Process Side
            switch (suspectSide)
            {
                case 0:
                    insertString1 = @"EAST";
                    break;
                case 1:
                    insertString1 = @"WEST";
                    break;
                default:
                    break;
            }
            outputAlibiString = [NSString stringWithFormat:@"I was %@ with %d and %d", insertString1, accompanyingSuspect1, accompanyingSuspect2];
            break;
        
        // sideAreaWithSuspect
        case 12:
            // Process Side
            switch (suspectSide)
            {
                case 0:
                    insertString1 = @"EAST";
                    break;
                case 1:
                    insertString1 = @"WEST";
                    break;
                default:
                    break;
            }
            // Process Area
            switch (suspectArea)
            {
                case 0:
                    insertString2 = @"UPTOWN";
                    break;
                case 1:
                    insertString2 = @"MIDTOWN";
                    break;
                case 2:
                    insertString2 = @"DOWNTOWN";
                    break;
                default:
                    break;
            }
            outputAlibiString = [NSString stringWithFormat:@"I was %@, %@ with %d", insertString1, insertString2, accompanyingSuspect1];
            break;

        default:
            break;
        
    };
    
    [self setSuspectAlibi:outputAlibiString];  // Set the output string variable in the suspect object

}

@end
