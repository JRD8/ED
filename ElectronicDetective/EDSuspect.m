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
    
    [self setSuspectLocation:unassignedLocation];
    [self setSuspectSide:unassignedSide];
    [self setSuspectArea:unassignedArea];
    [self setAssignedAlibiType:unassignedAlibiType];
    [self setSuspectAlibi:nil];
    
    [self setVictim:NO];
    [self setMurderer:NO];
    [self setAssignedYet:NO];
    
    return self;
};

- (NSString *)description
{
    NSString *privateQuestionForDescription = [NSString stringWithFormat:@"%@, %@, %@, %@ & %@", [suspectPrivateQuestionList objectAtIndex:0], [suspectPrivateQuestionList objectAtIndex:1], [suspectPrivateQuestionList objectAtIndex:2], [suspectPrivateQuestionList objectAtIndex:3], [suspectPrivateQuestionList objectAtIndex:4]];
    
    return [NSString stringWithFormat:@"\rSuspect #%d \rName: %@ \rOccupation: %@ \rMarital Status: %@ \rLocation: %@ \rSide: %@ \rArea: %@ \rPrivate Question List: %@ \rVictim: %@, Murderer: %@ \rAssigned Yet: %@ \rSuspectType: %@ \rAlibiType: %@ \rAlibi: %@\r", suspectNumber, suspectName, suspectOccupation, suspectMaritalStatus, [self generateLocationString:suspectLocation], [self generateSideString:suspectSide], [self generateAreaString:suspectArea], privateQuestionForDescription, victim ? @"YES" : @"NO", murderer ? @"YES" : @"NO", assignedYet ? @"YES" : @"NO", [self generateTypeString:suspectType], [self generateAlibiTypeString:assignedAlibiType], suspectAlibi];
}

#pragma mark - Generate String Methods

- (NSString *)generateTypeString: (type) type
{
    NSString *outputTypeString;
    
    switch (type)
    {
        case oddMale:
            outputTypeString = @"ODD MALE";
            break;
        case evenMale:
            outputTypeString = @"EVEN MALE";
            break;
        case oddFemale:
            outputTypeString = @"ODD FEMALE";
            break;
        case evenFemale:
            outputTypeString = @"EVEN FEMALE";
            break;
        case unassignedType:
            outputTypeString = @"UNASSIGNED";
            break;
        default:
            break;
    }
    
    return outputTypeString;
}

- (NSString *)generateLocationString: (location)location
{
    NSString *outputLocationString;
    
    switch (location)
    {
        case artShow:
            outputLocationString = @"ART SHOW";
            break;
        case boxAtTheatre:
            outputLocationString = @"BOX AT THEATRE";
            break;
        case cardParty:
            outputLocationString = @"CARD PARTY";
            break;
        case docks:
            outputLocationString = @"DOCKS";
            break;
        case embassy:
            outputLocationString = @"EMBASSY";
            break;
        case factory:
            outputLocationString = @"FACTORY";
            break;
        case morgue:
            outputLocationString = @"MORGUE (VICTIM)";
            break;
        case unassignedLocation:
            outputLocationString = @"UNASSIGNED";
            break;
        default:
            break;
    };
    
    return outputLocationString;
}

- (NSString *)generateSideString: (side)side
{
    NSString *outputSideString;
    
    switch (side)
    {
        case east:
            outputSideString = @"EAST";
            break;
        case west:
            outputSideString = @"WEST";
            break;
        case unassignedSide:
            outputSideString = @"UNASSIGNED";
            break;
        default:
            break;
    }
    
    return outputSideString;

}

