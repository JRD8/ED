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
    [self setThreeSuspectLocation:NO];
    [self setLocationSide:east];
    [self setLocationArea:uptown];
    [self setMurdererLocation:NO];
    [self setAlibiCombo:unassignedCombo];
    [self setInitCompleted:NO];
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
        case 0:
            locationAddress = @"0 - East ";
            break;
        case 1:
            locationAddress = @"1 - West ";
            break;
        default:
            break;
    };
    
    // Append with area string
    switch (area)
    {
        case 0:
            locationAddress = [locationAddress stringByAppendingString:@"Uptown - 0"];
            break;
        case 1:
            locationAddress = [locationAddress stringByAppendingString:@"Midtown - 1"];
            break;
        case 2:
            locationAddress = [locationAddress stringByAppendingString:@"Downtown - 2"];
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
        case 0:
            outputComboString = @"COMBO 0: UNASSIGNED";
            break;
        case 1:
            outputComboString = @"COMBO 1: 12/8/7";
            break;
        case 2:
            outputComboString = @"COMBO 2: 12/8/6";
            break;
        case 3:
            outputComboString = @"COMBO 3: 1/1/5/4";
            break;
        case 4:
            outputComboString = @"COMBO 4: 5/11/2/6";
            break;
        case 5:
            outputComboString = @"COMBO 5: 4/8/10/11";
            break;
        case 6:
            outputComboString = @"COMBO 6: 1/1/6/9";
            break;
        case 7:
            outputComboString = @"COMBO 7: 2/10/1/3";
            break;
        default:
            break;
    }
    
    return outputComboString;
}


@end
