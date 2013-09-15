//
//  EDGameStateStore.m
//  ElectronicDetective
//
//  Created by James Diener on 8/22/13.
//  Copyright (c) 2013 James Diener. All rights reserved.
//

#import "EDGameStateStore.h"
#import "EDSuspect.h"
#import "EDLocation.h"
#import <stdlib.h>

@implementation EDGameStateStore

@synthesize masterSuspectDirectory, masterLocationDirectory, murdererNumber;

// Class Methods
+ (EDGameStateStore *) sharedStore
{
    static EDGameStateStore *sharedStore = nil;
    if (!sharedStore)
        sharedStore = [[super allocWithZone:nil] init];
    return sharedStore;
}

+ (id) allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}

- (id)init
{
    self = [super init];
    
    [self createMasterSuspectDirectory];
    [self createMasterLocationDirectory];
    
    [self killVictim];
    [self assignMurderer];
    [self randomizeSuspectsInCity];
    [self hideWeapons];
    
    [self assignSideAreaToLocation];
    [self assignAlibiTypesToSuspects];
    
    NSLog(@"\rMASTER LOCATION DIRECTORY: %@\r", [masterLocationDirectory description]);
   
    // Additional log routines
    [self printLocationAssignedSuspects];
    [self printMasterSuspectDirectory];
    [self privateQuestionTestRoutine];
    
    return self;
}

#pragma mark - Main Methods

- (void) createMasterSuspectDirectory
{
    
    masterSuspectDirectory = [[NSMutableDictionary alloc] init];
    
    // Initial Array Values
    suspectNames = [[NSArray alloc] initWithObjects :@"Lenny Little", @"Al Farook", @"Pepe Perez", @"Tony Racheti", @"Mickey O'Malley", @"Max Fineflugle", @"Ripp Rapp", @"Buster Bailey", @"Rocky Roll", @"Ling Tong", @"Ivy Little", @"Lucy Tumble", @"Piper Perez", @"Dina Racheti", @"Eileen Stellar", @"Joan Fineflugle", @"Rose Pettle", @"Doris Dill", @"Candy Roll", @"Sing Wong", nil];
    
    suspectOccupations = [[NSArray alloc] initWithObjects: @"Bartender", @"Tycoon", @"Flamenco Dancer", @"Promoter", @"Retired Cop", @"Producer", @"Dockworker", @"Basketball Player", @"Musician", @"Restaurant Owner", @"Landlady", @"Secretary", @"Latin Singer", @"Socialite", @"Actress", @"Accountant", @"Gossip Columnist", @"Lady Newscaster", @"Groupie", @"Waitress", nil];
    
    suspectMaritalStatuses = [[NSArray alloc] initWithObjects: @"Married to #11, Ivy Little", @"Playboy", @"Married to #13, Piper Perez", @"Married to #14, Dina Racheti", @"Single", @"Married to #16, Joan Fineflugle", @"Single", @"Single", @"Married to #19, Candy Roll", @"Bachelor", @"Married to #1, Lenny Little", @"Still Looking", @"Married to #3, Pepe Perez", @"Married to #4, Tony Racheti", @"Eligible", @"Married to #6, Max Fineflugle", @"Unattached", @"Not Looking", @"Married to #9, Rocky Roll", @"Single", nil];
    
    
    // Need to wrap ints into NSNumbers for suspectPrivateQuestion & suspectType arrays
    num0 = [NSNumber numberWithInt:0];
    num1 = [NSNumber numberWithInt:1];
    num2 = [NSNumber numberWithInt:2];
    num3 = [NSNumber numberWithInt:3];
    num4 = [NSNumber numberWithInt:4];
    num5 = [NSNumber numberWithInt:5];
    num6 = [NSNumber numberWithInt:6];
    num7 = [NSNumber numberWithInt:7];
    num8 = [NSNumber numberWithInt:8];
    num9 = [NSNumber numberWithInt:9];
    num10 = [NSNumber numberWithInt:10];
    num11= [NSNumber numberWithInt:11];
    num12 = [NSNumber numberWithInt:12];
    num13 = [NSNumber numberWithInt:13];
    num14 = [NSNumber numberWithInt:14];

    suspectPrivateQuestionLists = [[NSArray alloc] initWithObjects:[[NSArray alloc] initWithObjects:num1, num2, num9, num13, num14, nil], [[NSArray alloc] initWithObjects:num2, num3, num9, num13, num14, nil], [[NSArray alloc] initWithObjects:num1, num2, num9, num13, num14, nil], [[NSArray alloc] initWithObjects:num3, num4, num5, num13, num14, nil], [[NSArray alloc] initWithObjects:num4, num5, num9, num13, num14, nil], [[NSArray alloc] initWithObjects:num1, num4, num9, num13, num14, nil], [[NSArray alloc] initWithObjects:num5, num6, num12, num13, num14, nil], [[NSArray alloc] initWithObjects:num2, num5, num12, num13, num14, nil], [[NSArray alloc] initWithObjects:num3, num5, num12, num13, num14, nil], [[NSArray alloc] initWithObjects:num1, num5, num12, num13, num14, nil], [[NSArray alloc] initWithObjects:num7, num8, num12, num13, num14, nil], [[NSArray alloc] initWithObjects:num6, num7, num11, num13, num14, nil], [[NSArray alloc] initWithObjects:num2, num6, num11, num13, num14, nil], [[NSArray alloc] initWithObjects:num3, num7, num11, num13, num14, nil], [[NSArray alloc] initWithObjects:num1, num6, num11, num13, num14, nil], [[NSArray alloc] initWithObjects:num4, num7, num11, num13, num14, nil], [[NSArray alloc] initWithObjects:num6, num8, num10, num13, num14, nil], [[NSArray alloc] initWithObjects:num2, num7, num10, num13, num14, nil], [[NSArray alloc] initWithObjects:num1, num8, num10, num13, num14, nil], [[NSArray alloc] initWithObjects:num4, num8, num10, num13, num14, nil], nil];
    
    suspectTypes = [[NSArray alloc] initWithObjects: num0, num1, num0, num1, num0, num1, num0, num1, num0, num1, num2, num3, num2, num3, num2, num3, num2, num3, num2, num3, nil];
    
    
    // Create 20 EDSuspect objects and set them into masterSuspectList
    for (int i = 0; i < 20; i++)
    {
        [masterSuspectDirectory setObject:[[EDSuspect alloc] initWithInitialValues:i + 1 suspectType:[[suspectTypes objectAtIndex:i] intValue] name:[suspectNames objectAtIndex:i] occupation:[suspectOccupations objectAtIndex:i] maritalStatus:[suspectMaritalStatuses objectAtIndex:i] privateQuestionList:[suspectPrivateQuestionLists objectAtIndex:i]] forKey:[NSString stringWithFormat:@"%d", i + 1]];
    }
}

- (void) createMasterLocationDirectory
{
    NSArray *locationNames = [[NSArray alloc] initWithObjects:@"Art Show", @"Box At Theatre", @"Card Party", @"Docks", @"Embassy", @"Factory", nil];
    
    masterLocationDirectory = [[NSMutableDictionary alloc] init];
    
    for (int i = 0; i < 6; i++)
    {
        [masterLocationDirectory setObject:[[EDLocation alloc] initWithInitialValues:i name:[locationNames objectAtIndex:i]] forKey:[NSString stringWithFormat:@"location%d", i]];
    }
}