- (NSString *)generateAlibiTypeString: (alibiType)alibiType
{
    
    NSString *outputAlibiTypeString;
    
    switch (alibiType)
    {
        case withSuspectAndSuspect:
            outputAlibiTypeString = @"1 - with SUSPECT and SUSPECT";
            break;
        case areaOnly:
            outputAlibiTypeString = @"2 - AREA";
            break;
        case sideOnly:
            outputAlibiTypeString = @"3 - SIDE";
            break;
        case sideArea:
            outputAlibiTypeString = @"4 - SIDE AREA";
            break;
        case atLocation:
            outputAlibiTypeString = @"5 - at LOCATION";
            break;
        case areaWithSuspect:
            outputAlibiTypeString = @"6 - AREA with SUSPECT";
            break;
        case sideWithSuspect:
            outputAlibiTypeString = @"7 - SIDE with SUSPECT";
            break;
        case areaAtLocation:
            outputAlibiTypeString = @"8 - AREA at LOCATION";
            break;
        case sideAtLocation:
            outputAlibiTypeString = @"9 - SIDE at LOCATION";
            break;
        case atLocationWithSuspect:
            outputAlibiTypeString = @"10 - at LOCATION with SUSPECT";
            break;
        case sideWithSuspectAndSuspect:
            outputAlibiTypeString = @"11 - SIDE with SUSPECT and SUSPECT";
            break;
        case sideAreaWithSuspect:
            outputAlibiTypeString = @"12 - SIDE AREA with SUSPECT";
            break;
        case unassignedAlibiType:
            outputAlibiTypeString = @"UNASSIGNED";
            break;
        
        default:
            break;
    }
    
    return outputAlibiTypeString;
}

- (NSString *)generateAreaString: (area)area
{
    NSString *outputAreaString;
    
    switch (area)
    {
        case uptown:
            outputAreaString = @"UPTOWN";
            break;
        case midtown:
            outputAreaString = @"MIDTOWN";
            break;
        case downtown:
            outputAreaString = @"DOWNTOWN";
            break;
        case unassignedArea:
            outputAreaString = @"UNASSIGNED";
            break;
        default:
            break;
    }
    
    return outputAreaString;
}

