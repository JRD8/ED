//
//  EDLocation.m
//  ElectronicDetective
//
//  Created by James Diener on 8/23/13.
//  Copyright (c) 2013 James Diener. All rights reserved.
//

#import "EDLocation.h"

@implementation EDLocation

@synthesize locationName, locationNumber, locationOf38, locationOf45, threeSuspectLocation, sceneOfTheCrime, locationSide, locationArea, assignedSuspects, alibiCombo, murdererLocation, initCompleted;

- (id) initWithInitialValues: (int) lnumber
                        name: (NSString *) lname
{
    self = [super init];
    
    [self setLocationNumber:lnumber];
    [self setLocationName:lname];
    
    [self setLocationSide:unassignedSide];
    [self setLocationArea:unassignedArea];
    [self setAlibiCombo:unassignedCombo];
    
    [self setLocationOf38:NO];
    [self setLocationOf45:NO];
    [self setSceneOfTheCrime:NO];
    [self setThreeSuspectLocation:NO];
    [self setMurdererLocation:NO];
    [self setInitCompleted:NO];
    
    assignedSuspects = nil; // ** Is this a good idea? **
    
    assignedSuspects = [[NSMutableArray alloc] init];
    
    return self;
};

- (NSString *)description
{
    return [NSString stringWithFormat:@"\r%@ \rAddress: %@ \rScene Of The Crime: %@ \rMurderer Location: %@ \rLocation Of .38: %@ \rLocation Of .45: %@ \r3-Suspect Location: %@\rAlibi Combo: %@\r", locationName, [self generateLocationAddressString:locationSide locationArea:locationArea], sceneOfTheCrime ? @"YES" : @"NO", murdererLocation ? @"YES" : @"NO", locationOf38 ? @"YES" : @"NO", locationOf45 ? @"YES" : @"NO", threeSuspectLocation ? @"YES" : @"NO", [self generateComboString:alibiCombo]];
};

- (NSString *)generateLocationAddressString: (side)side
                               locationArea: (area)area
{
    NSString *locationAddress;
    
    // Process side string
    switch (side)
    {
        case east:
            locationAddress = @"EAST ";
            break;
        case west:
            locationAddress = @"WEST ";
            break;
        default:
            break;
    };
    
    // Append with area string
    switch (area)
    {
        case uptown:
            locationAddress = [locationAddress stringByAppendingString:@"UPTOWN"];
            break;
        case midtown:
            locationAddress = [locationAddress stringByAppendingString:@"MIDTOWN"];
            break;
        case downtown:
            locationAddress = [locationAddress stringByAppendingString:@"DOWNTOWN"];
            break;
        default:
            break;
    }
    
    return locationAddress;
}

- (NSString *)generateComboString: (comboType)combo
{
    NSString *outputComboString;
    
    switch (combo)
    {
        case unassignedCombo:
            outputComboString = @"UNASSIGNED";
            break;
        case combo_12_8_7:
            outputComboString = @"12/8/7";
            break;
        case combo_12_8_6:
            outputComboString = @"12/8/6";
            break;
        case combo_1_1_5_4:
            outputComboString = @"1/1/5/4";
            break;
        case combo_5_11_2_6:
            outputComboString = @"5/11/2/6";
            break;
        case combo_4_8_10_11:
            outputComboString = @"4/8/10/11";
            break;
        case combo_1_1_6_9:
            outputComboString = @"1/1/6/9";
            break;
        case combo_2_10_1_3:
            outputComboString = @"2/10/1/3";
            break;
        default:
            break;
    }
    
    return outputComboString;
}


@end