- (void) killVictim
{
    victimNumber = arc4random_uniform(20) + 1;
    sceneOfTheCrime = arc4random_uniform(6);
    murderWeapon = arc4random_uniform(2);

    // Flag victim on EDSuspect object
    EDSuspect *victim = [masterSuspectDirectory objectForKey:[NSString stringWithFormat:@"%d", victimNumber]];
    [victim setVictim:YES];
    
    // Flag location on EDLocation object
    EDLocation *murderSite = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", sceneOfTheCrime]];
    [murderSite setSceneOfTheCrime:YES];
    
    NSLog(@"\rThe Victim was #%d - %@\rThe body was found at %@\rThe murder weapon was a %@\r\r", [victim suspectNumber], [victim suspectName], [self generateLocationString:sceneOfTheCrime], [self generateWeaponString:murderWeapon]);
    
}

- (void) assignMurderer
{
    do
    {
        murdererNumber = arc4random_uniform(20) + 1;
    }
    while (murdererNumber == victimNumber);
    
    // Flag murderer on EDSuspect object
    EDSuspect *murderer = [masterSuspectDirectory objectForKey:[NSString stringWithFormat:@"%d", murdererNumber]];
    [murderer setMurderer:YES];
    
    NSLog(@"The Murderer is #%d - %@\r", [murderer suspectNumber], [murderer suspectName]);

}

- (void) hideWeapons
{
    
    // First, hide the .38
    do
    {
        locationOf38 = arc4random_uniform(6);
        
        NSString *locationOf38String = [self generateLocationString:locationOf38];
        
        NSLog(@"Hiding the .38 at %@\r", locationOf38String);
    }
    while (locationOf38 == sceneOfTheCrime || locationOf38 == murdererLocation || locationOf38 == threeSuspectLocation); // Can't hide weapon either at SceneOfCrime or guiltySuspectLocation or 3-Suspect Location
    
    // Flag location of .38 on EDLocation object
    EDLocation *siteOf38 = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", locationOf38]];
    [siteOf38 setLocationOf38:YES];
    
    
    // Then, hide the .45
    do
    {
        locationOf45 = arc4random_uniform(6);
        
        NSString *locationOf45String = [self generateLocationString:locationOf45];
        
        NSLog(@"Hiding the .45 at %@\n", locationOf45String);
    }
    while (locationOf45 == sceneOfTheCrime || locationOf45 == locationOf38 || locationOf45 == murdererLocation || locationOf45 == threeSuspectLocation); // Same as above, buy also can't hide where the .38 is hidden
    
    // Flag location of .45 on EDLocation object
    EDLocation *siteOf45 = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", locationOf45]];
    [siteOf45 setLocationOf45:YES];
}

- (void) randomizeSuspectsInCity
{
    
    // Method variables/objects
    EDSuspect *candidateSuspect;
    type candidateType;
    int candidateSuspectNumber;
    BOOL candidateAssigned = NO;
    
    location targetLocationNumber;
    EDLocation *targetLocation;
    BOOL successfulAssignment;

    
    // Assign the Victim to the morgue
    EDSuspect *temp = [masterSuspectDirectory objectForKey:[NSString stringWithFormat:@"%d", victimNumber]];
    [temp setSuspectLocation:6]; // Assign to the morgue
    [temp setAssignedYet:YES];
    
    // Iterate 19x representing the remaining 19 suspects
    for (int i = 0; i < 19; i++)
    {
        successfulAssignment = NO; // Reset successfulAssignment
        
        do
        {
            // Select a random number between 0 - 19
            candidateSuspectNumber = arc4random_uniform(20);
            
            // Test if candidate suspect has been assigned yet
            candidateSuspect = [masterSuspectDirectory objectForKey:[NSString stringWithFormat:@"%d", candidateSuspectNumber + 1]];
            candidateAssigned = [candidateSuspect assignedYet];
        }
        while (candidateAssigned == YES); // If candidateAssigned == YES, then repeat do/while
        
        // If candidateAssigned == NO, proceed...
        
        // Evaluate candidateType
        if (candidateSuspectNumber < 10 && ((candidateSuspectNumber + 1) % 2 != 0))
            {
                candidateType = 0; // OddMale
            }
        else if (candidateSuspectNumber < 10 && ((candidateSuspectNumber + 1) % 2 == 0))
        {
            candidateType = 1; // EvenMale
        }
        else if (candidateSuspectNumber >= 10 && ((candidateSuspectNumber + 1) % 2 != 0))
        {
            candidateType = 2; // OddFemale
        }
        else if (candidateSuspectNumber >= 10 && ((candidateSuspectNumber + 1) % 2 == 0))
        {
            candidateType = 3; // EvenFemale
        }
                                                                                   
        // Select random targetLocation
        do
        {
            // Randomize and select a targetLocation that is NOT the murderLocation
            do
            {
                targetLocationNumber = arc4random_uniform(6);
                
                targetLocation = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", targetLocationNumber]];
                
            }
            while (targetLocationNumber == sceneOfTheCrime); // Keep looping if targetLocation == murderLocation
            
            if ([[targetLocation assignedSuspects] count] == 0) // No assignedSuspects yet
            {
                // Assign Suspect...
                [[targetLocation assignedSuspects] addObject:candidateSuspect]; // Add to EDLocation assignedSuspects NSArray
                [candidateSuspect setSuspectLocation:[targetLocation locationNumber]]; // Set targetLocation # for candidateSuspect
                [candidateSuspect setAssignedYet:YES]; // Flag on the EDSuspect candidateSuspect object
                successfulAssignment = YES; // Change the successfulAssignment flag to YES
                
            }
            else if ([[targetLocation assignedSuspects] count] > 0) // Some assignedSuspects already
            {
                // Determine how many existing assignedSuspects at targetLocation
                int numberOfSuspectsAtTargetLocation = [[targetLocation assignedSuspects] count];
                
                EDSuspect *testSuspect;
                type testSuspectType;
                BOOL assignHere = YES; // Defaults as YES prior to testing
                
                // Iterate through the number of assignedSuspects at targetLocation and test their suspectType vs. candidateType
                for (int j = 0; j < numberOfSuspectsAtTargetLocation; j++)
                {
                    testSuspect = [[targetLocation assignedSuspects] objectAtIndex:j];
                    testSuspectType = [testSuspect suspectType];
                    
                    // If any testSuspectTypes == candidateType, then change assignHere to NO
                    if (testSuspectType == candidateType)
                    {
                        assignHere = NO;
                    }
                }
                
                if (assignHere == YES) // If still YES after checking all the assignedSuspects at targetLocation, then assign!
                {
                    // Assign Suspect...
                    [[targetLocation assignedSuspects] addObject:candidateSuspect]; // Add to EDLocation assignedSuspects NSArray
                    [candidateSuspect setSuspectLocation:[targetLocation locationNumber]]; // Set targetLocation # for candidateSuspect
                    [candidateSuspect setAssignedYet:YES]; // Flag on the EDSuspect candidateSuspect object
                    successfulAssignment = YES; // Change the successfulAssignment flag to YES
                }
            }
        }
        while (successfulAssignment == NO);
    }
    
    // Register the guiltySuspectLocation and flag MurderLocation variable in EDLocation object
    EDSuspect *guiltySuspect = [masterSuspectDirectory objectForKey:[NSString stringWithFormat:@"%d", murdererNumber + 1]];
    murdererLocation = [guiltySuspect suspectLocation];
    
    EDLocation *tempLocation = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", murdererLocation]];
    [tempLocation setMurdererLocation:YES];
    
    NSLog(@"Murderer Location = %@", [self generateLocationString:murdererLocation]);
    
    // Register the threeSuspectLocation
    [self identify3SuspectLocation];
    
    NSLog(@"3 Suspect Location = %@\r", [self generateLocationString:threeSuspectLocation]);
}

