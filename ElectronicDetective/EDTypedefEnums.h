//
//  EDTypedefEnums.h
//  ElectronicDetective
//
//  Created by James Diener on 8/24/13.
//  Copyright (c) 2013 James Diener. All rights reserved.
//

#ifndef ElectronicDetective_EDTypedefEnums_h
#define ElectronicDetective_EDTypedefEnums_h

typedef enum
{
    oddMale = 0,
    evenMale = 1,
    offFemale = 2,
    evenFemale = 3
    
} suspectType;

typedef enum
{
    east = 0,
    west = 1
    
} side;

typedef enum
{
    uptown = 0,
    midtown = 1,
    downtown = 2
    
} area;

typedef enum
{
    artShow = 0,
    boxAtTheatre = 1,
    cardParty = 2,
    docks = 3,
    embassy = 4,
    factory = 5
    
} location;

typedef enum
{
    handgun38 = 0,
    handgun45 = 1,
    
} weapon;

#endif
