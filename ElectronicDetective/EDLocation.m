//
//  EDLocation.m
//  ElectronicDetective
//
//  Created by James Diener on 8/23/13.
//  Copyright (c) 2013 James Diener. All rights reserved.
//

#import "EDLocation.h"

@implementation EDLocation

@synthesize locationName, locationNumber, locationOf38, locationOf45, threeSuspectLocation, murderLocation, locationSide, locationArea, assignedSuspects;

- (id) initWithInitialValues: (int) lnumber
                        name: (NSString *) lname
{
    self = [super init];
    
    [self setLocationNumber:lnumber];
    [self setLocationName:lname];
    [self setThreeSuspectLocation:NO];
    [self setLocationSide:east];
    [self setLocationArea:uptown];
    assignedSuspects = [[NSMutableArray alloc] init];
    
    return self;
};

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@, Side = %d, Area = %d, Murder Location = %@, Location Of .38 = %@, Location Of .45 = %@, 3-Suspect Location = %@",locationName, locationSide, locationArea, murderLocation ? @"YES" : @"NO", locationOf38 ? @"YES" : @"NO", locationOf45 ? @"YES" : @"NO", threeSuspectLocation ? @"YES" : @"NO"];
};

@end
