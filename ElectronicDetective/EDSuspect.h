//
//  EDSuspect.h
//  ElectronicDetective
//
//  Created by James Diener on 8/22/13.
//  Copyright (c) 2013 James Diener. All rights reserved.
//

#import <Foundation/Foundation.h>

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


@interface EDSuspect : NSObject
{
    
}

@property (nonatomic) int suspectNumber;
@property (nonatomic) NSString *suspectName;
@property (nonatomic) NSString *suspectOccupation;
@property (nonatomic) NSString *suspectMaritalStatus;
@property (nonatomic) NSString *suspectAlibi;
@property (nonatomic) area *suspectArea;
@property (nonatomic) side *suspectSide;
@property (nonatomic) location *suspectLocation;
@property (nonatomic) NSArray *suspectPrivateQuestionList;
@property (nonatomic) BOOL victim;
@property (nonatomic) BOOL murderer;

- (id)initWithInitialValues: (int) sNumber
                       name: (NSString *) sName
                 occupation: (NSString *) sOccupation
              maritalStatus: (NSString *) sMaritalStatus
       privateQuestionList: (NSArray *) sQuestionList;

- (NSString *)description;



@end
