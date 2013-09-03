//
//  EDLocation.m
//  ElectronicDetective
//
//  Created by James Diener on 8/23/13.
//  Copyright (c) 2013 James Diener. All rights reserved.
//

#import "EDLocation.h"

@implementation EDLocation

@synthesize locationName, locationNumber, locationOf38, locationOf45, threeSuspectLocation, sceneOfTheCrime, locationSide, locationArea, assignedSuspects, murdererLocation,initCompleted;

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
    [self setInitCompleted:NO];
    assignedSuspects = [[NSMutableArray alloc] init];
    
    return self;
};

- (NSString *)description
{
    return [NSString stringWithFormat:@"\r%@ \rAddress: %@ \rScene Of The Crime: %@ \rMurderer Location: %@ \rLocation Of .38: %@ \rLocation Of .45: %@ \r3-Suspect Location: %@\r", locationName, [self generateLocationAddressString:locationSide locationArea:locationArea], sceneOfTheCrime ? @"YES" : @"NO", murdererLocation ? @"YES" : @"NO", locationOf38 ? @"YES" : @"NO", locationOf45 ? @"YES" : @"NO", threeSuspectLocation ? @"YES" : @"NO"];
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


@end