- (void)generateAlibiStringWithSuspect1: (int) accompanyingSuspect1
                               Suspect2: (int) accompanyingSuspect2;
{
    NSString *insertString1, *insertString2, *outputAlibiString; // Setup helper variables
    
    switch (assignedAlibiType)
    {
        // UnassignedAlibiType    
        case unassignedAlibiType:
            outputAlibiString = @"EEEEE";
            break;
        
        // w/SuspectAndSuspect
        case withSuspectAndSuspect:
            outputAlibiString = [NSString stringWithFormat:@"I was with #%d and #%d", accompanyingSuspect1, accompanyingSuspect2];
            break;
        
        // areaOnly
        case areaOnly:
            switch (suspectArea)
            {
                case uptown:
                    insertString1 = @"UPTOWN";
                    break;
                case midtown:
                    insertString1 = @"MIDTOWN";
                    break;
                case downtown:
                    insertString1 = @"DOWNTOWN";
                    break;
                default:
                    break;
            }
            outputAlibiString = [NSString stringWithFormat:@"I was %@", insertString1];
            break;
        
        // sideOnly
        case sideOnly:
            switch (suspectSide)
            {
                case east:
                    insertString1 = @"EAST";
                    break;
                case west:
                    insertString1 = @"WEST";
                    break;
                default:
                    break;
            }
            outputAlibiString = [NSString stringWithFormat:@"I was %@", insertString1];
            break;
         
        // sideArea
        case sideArea:
            // Process Side
            switch (suspectSide)
            {
                case east:
                    insertString1 = @"EAST";
                    break;
                case west:
                    insertString1 = @"WEST";
                    break;
                default:
                    break;
            }
            // Process Area
            switch (suspectArea)
            {
                case uptown:
                    insertString2 = @"UPTOWN";
                    break;
                case midtown:
                    insertString2 = @"MIDTOWN";
                    break;
                case downtown:
                    insertString2 = @"DOWNTOWN";
                    break;
                default:
                    break;
            }
            outputAlibiString = [NSString stringWithFormat:@"I was %@ %@", insertString1, insertString2];
            break;
        
        // atLocation
        case atLocation:
            switch (suspectLocation)
            {
                case artShow:
                    insertString1 = @"ART SHOW";
                    break;
                case boxAtTheatre:
                    insertString1 = @"BOX AT THEATRE";
                    break;
                case cardParty:
                    insertString1 = @"CARD PARTY";
                    break;
                case docks:
                    insertString1 = @"DOCKS";
                    break;
                case embassy:
                    insertString1 = @"EMBASSY";
                    break;
                case factory:
                    insertString1 = @"FACTORY";
                    break;
                default:
                    break;
            }
            outputAlibiString = [NSString stringWithFormat:@"I was at %@", insertString1];
            break;
        
        // areaWithSuspect
        case areaWithSuspect:
            // Process Area
            switch (suspectArea)
             {
                 case uptown:
                    insertString1 = @"UPTOWN";
                    break;
                 case midtown:
                    insertString1 = @"MIDTOWN";
                    break;
                 case downtown:
                    insertString1 = @"DOWNTOWN";
                    break;
                 default:
                    break;
            }
            outputAlibiString = [NSString stringWithFormat: @"I was %@ with #%d", insertString1, accompanyingSuspect1];
            break;

        // sideWithSuspect
        case sideWithSuspect:
            // Process Side
            switch (suspectSide)
            {
                case east:
                    insertString1 = @"EAST";
                    break;
                case west:
                    insertString1 = @"WEST";
                    break;
                default:
                    break;
            }
            outputAlibiString = [NSString stringWithFormat: @"I was %@ with #%d", insertString1, accompanyingSuspect1];;
            break;
        
        // areaAtLocation
        case areaAtLocation:
             // Process Area
             switch (suspectArea)
             {
                case uptown:
                    insertString1 = @"UPTOWN";
                    break;
                case midtown:
                    insertString1 = @"MIDTOWN";
                    break;
                case downtown:
                    insertString1 = @"DOWNTOWN";
                    break;
                default:
                    break;
             }
             // Process Location
             switch (suspectLocation)
             {
                case artShow:
                    insertString2 = @"ART SHOW";
                    break;
                case boxAtTheatre:
                    insertString2 = @"BOX AT THEATRE";
                    break;
                case cardParty:
                    insertString2 = @"CARD PARTY";
                    break;
                case docks:
                    insertString2 = @"DOCKS";
                    break;
                case embassy:
                    insertString2 = @"EMBASSY";
                    break;
                case factory:
                    insertString2 = @"FACTORY";
                    break;
                default:
                    break;
             }
             outputAlibiString = [NSString stringWithFormat:@"I was %@ at %@", insertString1, insertString2];
             break;
        
        // sideAtLocation
        case sideAtLocation:
             // Process Side
             switch (suspectSide)
             {
                case east:
                    insertString1 = @"EAST";
                    break;
                case west:
                    insertString1 = @"WEST";
                    break;
                default:
                    break;
             }
            // Process Location
            switch (suspectLocation)
            {
                case artShow:
                    insertString2 = @"ART SHOW";
                    break;
                case boxAtTheatre:
                    insertString2 = @"BOX AT THEATRE";
                    break;
                case cardParty:
                    insertString2 = @"CARD PARTY";
                    break;
                case docks:
                    insertString2 = @"DOCKS";
                    break;
                case embassy:
                    insertString2 = @"EMBASSY";
                    break;
                case factory:
                    insertString2 = @"FACTORY";
                    break;
                default:
                    break;
            }
            outputAlibiString = [NSString stringWithFormat:@"I was %@ at %@", insertString1, insertString2];
            break;
        
        // atLocationWithSuspect
        case atLocationWithSuspect:
            // Process Location
            switch (suspectLocation)
            {
                case artShow:
                    insertString1 = @"ART SHOW";
                    break;
                case boxAtTheatre:
                    insertString1 = @"BOX AT THEATRE";
                    break;
                case cardParty:
                    insertString1 = @"CARD PARTY";
                    break;
                case docks:
                    insertString1 = @"DOCKS";
                    break;
                case embassy:
                    insertString1 = @"EMBASSY";
                    break;
                case factory:
                    insertString1 = @"FACTORY";
                    break;
                default:
                    break;
            }
            outputAlibiString = [NSString stringWithFormat:@"I was at %@ with #%d", insertString1, accompanyingSuspect1];
            break;
        
        // sideWithSuspectAndSuspect
        case sideWithSuspectAndSuspect:
            // Process Side
            switch (suspectSide)
            {
                case east:
                    insertString1 = @"EAST";
                    break;
                case west:
                    insertString1 = @"WEST";
                    break;
                default:
                    break;
            }
            outputAlibiString = [NSString stringWithFormat:@"I was %@ with #%d and #%d", insertString1, accompanyingSuspect1, accompanyingSuspect2];
            break;
        
        // sideAreaWithSuspect
        case sideAreaWithSuspect:
            // Process Side
            switch (suspectSide)
            {
                case east:
                    insertString1 = @"EAST";
                    break;
                case west:
                    insertString1 = @"WEST";
                    break;
                default:
                    break;
            }
            // Process Area
            switch (suspectArea)
            {
                case uptown:
                    insertString2 = @"UPTOWN";
                    break;
                case midtown:
                    insertString2 = @"MIDTOWN";
                    break;
                case downtown:
                    insertString2 = @"DOWNTOWN";
                    break;
                default:
                    break;
            }
            outputAlibiString = [NSString stringWithFormat:@"I was %@ %@ with #%d", insertString1, insertString2, accompanyingSuspect1];
            break;

        default:
            break;
        
    };
    
    [self setSuspectAlibi:outputAlibiString];  // Set the output string variable in the suspect object

}

