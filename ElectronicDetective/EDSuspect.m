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
    
    return [NSString stringWithFormat:@"Suspect #%d, Name: %@, Occupation: %@, Marital Status: %@, Location: %@, Side: %d, Area: %d, Private Question List: %@, AlibiType: %d, Victim: %@, Murderer: %@, Assigned Yet: %@, SuspectType: %@\r", suspectNumber, suspectName, suspectOccupation, suspectMaritalStatus, [self generateLocationString:suspectLocation], suspectSide, suspectArea, privateQuestionForDescription, assignedAlibiType, victim ? @"YES" : @"NO", murderer ? @"YES" : @"NO", assignedYet ? @"YES" : @"NO", [self generateTypeString:suspectType]];
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

// TODO: Finish Method
- (NSString *)generateAlibiString
{
    NSString *outputAlibiString;
    NSString *insertString1, *insertString2;
    
    switch (assignedAlibiType)
    {
        case 0: // Unassigned
            outputAlibiString = @"UNASSIGNED";
            break;
            
        /*case 1: // w/SuspectAndSuspect
            outputAlibiString = @"UNASSIGNED";
            break; */
            
        case 2: // areaOnly
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
        
        case 3: // sideOnly
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
            
        case 4: // sideArea
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
            outputAlibiString = [NSString stringWithFormat:@"I was %@, %@", insertString1, insertString2];
            break;
            
        case 5: // atLocation
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
            
        /*case 6: // areaWithSuspect
         outputAlibiString = @"UNASSIGNED";
         break; */
        
        /*case 7: // sideWithSuspect
         outputAlibiString = @"UNASSIGNED";
         break; */
        
        /*case 8: // areaAtLocation
         outputAlibiString = @"UNASSIGNED";
         break; */
        
        /*case 9: // sideAtLocation
         outputAlibiString = @"UNASSIGNED";
         break; */
        
        /*case 10: // atLocationWithSuspect
         outputAlibiString = @"UNASSIGNED";
         break; */
        
        /*case 11: // sideWithSuspectAndSuspect
         outputAlibiString = @"UNASSIGNED";
         break; */
        
        /*case 12: // sideAreaWithSuspect
         outputAlibiString = @"UNASSIGNED";
         break; */

        default:
            break;
        
    };
    
    NSLog(@"OUTPUT ALIBI STRING: %@", outputAlibiString);
    
    return outputAlibiString;
}

@end