- (void) identify3SuspectLocation
{
    for (int i = 0; i < 6; i++)
    {
        EDLocation *testLocation = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", i]];
        
        if ([[testLocation assignedSuspects] count] == 3)
        {
            [testLocation setThreeSuspectLocation:YES];
            threeSuspectLocation = i;
        }
    }
}

- (void) assignSideAreaToLocation
{
    // Method variables
    BOOL locationAssigned;
    
    // Iterate through all locations and assign Side/Area values
    for (int i = 0; i < 6; i++)
    {
        locationAssigned = NO;
        
        EDLocation *candidate = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", i]];
        
        do
        {
            side candidateSide = arc4random_uniform(2);
            area candidateArea = arc4random_uniform(3);
            
            if (i == 0) // For the first location
            {
                [candidate setLocationSide:candidateSide];
                [candidate setLocationArea:candidateArea];
                locationAssigned = YES;
            }
            else if (i > 0) // For all subsequent locations
            {
                locationAssigned = YES;
                
                // Iterate through prior locations and see test if Side/Area's match
                for (int j = 0; j < i; j++)
                {
                    EDLocation *test = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", j]];
                    
                    side testSide = [test locationSide];
                    area testArea = [test locationArea];
                    
                    if ((testSide == candidateSide) && (testArea == candidateArea))
                    {
                        locationAssigned = NO; // If there is a match, do NOT assign location
                    }
                }
                
                if (locationAssigned == YES) // If there is no match after testing, assign location
                {
                    [candidate setLocationSide:candidateSide];
                    [candidate setLocationArea:candidateArea];
                }
            }
        }
        while
        (locationAssigned == NO); // If there had been a match, then repeat look to choose new Side/Area values
    }
    
    // Register the Side/Area values to the Suspect objects
    EDSuspect *tempSuspect = [[EDSuspect alloc] init];
    EDLocation *tempLocation = [[EDLocation alloc] init];
  
    // Iterate through the 20 suspects and assisn values
    for (int i = 0; i < 20; i++)
    {
        tempSuspect = [masterSuspectDirectory objectForKey:[NSString stringWithFormat:@"%d", i]];
        tempLocation = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", [tempSuspect suspectLocation]]];
        [tempSuspect setSuspectSide:[tempLocation locationSide]]; // Register Side
        [tempSuspect setSuspectArea:[tempLocation locationArea]]; // Register Area
    }
}

