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
{
    
}

@property (nonatomic) int suspectNumber;
@property (nonatomic) type suspectType;
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
                suspectType: (type) sType
                       name: (NSString *) sName
                 occupation: (NSString *) sOccupation
              maritalStatus: (NSString *) sMaritalStatus
       privateQuestionList: (NSArray *) sQuestionList;

- (NSString *)description;



@end
