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
    oddFemale = 2,
    evenFemale = 3
    
} type;

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
    factory = 5,
    
    morgue = 6 // Equivalent to out of the game for the victim
    
} location;

typedef enum
{
    handgun38 = 0,
    handgun45 = 1,
    
} weapon;

typedef enum
{
    unassignedAlibiType = 0,
    withSuspectAndSuspect = 1,
    areaOnly = 2,
    sideOnly = 3,
    sideArea = 4,
    atLocation = 5,
    areaWithSuspect = 6,
    sideWithSuspect = 7,
    areaAtLocation = 8,
    sideAtLocation = 9,
    atLocationWithSuspect = 10,
    sideWithSuspectAndSuspect = 11,
    sideAreaWithSuspect = 12,

} alibiType;


typedef enum
{
    unassignedQuestion = 0,
    didMurdererGoEast = 1,
    isMaleMurderer = 2,
    whatAreaWasMurderer = 3,
    isMurderWeapon38 = 4,
    locationOf38 = 5,
    locationOf45 = 6,
    whereIsThreeSuspectLocation = 7,
    isMurdererAtABC = 8,
    wereYouEast = 9,
    whatWasYourArea = 10,
    wereYouAtABC = 11,
    wereYouInAWeaponLocation = 12,
    areOddPrintsOn38 = 13,
    areOddPrintsOn45 = 14,
    
} privateQuestion;

typedef enum
{
    unassignedCombo = 0,
    combo_12_8_7 = 1,
    combo_12_8_6 = 2,
    combo_1_1_5_4 = 3,
    combo_5_11_2_6 = 4,
    combo_4_8_10_11 = 5,
    combo_1_1_6_9 = 6,
    combo_2_10_1_3 = 7,
    
} comboType;


#endif