- (void) assignAlibiTypesToSuspects
{
    // Method Variables
    
    NSArray *tempValues = [[NSArray alloc] init]; // A temp container for routines below
    BOOL proceed; // Loop flag
    int oddMale;
    int evenMale;
    int oddFemale;
    int evenFemale;
    
    // First, set the MURDER LOCATION as Init Completed
    
    EDLocation *tempLocation = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", sceneOfTheCrime]];
    [tempLocation setInitCompleted:YES]; // Flag the Location as completed
    
    
    // Then, locate the VICTIM and set his alibiType = 0 and generate string
    EDSuspect *tempSuspect = [masterSuspectDirectory objectForKey:[NSString stringWithFormat:@"%d", victimNumber]];
    [tempSuspect setAssignedAlibiType:0];
    [tempSuspect generateAlibiString:0 suspect2:0];
    
    
    // Then, select the 3-SUSPECT LOCATION & randomly assign either (12,8,7) or (12,8,6) assignedAlibiType values to suspects
    tempLocation = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", threeSuspectLocation]];
    NSMutableArray *tempAssignedSuspects = [tempLocation assignedSuspects];
    
    // Utility setup for the 3 SUSPECT LOCATION Option
    NSArray *threeSuspectOption1Values = [[NSArray alloc] initWithObjects:num12, num8, num7, nil]; // 3 SUSPECT LOCATION - 1ST CHOICE (12,8,7)
    NSArray *threeSuspectOption2Values = [[NSArray alloc] initWithObjects:num12, num8, num6, nil]; // 3 SUSPECT LOCATION - 2ND CHOICE (12,8,6)
    NSArray *masterLocationValues = [[NSArray alloc] initWithObjects:threeSuspectOption1Values, threeSuspectOption2Values, nil]; // Master container for 3 SUSPECT LOCATION values
    
    int threeSuspectChoice = arc4random_uniform(2); // Either Option 1 or Option 2 in the masterLocationValues array
     
    for (int i = 0; i < 3; i++)
    {
        proceed = NO;// Reset flag
     
        do
         {
             int candidate = arc4random_uniform(3);
             tempAssignedSuspects = [tempLocation assignedSuspects];
             EDSuspect *tempSuspect = [tempAssignedSuspects objectAtIndex:candidate];
         
             if ([tempSuspect assignedAlibiType] == 0)
             {
                 tempValues = [masterLocationValues objectAtIndex:threeSuspectChoice]; // Revert to either Option 1 or Option 2
                 [tempSuspect setAssignedAlibiType:[[tempValues objectAtIndex:i] intValue]];
                 proceed = YES;
             }
        }
        while (proceed == NO);
    }
    
    // Generate Alibi Statements
    // FIXME: Still debugging 3 suspect location statement alibi (and possibly assignment rules)
    for (int i = 0; i < 3; i++)
    {
        
        EDSuspect *tempSuspect = [tempAssignedSuspects objectAtIndex:i];
        
        if ([tempSuspect assignedAlibiType] == 8)
        {
            [tempSuspect generateAlibiString:0 suspect2:0];
        }
        
        int passingValue = 0;
        
        if ([tempSuspect assignedAlibiType] == 7)
        {
            for (int j = 0; j < 3; j++)
            {
                EDSuspect *suspectForSearch = [tempAssignedSuspects objectAtIndex:j];
                
                if ([suspectForSearch assignedAlibiType] == 8)
                {
                     [tempSuspect generateAlibiString:[suspectForSearch suspectNumber] suspect2:0];
                }
            }
            
            passingValue = [tempSuspect suspectNumber];
        }
    
        if ([tempSuspect assignedAlibiType] == 6)
        {
            for (int j = 0; j < 3; j++)
            {
                EDSuspect *suspectForSearch = [tempAssignedSuspects objectAtIndex:j];
                
                if ([suspectForSearch assignedAlibiType] == 8)
                {
                    [tempSuspect generateAlibiString:[suspectForSearch suspectNumber] suspect2:0];
                }
            }
            
            passingValue = [tempSuspect suspectNumber];
        }
    
        if ([tempSuspect assignedAlibiType] == 12)
        {
            [tempSuspect generateAlibiString:passingValue suspect2:0];
        }
    }

    // Register alibiCombo at location
    if (threeSuspectChoice == 0)
    {
        [tempLocation setAlibiCombo:combo_12_8_7];
    }
    else if (threeSuspectChoice == 1)
    {
        [tempLocation setAlibiCombo:combo_12_8_6];
    }
    
    [tempLocation setInitCompleted:YES]; // Flag the Location as completed

    
    // Select one of the remaining location as the (1,1,5,4) cluster
    
    // Reset these counters
    oddMale = 0;
    evenMale = 0;
    oddFemale = 0;
    evenFemale = 0;
    
    do
    {
        location tempLocationNumber = arc4random_uniform(6);
        
        tempLocation = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", tempLocationNumber]];
        
    }
    while ([tempLocation initCompleted] == YES);
        
    tempAssignedSuspects = [tempLocation assignedSuspects]; // Load the assignedSuspects array
    
    // Assign Type 1 to Odd Female
    for (int i = 0; i < 4; i++)
    {
        EDSuspect *candidate = [tempAssignedSuspects objectAtIndex:i];
        
        if ([candidate suspectType] == 2) // Located Odd Female
        {
            [candidate setAssignedAlibiType:1];
            
            oddFemale = [candidate suspectNumber];
        }
    }
    // Assign Type 1 to Even Female
    for (int i = 0; i < 4; i++)
    {
        EDSuspect *candidate = [tempAssignedSuspects objectAtIndex:i];
        
        if ([candidate suspectType] == 3) // Located Even Female
        {
            [candidate setAssignedAlibiType:1];
            
            evenFemale = [candidate suspectNumber];
        }
    }
    // Handle 4,5 assignments
    alibiType unusedAlibiType;
    
    proceed = NO;
    for (int i = 0; i < 4; i++)
    {
        if (proceed == YES)
        {
            continue;
        }
        
        EDSuspect *candidate = [tempAssignedSuspects objectAtIndex:i];
        
        if ([candidate assignedAlibiType] == 0) // Located an unassigned
        {
            int randomRemainingAlibi = arc4random_uniform(2);
            
            switch (randomRemainingAlibi)
            {
                case 0:
                    [candidate setAssignedAlibiType:4];
                    unusedAlibiType = 5;
                    proceed = YES;
                    break;
                case 1:
                    [candidate setAssignedAlibiType:5];
                    unusedAlibiType = 4;
                    proceed = YES;
                default:
                    break;
            }
            
            // Record the current candidate's type
            if (([candidate suspectNumber] +2) % 2 == 0)
            {
                evenMale = [candidate suspectNumber];
            }
            else if (([candidate suspectNumber] +2) % 2 != 0)
            {
                oddMale = [candidate suspectNumber];
            }
        }
    }
    
    proceed = NO;
    for (int i = 0; i < 4; i++)
    {
        if (proceed == YES)
        {
            continue;
        }
        
        EDSuspect *candidate = [tempAssignedSuspects objectAtIndex:i];
        
        if ([candidate assignedAlibiType] == 0) // Located final unassigned
        {
            [candidate setAssignedAlibiType:unusedAlibiType];
            
            // Record the current candidate's type
            if (([candidate suspectNumber] +2) % 2 == 0)
            {
                evenMale = [candidate suspectNumber];
            }
            else if (([candidate suspectNumber] +2) % 2 != 0)
            {
                oddMale = [candidate suspectNumber];
            }
            
            proceed = YES;
        }
    }
    
    // Generate Alibi Statements
    for (int i = 0; i < 4; i++)
    {
        EDSuspect *tempSuspect = [tempAssignedSuspects objectAtIndex:i];
        
        if ([tempSuspect assignedAlibiType] == 5)
        {
            [tempSuspect generateAlibiString:0 suspect2:0];
        }
        
        if ([tempSuspect assignedAlibiType] == 4)
        {
            [tempSuspect generateAlibiString:0 suspect2:0];
        }

        if ([tempSuspect assignedAlibiType] == 1)
        {
            // Deteremine if odd or even
            if (([tempSuspect suspectNumber] + 2) % 2 == 0) // Even (female)
            {
                [tempSuspect generateAlibiString:oddMale suspect2:oddFemale];
            }
            
            if (([tempSuspect suspectNumber] + 2) % 2 != 0) // Odd (female)
            {
                [tempSuspect generateAlibiString:evenMale suspect2:evenFemale];
            }
        }
    }

    // Register alibiCombo at location
    [tempLocation setAlibiCombo:combo_1_1_5_4];
    
    [tempLocation setInitCompleted:YES]; // Flag the Location as completed

    
    // Select one of the remaining location as the (5,11,2,6) cluster
    
    // Reset these counters
    oddMale = 0;
    evenMale = 0;
    oddFemale = 0;
    evenFemale = 0;
    
    do
    {
        location tempLocationNumber = arc4random_uniform(6);
        
        tempLocation = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", tempLocationNumber]];
        
    }
    while ([tempLocation initCompleted] == YES);
    
    tempAssignedSuspects = [tempLocation assignedSuspects]; // Load the assignedSuspects array

    // Assign Type 11 to Even Male
    for (int i = 0; i < 4; i++)
    {
        EDSuspect *candidate = [tempAssignedSuspects objectAtIndex:i];
        
        if ([candidate suspectType] == 1) // Located Even Male
        {
            [candidate setAssignedAlibiType:11];
            
            evenMale = [candidate suspectNumber];
        }
    }
    // Assign Type 6 to Even Female
    for (int i = 0; i < 4; i++)
    {
        EDSuspect *candidate = [tempAssignedSuspects objectAtIndex:i];
        
        if ([candidate suspectType] == 3) // Located Even Female
        {
            [candidate setAssignedAlibiType:6];
            
            evenFemale = [candidate suspectNumber];
        }
    }
    // Handle 5,2 assignments
    proceed = NO;
    for (int i = 0; i < 4; i++)
    {
        if (proceed == YES)
        {
            continue;
        }
        
        EDSuspect *candidate = [tempAssignedSuspects objectAtIndex:i];
        
        if ([candidate assignedAlibiType] == 0) // Located an unassigned
        {
            int randomRemainingAlibi = arc4random_uniform(2);
            
            switch (randomRemainingAlibi)
            {
                case 0:
                    [candidate setAssignedAlibiType:5];
                    unusedAlibiType = 2;
                    proceed = YES;
                    break;
                case 1:
                    [candidate setAssignedAlibiType:2];
                    unusedAlibiType = 5;
                    proceed = YES;
                default:
                    break;
            }
            
            if ([candidate suspectNumber] < 11) // (odd) Male
            {
                oddMale = [candidate suspectNumber];
            }
            else if ([candidate suspectNumber] >= 11) // (odd) Female
            {
                oddFemale = [candidate suspectNumber];
            }
        }
    }
    
    proceed = NO;
    for (int i = 0; i < 4; i++)
    {
        if (proceed == YES)
        {
            continue;
        }
        
        EDSuspect *candidate = [tempAssignedSuspects objectAtIndex:i];
        
        if ([candidate assignedAlibiType] == 0) // Located final unassigned
        {
            [candidate setAssignedAlibiType:unusedAlibiType];
            
            if ([candidate suspectNumber] < 11) // (odd) Male
            {
                oddMale = [candidate suspectNumber];
            }
            else if ([candidate suspectNumber] >= 11) // (odd) Female
            {
                oddFemale = [candidate suspectNumber];
            }
            
            proceed = YES;
        }
    }
    
    // Generate Alibi Statements
    for (int i = 0; i < 4; i++)
    {
        EDSuspect *tempSuspect = [tempAssignedSuspects objectAtIndex:i];
        
        if ([tempSuspect assignedAlibiType] == 2)
        {
           [tempSuspect generateAlibiString:0 suspect2:0]; 
        }
        
        if ([tempSuspect assignedAlibiType] == 5)
        {
            [tempSuspect generateAlibiString:0 suspect2:0];
        }
        
        if ([tempSuspect assignedAlibiType] == 11)
        {
            [tempSuspect generateAlibiString:oddMale suspect2:oddFemale];
        }
        
        if ([tempSuspect assignedAlibiType] == 6)
        {
            [tempSuspect generateAlibiString:evenMale suspect2:0];
        }
    }
    
    // Register alibiCombo at location
    [tempLocation setAlibiCombo:combo_5_11_2_6];
    
    [tempLocation setInitCompleted:YES]; // Flag the Location as completed
    
    // Randomly select 2 of the remaining 3 cluster sequences (1,1,6,9), (2,10,1,3) or (4,8,10,11)

    // Select 2 random cluster numbers
    int clusterSelect1, clusterSelect2;
    do
    {
        clusterSelect1 = arc4random_uniform(3);
        clusterSelect2 = arc4random_uniform(3);
    }
    while (clusterSelect1 == clusterSelect2);
    
    
    // Process the chosen 2 cluster numebers
    if ((clusterSelect1 == 0) || (clusterSelect2 == 0)) // The (1,1,6,9) cluster
    {
        // Reset these counters
        oddMale = 0;
        evenMale = 0;
        oddFemale = 0;
        evenFemale = 0;
        
        do
        {
            location tempLocationNumber = arc4random_uniform(6);
            
            tempLocation = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", tempLocationNumber]];
            
        }
        while ([tempLocation initCompleted] == YES);
        
        tempAssignedSuspects = [tempLocation assignedSuspects]; // Load the assignedSuspects array
        
        // Assign Type 1 to Odd Female
        for (int i = 0; i < 4; i++)
        {
            EDSuspect *candidate = [tempAssignedSuspects objectAtIndex:i];
            
            if ([candidate suspectType] == 2) // Located Odd Female
            {
                [candidate setAssignedAlibiType:1];
                
                oddFemale = [candidate suspectNumber];
            }
        }
        // Assign Type 1 to Even Female
        for (int i = 0; i < 4; i++)
        {
            EDSuspect *candidate = [tempAssignedSuspects objectAtIndex:i];
            
            if ([candidate suspectType] == 3) // Located Even Female
            {
                [candidate setAssignedAlibiType:1];
                
                evenFemale = [candidate suspectNumber];
            }
        }
        // Handle 6,9 assignments
        alibiType unusedAlibiType;
        
        proceed = NO;
        for (int i = 0; i < 4; i++)
        {
            if (proceed == YES)
            {
                continue;
            }
            
            EDSuspect *candidate = [tempAssignedSuspects objectAtIndex:i];
            
            if ([candidate assignedAlibiType] == 0) // Located an unassigned
            {
                int randomRemainingAlibi = arc4random_uniform(2);
                
                switch (randomRemainingAlibi)
                {
                    case 0:
                        [candidate setAssignedAlibiType:6];
                        unusedAlibiType = 9;
                        proceed = YES;
                        break;
                    case 1:
                        [candidate setAssignedAlibiType:9];
                        unusedAlibiType = 6;
                        proceed = YES;
                    default:
                        break;
                }
            
                // Record the current candidate's type
                if (([candidate suspectNumber] +2) % 2 == 0)
                {
                    evenMale = [candidate suspectNumber];
                }
                else if (([candidate suspectNumber] +2) % 2 != 0)
                {
                    oddMale = [candidate suspectNumber];
                }
            }
        }
        
        proceed = NO;
        for (int i = 0; i < 4; i++)
        {
            if (proceed == YES)
            {
                continue;
            }
            
            EDSuspect *candidate = [tempAssignedSuspects objectAtIndex:i];
            
            if ([candidate assignedAlibiType] == 0) // Located final unassigned
            {
                [candidate setAssignedAlibiType:unusedAlibiType];
                
                // Record the current candidate's type
                if (([candidate suspectNumber] +2) % 2 == 0)
                {
                    evenMale = [candidate suspectNumber];
                }
                else if (([candidate suspectNumber] +2) % 2 != 0)
                {
                    oddMale = [candidate suspectNumber];
                }
                
                proceed = YES;
            }
        }
        
        // Generate Alibi Statements
        for (int i = 0; i < 4; i++)
        {
            EDSuspect *tempSuspect = [tempAssignedSuspects objectAtIndex:i];
            
            if ([tempSuspect assignedAlibiType] == 6)
            {
                [tempSuspect generateAlibiString:evenMale suspect2:0];
            }
            
            if ([tempSuspect assignedAlibiType] == 9)
            {
                [tempSuspect generateAlibiString:0 suspect2:0];
            }
            
            if ([tempSuspect assignedAlibiType] == 1)
            {
                // Deteremine if odd or even
                if (([tempSuspect suspectNumber] + 2) % 2 == 0) // Even (female)
                {
                    // Get the odd male and odd female
                    [tempSuspect generateAlibiString:evenMale suspect2:oddMale];
                }
                
                if (([tempSuspect suspectNumber] + 2) % 2 != 0) // Odd (female)
                {
                    // Get the even male and even female
                    [tempSuspect generateAlibiString:oddMale suspect2:evenFemale];
                }
            }
        }
        
        // Register alibiCombo at location
        [tempLocation setAlibiCombo:combo_1_1_6_9];
        
        [tempLocation setInitCompleted:YES]; // Flag the Location as completed
    }
    
    if ((clusterSelect1 == 1) || (clusterSelect2 == 1)) // the (2,10,1,3) cluster
    {
        // Reset these counters
        oddMale = 0;
        evenMale = 0;
        oddFemale = 0;
        evenFemale = 0;
        
        do
        {
            location tempLocationNumber = arc4random_uniform(6);
            
            tempLocation = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", tempLocationNumber]];
            
        }
        while ([tempLocation initCompleted] == YES);
        
        tempAssignedSuspects = [tempLocation assignedSuspects]; // Load the assignedSuspects array
        
        // Assign Type 1 to Odd Male
        for (int i = 0; i < 4; i++)
        {
            EDSuspect *candidate = [tempAssignedSuspects objectAtIndex:i];
            
            if ([candidate suspectType] == 0) // Located Odd Male
            {
                [candidate setAssignedAlibiType:1];
                
                oddMale = [candidate suspectNumber];
            }
        }
        // Assign Type 10 to Even Male
        for (int i = 0; i < 4; i++)
        {
            EDSuspect *candidate = [tempAssignedSuspects objectAtIndex:i];
            
            if ([candidate suspectType] == 1) // Located Even Male
            {
                [candidate setAssignedAlibiType:10];
                
                evenMale = [candidate suspectNumber];
            }
        }
        // Handle 2,3 assignments
        alibiType unusedAlibiType;
        
        proceed = NO;
        for (int i = 0; i < 4; i++)
        {
            if (proceed == YES)
            {
                continue;
            }
            
            EDSuspect *candidate = [tempAssignedSuspects objectAtIndex:i];
            
            if ([candidate assignedAlibiType] == 0) // Located an unassigned
            {
                int randomRemainingAlibi = arc4random_uniform(2);
                
                switch (randomRemainingAlibi)
                {
                    case 0:
                        [candidate setAssignedAlibiType:2];
                        unusedAlibiType = 3;
                        proceed = YES;
                        break;
                    case 1:
                        [candidate setAssignedAlibiType:3];
                        unusedAlibiType = 2;
                        proceed = YES;
                    default:
                        break;
                }
                
                // Record the current candidate's type
                if (([candidate suspectNumber] +2) % 2 == 0)
                {
                    evenFemale = [candidate suspectNumber];
                }
                else if (([candidate suspectNumber] +2) % 2 != 0)
                {
                    oddFemale = [candidate suspectNumber];
                }
            }
        }
        proceed = NO;
        
        for (int i = 0; i < 4; i++)
        {
            if (proceed == YES)
            {
                continue;
            }
            
            EDSuspect *candidate = [tempAssignedSuspects objectAtIndex:i];
            
            if ([candidate assignedAlibiType] == 0) // Located final unassigned
            {
                [candidate setAssignedAlibiType:unusedAlibiType];
                
                // Record the current candidate's type
                if (([candidate suspectNumber] +2) % 2 == 0)
                {
                    evenFemale = [candidate suspectNumber];
                }
                else if (([candidate suspectNumber] +2) % 2 != 0)
                {
                    oddFemale = [candidate suspectNumber];
                }
                
                proceed = YES;
            }
        }
        
        // Generate Alibi Statements
        for (int i = 0; i < 4; i++)
        {
            EDSuspect *tempSuspect = [tempAssignedSuspects objectAtIndex:i];
            
            if ([tempSuspect assignedAlibiType] == 2)
            {
                [tempSuspect generateAlibiString:0 suspect2:0];
            }
            
            if ([tempSuspect assignedAlibiType] == 3)
            {
                [tempSuspect generateAlibiString:0 suspect2:0];
            }
            
            if ([tempSuspect assignedAlibiType] == 10)
            {
                [tempSuspect generateAlibiString:oddMale suspect2:0];
            }
            
            if ([tempSuspect assignedAlibiType] == 1)
            {
                [tempSuspect generateAlibiString:evenFemale suspect2:oddFemale];
            }
        }
        
        // Register alibiCombo at location
        [tempLocation setAlibiCombo:combo_2_10_1_3];
        
        [tempLocation setInitCompleted:YES]; // Flag the Location as completed
    }
    
    if ((clusterSelect1 == 2) || (clusterSelect2 == 2)) // the (4,8,10,11) cluster
    {
        // Reset these counters
        oddMale = 0;
        evenMale = 0;
        oddFemale = 0;
        evenFemale = 0;
        
        do
        {
            location tempLocationNumber = arc4random_uniform(6);
            
            tempLocation = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", tempLocationNumber]];
            
        }
        while ([tempLocation initCompleted] == YES);
        
        tempAssignedSuspects = [tempLocation assignedSuspects]; // Load the assignedSuspects array
        
        // Assign Type 10 to Even Male
        for (int i = 0; i < 4; i++)
        {
            EDSuspect *candidate = [tempAssignedSuspects objectAtIndex:i];
            
            if ([candidate suspectType] == 1) // Located Even Male
            {
                [candidate setAssignedAlibiType:10];
                
                evenMale = [candidate suspectNumber];
            }
        }
        // Assign Type 11 to Odd Female
        for (int i = 0; i < 4; i++)
        {
            EDSuspect *candidate = [tempAssignedSuspects objectAtIndex:i];
            
            if ([candidate suspectType] == 2) // Located Odd Female
            {
                [candidate setAssignedAlibiType:11];
                
                oddFemale = [candidate suspectNumber];
            }
        }
        // Handle 4,8 assignments
        alibiType unusedAlibiType;
        
        proceed = NO;
        for (int i = 0; i < 4; i++)
        {
            if (proceed == YES)
            {
                continue;
            }
            
            EDSuspect *candidate = [tempAssignedSuspects objectAtIndex:i];
            
            if ([candidate assignedAlibiType] == 0) // Located an unassigned
            {
                int randomRemainingAlibi = arc4random_uniform(2);
                
                switch (randomRemainingAlibi)
                {
                    case 0:
                        [candidate setAssignedAlibiType:4];
                        unusedAlibiType = 8;
                        proceed = YES;
                        break;
                    case 1:
                        [candidate setAssignedAlibiType:8];
                        unusedAlibiType = 4;
                        proceed = YES;
                    default:
                        break;
                }
                
                // Record the current candidate's type
                if (([candidate suspectNumber] +2) % 2 == 0)
                {
                    evenFemale = [candidate suspectNumber];
                }
                else if (([candidate suspectNumber] +2) % 2 != 0)
                {
                    oddMale = [candidate suspectNumber];
                }
            }
        }
        
        proceed = NO;
        for (int i = 0; i < 4; i++)
        {
            if (proceed == YES)
            {
                continue;
            }
            
            EDSuspect *candidate = [tempAssignedSuspects objectAtIndex:i];
            
            if ([candidate assignedAlibiType] == 0) // Located final unassigned
            {
                [candidate setAssignedAlibiType:unusedAlibiType];
                
                // Record the current candidate's type
                if (([candidate suspectNumber] +2) % 2 == 0)
                {
                    evenFemale = [candidate suspectNumber];
                }
                else if (([candidate suspectNumber] +2) % 2 != 0)
                {
                    oddMale = [candidate suspectNumber];
                }
                
                proceed = YES;
            }
        }
        
        // Generate Alibi Statements
        for (int i = 0; i < 4; i++)
        {
            EDSuspect *tempSuspect = [tempAssignedSuspects objectAtIndex:i];
            
            if ([tempSuspect assignedAlibiType] == 4)
            {
                [tempSuspect generateAlibiString:0 suspect2:0];
            }
            
            if ([tempSuspect assignedAlibiType] == 8)
            {
                [tempSuspect generateAlibiString:0 suspect2:0];
            }
            
            if ([tempSuspect assignedAlibiType] == 10)
            {
                [tempSuspect generateAlibiString:oddFemale suspect2:0];
            }
            
            if ([tempSuspect assignedAlibiType] == 11)
            {
                [tempSuspect generateAlibiString:oddMale suspect2:evenFemale];
            }
        }
        
        // Register alibiCombo at location
        [tempLocation setAlibiCombo:combo_4_8_10_11];
        
        [tempLocation setInitCompleted:YES]; // Flag the Location as completed
    }
}

