//
//  EDLocation.h
//  ElectronicDetective
//
//  Created by James Diener on 8/23/13.
//  Copyright (c) 2013 James Diener. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EDSuspect;

@interface EDLocation : NSObject

@property (nonatomic) NSString *locationName;
@property (nonatomic) int locationNumber;

@property (nonatomic) EDSuspect *oddMaleSuspect;
@property (nonatomic) EDSuspect *evenMaleSuspect;
@property (nonatomic) EDSuspect *oddFemaleSuspect;
@property (nonatomic) EDSuspect *evenFemaleSuspect;

// FIXME: Have to work on tyedefs
// @property (nonatomic) wide *locationSide;
// @property (nonatomic) area *locationArea;

@property (nonatomic) BOOL locationOf38;
@property (nonatomic) BOOL locationOf45;

@property (nonatomic) BOOL threeSuspectLocation;
@property (nonatomic) BOOL murderLocation;

- (id) initWithInitialValues: (int) lnumber
                        name: (NSString *) lname;

- (NSString *)description;

@end
