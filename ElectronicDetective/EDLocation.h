//
//  EDLocation.h
//  ElectronicDetective
//
//  Created by James Diener on 8/23/13.
//  Copyright (c) 2013 James Diener. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EDSuspect;

// Side
typedef enum
{
    east = 0,
    west = 1
    
} side;

// Area
typedef enum
{
    uptown = 0,
    midtown = 1,
    downtown = 2,
    
} area;

// Location
typedef enum
{
    art = 0,
    ballet = 1,
    cardParty = 2,
    docks = 3,
    embassy = 4,
    factory = 5,
    
} location;


@interface EDLocation : NSObject

@property (nonatomic) location *locationName;

@property (nonatomic) EDSuspect *oddMaleSuspect;
@property (nonatomic) EDSuspect *evenMaleSuspect;
@property (nonatomic) EDSuspect *oddFemaleSuspect;
@property (nonatomic) EDSuspect *evenFemaleSuspect;

@property (nonatomic) side *locationSide;
@property (nonatomic) area *locationArea;

@property (nonatomic) BOOL *locationOf38;
@property (nonatomic) BOOL *locationOf45;

@property (nonatomic) BOOL *threeSuspectLocation;

- (NSString *)description;

@end