- (NSString *) askPrivateQuestion: (privateQuestion)questionNumber
                        toSuspect: (int) suspectNumber
{
    // Method Variables
    NSString *answerString;
    NSArray *tempQuestionList;
    BOOL eligibleQuestion = NO;
    EDLocation *tempLocation = [[EDLocation alloc]init];
    
    // Load suspectNumber's PrivateQuestionList
    EDSuspect *tempSuspect = [masterSuspectDirectory objectForKey:[NSString stringWithFormat:@"%d", suspectNumber]];
    tempQuestionList = [tempSuspect suspectPrivateQuestionList];
    
    // Iterate through suspect's PrivateQuestionList testing if requested question is eligible
    for (int i = 0; i < [tempQuestionList count]; i++)
    {
        if ([[tempQuestionList objectAtIndex:i] intValue] == questionNumber)
        {
            eligibleQuestion = YES; // Identified the requested question as a match & eligible
        }
    }
    
    // However, no matter what - if attempting to speak to victim, then must return an error
    if (suspectNumber == victimNumber)
    {
        eligibleQuestion = NO; // Reset to ineligible
    }
    
    // If ineligible question, return error
    if (eligibleQuestion == NO)
    {
        answerString = @"EEE";
    }
    // If yes, process & return answerString
    else if (eligibleQuestion == YES)
    {
        switch (questionNumber)
        {
            case 1: // didMurdererGoEast
                tempLocation = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", murdererLocation]];
                if ([tempLocation locationSide] == 0)
                {
                    answerString = @"YES";
                }
                else if ([tempLocation locationSide] == 1)
                {
                    answerString = @"NO";
                }
                break;
                
            case 2: // isMaleMurderer
                if (murdererNumber < 10)
                {
                    answerString = @"YES"; 
                }
                else if (murdererNumber >= 10)
                {
                    answerString = @"NO";
                }
                break;
                
            case 3: // whatAreaWasMurderer
                tempLocation = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", murdererLocation]];
                if ([tempLocation locationArea] == 0)
                {
                    answerString = @"UPTOWN";
                }
                else if ([tempLocation locationArea] == 1)
                {
                    answerString = @"MIDTOWN";
                }
                else if ([tempLocation locationArea] == 2)
                {
                    answerString = @"DOWNTOWN";
                }
                break;
                
            case 4: // isMurderWeapon38
                if (murderWeapon == 0)
                {
                    answerString = @"YES";
                }
                else if (murderWeapon == 1)
                {
                    answerString = @"NO";
                }
                break;
                
            case 5: // locationOf38
                answerString = [self generateLocationString:locationOf38];
                break;
                
            case 6: // locationOf45
                answerString = [self generateLocationString:locationOf45];
                break;
                
            case 7: // whereIsThreeSuspectLocation
                answerString = [self generateLocationString:threeSuspectLocation];
                break;
            
            case 8: // isMurdererAtABC = 8
                if (murdererLocation < 3)
                {
                    answerString = @"YES";
                }
                else if (murdererLocation >= 3)
                {
                    answerString = @"NO";
                }
                break;

            case 9: // wereYouEast
                tempLocation = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", [tempSuspect suspectLocation]]];
                if ([tempLocation locationSide] == 0)
                {
                    answerString = @"YES";
                }
                else if ([tempLocation locationSide] == 1)
                {
                    answerString = @"NO";
                }
                break;
                
            case 10: // whatWasYourArea
                tempLocation = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", [tempSuspect suspectLocation]]];
                if ([tempLocation locationArea] == 0)
                {
                    answerString = @"UPTOWN";
                }
                else if ([tempLocation locationArea] == 1)
                {
                    answerString = @"MIDTOWN";
                }
                else if ([tempLocation locationArea] == 2)
                {
                    answerString = @"DOWNTOWN";
                }
                break;
                
            case 11: // wereYouAtABC
                if ([tempSuspect suspectLocation] < 3)
                {
                    answerString = @"YES";
                }
                else if ([tempSuspect suspectLocation] >= 3)
                {
                    answerString = @"NO";
                }
                break;
                
            case 12: // wereYouInAWeaponLocation
                if (([tempSuspect suspectLocation] == locationOf38) || ([tempSuspect suspectLocation] == locationOf45))
                {
                    answerString = @"YES";
                }
                else
                {
                    answerString = @"NO";
                }
                break;
                
            case 13: // areOddPrintsOn38
                {
                    if (!([tempSuspect suspectLocation] == locationOf38))
                    {
                        answerString = @"I DON'T KNOW"; // Response if suspect is NOT in .38 weapon location
                    }
                    else if ([tempSuspect suspectLocation] == locationOf38) // If suspect IS in .38 location, process further
                    {
                        // Evaluate and flag correctLocation if the murderWeapon IS .38
                        BOOL correctLocation = NO;
                        
                        if (murderWeapon == 0) // A .38!
                        {
                            correctLocation = YES;
                        }
                        
                        // If correctLocation = NO, then generate a random response
                        if (correctLocation == NO)
                        {
                            int guess = arc4random_uniform(2);
                            if (guess == 0)
                            {
                                answerString = @"YES";
                            }
                            else if (guess == 1)
                            {
                                answerString = @"NO";
                            }
                        }
                        else if (correctLocation == YES) // If suspect IS in correctLocation with murderWeapon, then process further...
                        {
                        
                            // First, evaluate murderer gender
                            BOOL murdererIsMale = '\0';
                            
                            if (murdererNumber < 11)
                            {
                                murdererIsMale = YES;
                            }
                            else if (murdererNumber >= 11)
                            {
                                murdererIsMale = NO;
                            }
                            
                            // Then, evaluate suspect gender
                            BOOL suspectIsMale = '\0';
                            
                            if ([tempSuspect suspectNumber] < 11)
                            {
                                suspectIsMale = YES;
                            }
                            else if ([tempSuspect suspectNumber] >= 11)
                            {
                                suspectIsMale = NO;
                            }
                            
                            // Process result
                            if (suspectIsMale != murdererIsMale) // NON-MATCHING genders, then GUESS randomly
                            {
                                int guess = arc4random_uniform(2);
                                if (guess == 0)
                                {
                                    answerString = @"YES";
                                }
                                else if (guess == 1)
                                {
                                    answerString = @"NO";
                                }
                            }
                            else if (suspectIsMale == murdererIsMale) // MATCHING genders, then generate TRUE/ACCURATE response
                            {
                                if ((murdererNumber + 2) % 2 == 0) // Add 2 to correctly handle 0 or 1 murdererNumber values
                                {
                                    answerString = @"NO"; // Murderer is even
                                }
                                else if ((murdererNumber + 2) % 2 != 0) // Add 2 to correctly handle 0 or 1 murdererNumber values

                                {
                                    answerString = @"YES"; // Murderer is odd
                                }
                            }
                        }
                    }
                }
                break;
            
            case 14: // areOddPrintsOn45
                {
                    if (!([tempSuspect suspectLocation] == locationOf45))
                    {
                        answerString = @"I DON'T KNOW"; // Response if suspect is NOT in .45 weapon location
                    }
                    else if ([tempSuspect suspectLocation] == locationOf45)  // If suspect IS in .45 location, process further
                    {
                                                
                        // Evaluate and flag correctLocation if the murderWeapon IS .45
                        BOOL correctLocation = NO;
                        
                        if (murderWeapon == 1) // A .45!
                        {
                            correctLocation = YES;
                        }
                        
                        // If correctLocation = NO, then generate a random response
                        if (correctLocation == NO)
                        {
                            int guess = arc4random_uniform(2);
                            if (guess == 0)
                            {
                                answerString = @"YES";
                            }
                            else if (guess == 1)
                            {
                                answerString = @"NO";
                            }
                        }
                        else if (correctLocation == YES) // If suspect IS in correctLocation with murderWeapon, then process further...
                        {

                            // First, evaluate murderer gender
                            BOOL murdererIsMale = '\0';
                            
                            if (murdererNumber < 11)
                            {
                                murdererIsMale = YES;
                            }
                            else if (murdererNumber >= 11)
                            {
                                murdererIsMale = NO;
                            }
                            
                            // Then, evaluate suspect gender
                            BOOL suspectIsMale = '\0';
                            
                            if ([tempSuspect suspectNumber] < 11)
                            {
                                suspectIsMale = YES;
                            }
                            else if ([tempSuspect suspectNumber] >= 11)
                            {
                                suspectIsMale = NO;
                            }
                            
                            // Process result
                            if (suspectIsMale != murdererIsMale) // NON-MATCHING genders, then GUESS randomly
                            {
                                int guess = arc4random_uniform(2);
                                if (guess == 0)
                                {
                                    answerString = @"YES";
                                }
                                else if (guess == 1)
                                {
                                    answerString = @"NO";
                                }
                            }
                            else if (suspectIsMale == murdererIsMale) // MATCHING genders, then generate TRUE/ACCURATE response
                            {
                                if ((murdererNumber + 2) % 2 == 0) // Add 2 to correctly handle 0 or 1 murdererNumber values
                                {
                                    answerString = @"NO"; // Murderer is even
                                }
                                else if ((murdererNumber + 2) % 2 != 0) // Add 2 to correctly handle 0 or 1 murdererNumber values
                                    
                                {
                                    answerString = @"YES"; // Murderer is odd
                                }
                            }
                        }
                    }
                }
                break;

            default:
                break;
        }
    }
    
    return answerString;
}

