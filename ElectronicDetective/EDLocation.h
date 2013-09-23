//
//  EDLocation.h
//  ElectronicDetective
//
//  Created by James Diener on 8/23/13.
//  Copyright (c) 2013 James Diener. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDTypedefEnums.h"

@class EDSuspect;

@interface EDLocation : NSObject <NSCoding>

@property (nonatomic) NSString *locationName;
@property (nonatomic) location locationNumber;

@property (nonatomic) side locationSide;
@property (nonatomic) area locationArea;

@property (nonatomic) NSMutableArray *assignedSuspects;

@property (nonatomic) comboType alibiCombo;

@property (nonatomic) BOOL locationOf38;
@property (nonatomic) BOOL locationOf45;
@property (nonatomic) BOOL threeSuspectLocation;
@property (nonatomic) BOOL sceneOfTheCrime;
@property (nonatomic) BOOL murdererLocation;
@property (nonatomic) BOOL initCompleted;

- (id) initWithInitialValues: (int) lnumber
                        name: (NSString *) lname;

- (NSString *)description;
- (NSString *)generateLocationAddressString: (side)side
                               locationArea: (area)area;
- (NSString *)generateComboString: (comboType)combo;

@end
