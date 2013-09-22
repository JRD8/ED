//
//  EDSuspect.h
//  ElectronicDetective
//
//  Created by James Diener on 8/22/13.
//  Copyright (c) 2013 James Diener. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDTypedefEnums.h"

@interface EDSuspect : NSObject

@property (nonatomic) int suspectNumber;
@property (nonatomic) type suspectType;
@property (nonatomic) NSString *suspectName;
@property (nonatomic) NSString *suspectOccupation;
@property (nonatomic) NSString *suspectMaritalStatus;
@property (nonatomic) NSArray *suspectPrivateQuestionList;

@property (nonatomic) location suspectLocation;
@property (nonatomic) side suspectSide;
@property (nonatomic) area suspectArea;
@property (nonatomic) alibiType assignedAlibiType;

@property (nonatomic) NSString *suspectAlibi;

@property (nonatomic) BOOL victim;
@property (nonatomic) BOOL murderer;
@property (nonatomic) BOOL assignedYet;

- (id)initWithInitialValues: (int) sNumber
                suspectType: (type) sType
                       name: (NSString *) sName
                 occupation: (NSString *) sOccupation
              maritalStatus: (NSString *) sMaritalStatus
       privateQuestionList: (NSArray *) sQuestionList;

- (NSString *)description;
- (NSString *)generateTypeString: (type) type;
- (NSString *)generateLocationString: (location)location;
- (NSString *)generateSideString: (side)side;
- (NSString *)generateAreaString: (area)area;
- (NSString *)generateAlibiTypeString: (alibiType)alibiType;

- (void)generateAlibiStringWithSuspect1: (int) accompanyingSuspect1
                               Suspect2: (int) accompanyingSuspect2;

@end