#pragma mark - Helper Methods

- (NSString *)generateLocationString: (location)location
{
    NSString *outputLocationString;
    
    switch (location)
    {
        case 0:
            outputLocationString = @"Art Show";
            break;
        case 1:
            outputLocationString = @"Box At Theatre";
            break;
        case 2:
            outputLocationString = @"Card Party";
            break;
        case 3:
            outputLocationString = @"Docks";
            break;
        case 4:
            outputLocationString = @"Embassy";
            break;
        case 5:
            outputLocationString = @"Factory";
            break;
        default:
            break;
    }
    
    return outputLocationString;
}


- (NSString *)generateWeaponString: (weapon)weapon
{
    NSString *outputWeaponString;
    
    switch (weapon)
    {
        case 0:
            outputWeaponString = @".38";
            break;
        case 1:
            outputWeaponString = @".45";
            break;
        default:
            break;
    }
    
    return outputWeaponString;
}


- (NSString *)generatePrivateQuestionString: (privateQuestion)question
{
    NSString *outputQuestionString;
    
    switch (question)
    {
        case 0:
            outputQuestionString = @"Unassigned";
            break;
        case 1:
            outputQuestionString = @"Did Murderer go the EAST SIDE?";
            break;
        case 2:
            outputQuestionString = @"Did a MALE do it?";
            break;
        case 3:
            outputQuestionString = @"What AREA did the Murderer go to?";
            break;
        case 4:
            outputQuestionString = @"Was the MURDER WEAPON a .38?";
            break;
        case 5:
            outputQuestionString = @"Where was the .38 hidden?";
            break;
        case 6:
            outputQuestionString = @"Where was the .45 hidden?";
            break;
        case 7:
            outputQuestionString = @"Which PLACE contained only 3 suspects?";
            break;
        case 8:
            outputQuestionString = @"Did the murderer go to PLACE A, B or C?";
            break;
        case 9:
            outputQuestionString = @"Were you on the EAST SIDE?";
            break;
        case 10:
            outputQuestionString = @"What AREA were you in?";
            break;
        case 11:
            outputQuestionString = @"Were you at PLACE A,B or C?";
            break;
        case 12:
            outputQuestionString = @"Were you where a WEAPON was hidden?";
            break;
        case 13:
            outputQuestionString = @"Are an odd-numbered suspect's PRINTS on the .38?";
            break;
        case 14:
            outputQuestionString = @"Are an odd-numbered suspect's PRINTS on the .45?";
            break;
        default:
            break;
    }
    
    return outputQuestionString;
}