#pragma mark - NSCoding Protocol Methods

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:suspectNumber forKey:@"suspectNumber"];
    [aCoder encodeInt:suspectType forKey:@"suspectType"];
    
    [aCoder encodeObject:suspectName forKey:@"suspectName"];
    [aCoder encodeObject:suspectOccupation forKey:@"suspectOccupation"];
    [aCoder encodeObject:suspectMaritalStatus forKey:@"suspectMaritalStatus"];
    [aCoder encodeObject:suspectPrivateQuestionList forKey:@"suspectPrivateQuestionList"];
    
    [aCoder encodeInt:suspectLocation forKey:@"suspectLocation"];
    [aCoder encodeInt:suspectSide forKey:@"suspectSide"];
    [aCoder encodeInt:suspectArea forKey:@"suspectArea"];
    [aCoder encodeInt:assignedAlibiType forKey:@"assignedAlibiType"];
    
    [aCoder encodeObject:suspectAlibi forKey:@"suspectAlibi"];
    
    [aCoder encodeBool:victim forKey:@"victim"];
    [aCoder encodeBool:murderer forKey:@"murderer"];
    [aCoder encodeBool:assignedYet forKey:@"assignedYet"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self)
    {
        [self setSuspectNumber:[aDecoder decodeIntForKey:@"suspectNumber"]];
        [self setSuspectType:[aDecoder decodeIntForKey:@"suspectType"]];
        
        [self setSuspectName:[aDecoder decodeObjectForKey:@"suspectName"]];
        [self setSuspectOccupation:[aDecoder decodeObjectForKey:@"suspectOccupation"]];
        [self setSuspectMaritalStatus:[aDecoder decodeObjectForKey:@"suspectMaritalStatus"]];
        [self setSuspectPrivateQuestionList:[aDecoder decodeObjectForKey:@"suspectPrivateQuestionList"]];
        
        [self setSuspectLocation:[aDecoder decodeIntForKey:@"suspectLocation"]];
        [self setSuspectSide:[aDecoder decodeIntForKey:@"suspectSide"]];
        [self setSuspectArea:[aDecoder decodeIntForKey:@"suspectArea"]];
        [self setAssignedAlibiType:[aDecoder decodeIntForKey:@"asssignedAlibiType"]];
        
        [self setSuspectAlibi:[aDecoder decodeObjectForKey:@"suspectAlibi"]];
        
        [self setVictim:[aDecoder decodeBoolForKey:@"victim"]];
        [self setMurderer:[aDecoder decodeBoolForKey:@"murderer"]];
        [self setAssignedYet:[aDecoder decodeBoolForKey:@"assignedYet"]];
    }
    
    return self;
}

@end