- (void) printLocationAssignedSuspects
{
    NSLog(@"\r\rLOCATIONS & ASSIGNED SUSPECTS:");
    
    for (int i = 0; i < 6; i++)
    {
        EDLocation *temp = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", i]];
        
        if ([[temp assignedSuspects] count] == 0)
        {
            NSLog(@"\r\rLOCATION #%d - %@ = SCENE OF THE CRIME", i, [temp locationName]);
        }
        else
        {
            NSLog(@"\r\rLOCATION #%d - %@, %@", i, [temp locationName], [temp generateComboString:[temp alibiCombo]]);
        }
        
        for (int j = 0; j < [[temp assignedSuspects] count]; j++)
        {
            EDSuspect *temp2 = [[temp assignedSuspects] objectAtIndex:j];
            NSLog(@"Suspect #%d - %@, SuspectType: %@, Alibi Type: %d", ([temp2 suspectNumber]), [temp2 suspectName], [temp2 generateTypeString:[temp2 suspectType]], [temp2 assignedAlibiType]);
        }
    }
}

- (void) privateQuestionTestRoutine
{
    NSLog(@"\r\rPRIVATE QUESTION TEST");
    
    NSString *answer;
    
    for (int i = 1; i < 21; i++)
    {
        NSLog(@"\r\r");
        
        for (int j = 1; j < 15; j++)
        {
            answer = [self askPrivateQuestion:j toSuspect:i];
            
            EDSuspect *temp = [masterSuspectDirectory objectForKey:[NSString stringWithFormat:@"%d", i]];
            
            if (![answer isEqualToString:@"EEE"])
            {
                NSLog(@"SUSPECT #%d - %@, PQ #%d - %@ %@", [temp suspectNumber], [temp suspectName], j,[self generatePrivateQuestionString:j], answer);
            }
        }
    }
}

- (void) printMasterSuspectDirectory
{
    NSLog(@"PRINTING MASTER SUSPECT DIRECTORY");
    
    for (int i = 1; i < 21; i++)
    {
        EDSuspect *temp = [masterSuspectDirectory objectForKey:[NSString stringWithFormat:@"%d", i]];
        
        NSLog(@"%@\r", [temp description]);
    }
}

@end 
