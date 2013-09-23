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

@synthesize masterSuspectDirectory, masterLocationDirectory, sceneOfTheCrime, murdererNumber, victimNumber;

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
    
    if (self)
    {
        // Unarchive savedGameArray
        NSString *path = [self itemArchivePath];
        savedGameArray = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        // Restore the EDGameStateStore variables from savedGameArray
        // Objects
        masterSuspectDirectory = [savedGameArray objectAtIndex:0];
        masterLocationDirectory = [savedGameArray objectAtIndex:1];
        suspectNames = [savedGameArray objectAtIndex:2];
        suspectOccupations = [savedGameArray objectAtIndex:3];
        suspectMaritalStatuses = [savedGameArray objectAtIndex:4];
        suspectPrivateQuestionLists = [savedGameArray objectAtIndex:5];
        suspectTypes = [savedGameArray objectAtIndex:6];
        
        // Integers
        murderWeapon = [[savedGameArray objectAtIndex:7] intValue];
        locationOf38 = [[savedGameArray objectAtIndex:8] intValue];
        locationOf45 = [[savedGameArray objectAtIndex:9] intValue];
        threeSuspectLocation = [[savedGameArray objectAtIndex:10] intValue];
        murdererLocation = [[savedGameArray objectAtIndex:11] intValue];
        murdererNumber = [[savedGameArray objectAtIndex:12] intValue];
        victimNumber = [[savedGameArray objectAtIndex:13] intValue];
        sceneOfTheCrime = [[savedGameArray objectAtIndex:14] intValue];
        
        // If EDGameStateStore variables have not been previously saved, create new ones
        // TODO: Need to review

    }
    
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

    suspectPrivateQuestionLists = [[NSArray alloc] initWithObjects: /* Lenny Little #1 */[[NSArray alloc] initWithObjects:num1, num2, num9, num13, num14, nil], /* Al Farook #2 */ [[NSArray alloc] initWithObjects:num2, num3, num9, num13, num14, nil], /* Pepe Perez #3 */ [[NSArray alloc] initWithObjects:num3, num4, num5, num13, num14, nil], /* Tony Racheti #4 */ [[NSArray alloc] initWithObjects:num4, num5, num9, num13, num14, nil], /* Mickey O'Malley #5 */ [[NSArray alloc] initWithObjects:num1, num4, num9, num13, num14, nil], /* Max Fineflugle #6 */ [[NSArray alloc] initWithObjects:num5, num6, num12, num13, num14, nil], /* Rip Rapp #7 */ [[NSArray alloc] initWithObjects:num2, num5, num12, num13, num14, nil], /* Buster Bailey #8 */ [[NSArray alloc] initWithObjects:num3, num5, num12, num13, num14, nil], /* Rocky Roll #9 */ [[NSArray alloc] initWithObjects:num1, num5, num12, num13, num14, nil], /* Ling Tong #10 */ [[NSArray alloc] initWithObjects:num7, num8, num12, num13, num14, nil], /* Ivy Little #11 */ [[NSArray alloc] initWithObjects:num6, num7, num11, num13, num14, nil], /* Lucy Tumble #12 */ [[NSArray alloc] initWithObjects:num2, num6, num11, num13, num14, nil], /* Piper Perez #13 */ [[NSArray alloc] initWithObjects:num3, num7, num11, num13, num14, nil], /* Dina Racheti #14 */ [[NSArray alloc] initWithObjects:num1, num6, num11, num13, num14, nil], /* Eileen Stellar #15 */ [[NSArray alloc] initWithObjects:num4, num7, num11, num13, num14, nil], /* Joan Fineflugle #16 */ [[NSArray alloc] initWithObjects:num6, num8, num10, num13, num14, nil], /* Rose Pettle #17 */ [[NSArray alloc] initWithObjects:num2, num7, num10, num13, num14, nil], /* Doris Dill #18 */ [[NSArray alloc] initWithObjects:num1, num8, num10, num13, num14, nil], /* Candy Roll #19 */ [[NSArray alloc] initWithObjects:num3, num8, num10, num13, num14, nil], /* Sing Wong #20 */ [[NSArray alloc] initWithObjects:num4, num8, num10, num13, num14, nil], nil];
    
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
        [masterLocationDirectory setObject:[[EDLocation alloc] initWithInitialValues: i name:[locationNames objectAtIndex:i]] forKey:[NSString stringWithFormat:@"%d", i]];
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
    EDLocation *murderSite = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"%d", sceneOfTheCrime]];
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
    EDLocation *siteOf38 = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"%d", locationOf38]];
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
    EDLocation *siteOf45 = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"%d", locationOf45]];
    [siteOf45 setLocationOf45:YES];
}

- (void) randomizeSuspectsInCity
{
    
    // Method variables/objects
    EDSuspect *candidateSuspect;
    type candidateType = unassignedType;
    int candidateSuspectNumber;
    BOOL candidateAssigned = NO;
    
    location targetLocationNumber = unassignedLocation;
    EDLocation *targetLocation;
    BOOL successfulAssignment = NO;

    
    // Assign the Victim to the morgue
    EDSuspect *temp = [masterSuspectDirectory objectForKey:[NSString stringWithFormat:@"%d", victimNumber]];
    [temp setSuspectLocation:morgue]; // Assign to the morgue
    [temp setAssignedYet:YES];
    
    // Iterate 19x representing the remaining 19 suspects
    for (int i = 0; i < 19; i++)
    {
        successfulAssignment = NO; // Reset successfulAssignment
        
        do
        {
            // Select a random number between 1 - 20
            candidateSuspectNumber = arc4random_uniform(20) + 1;
            
            // Test if candidate suspect has been assigned yet
            candidateSuspect = [masterSuspectDirectory objectForKey:[NSString stringWithFormat:@"%d", candidateSuspectNumber]];
            candidateAssigned = [candidateSuspect assignedYet];
        }
        while (candidateAssigned == YES); // If candidateAssigned == YES, then repeat do/while
        
        // If candidateAssigned == NO, proceed...
        
        // Evaluate candidateType
        if (candidateSuspectNumber < 11 && ((candidateSuspectNumber + 2) % 2 != 0))
            {
                candidateType = oddMale; // OddMale
            }
        else if (candidateSuspectNumber < 11 && ((candidateSuspectNumber + 2) % 2 == 0))
        {
            candidateType = evenMale; // EvenMale
        }
        else if (candidateSuspectNumber >= 11 && ((candidateSuspectNumber + 2) % 2 != 0))
        {
            candidateType = oddFemale; // OddFemale
        }
        else if (candidateSuspectNumber >= 11 && ((candidateSuspectNumber + 2) % 2 == 0))
        {
            candidateType = evenFemale; // EvenFemale
        }
        
        // Select random targetLocation
        do
        {
            // Randomize and select a targetLocation that is NOT the murderLocation
            do
            {
                targetLocationNumber = arc4random_uniform(6);
                
                targetLocation = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"%d", targetLocationNumber]];
                
            }
            while (targetLocationNumber == sceneOfTheCrime); // Keep looping if targetLocation == sceneOfTheCrime
            
            
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
    EDSuspect *guiltySuspect = [masterSuspectDirectory objectForKey:[NSString stringWithFormat:@"%d", murdererNumber]];
    murdererLocation = [guiltySuspect suspectLocation];
    
    EDLocation *tempLocation = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"%d", murdererLocation]];
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
        EDLocation *testLocation = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"%d", i]];
        
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
        
        EDLocation *candidate = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"%d", i]];
        
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
                    EDLocation *test = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"%d", j]];
                    
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
  
    // Iterate through the 20 suspects and assign values
    for (int i = 0; i < 20; i++)
    {
        tempSuspect = [masterSuspectDirectory objectForKey:[NSString stringWithFormat:@"%d", i + 1]];
        tempLocation = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"%d", [tempSuspect suspectLocation]]];
        [tempSuspect setSuspectSide:[tempLocation locationSide]]; // Register Side
        [tempSuspect setSuspectArea:[tempLocation locationArea]]; // Register Area
    }
}


- (void) assignAlibiTypesToSuspects
{
    // Method Variables
    
    NSArray *tempValues = [[NSArray alloc] init]; // A temp container for routines below
    BOOL proceed; // Loop flag
    int oddMaleSelection;
    int evenMaleSelection;
    int oddFemaleSelection;
    int evenFemaleSelection;
    int threeSuspectChoice = 999;
    
    // First, set the MURDER LOCATION as Init Completed
    
    EDLocation *tempLocation = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"%d", sceneOfTheCrime]];
    [tempLocation setInitCompleted:YES]; // Flag the Location as completed
    
    
    // Then, locate the VICTIM and set his alibiType as unassigned and generate string
    EDSuspect *tempSuspect = [masterSuspectDirectory objectForKey:[NSString stringWithFormat:@"%d", victimNumber]];
    [tempSuspect setAssignedAlibiType:unassignedAlibiType];
    [tempSuspect generateAlibiStringWithSuspect1:0 Suspect2:0];
    
    
    // Then, select the 3-SUSPECT LOCATION & randomly assign either (12,8,7) or (12,8,6) assignedAlibiType values to suspects
    tempLocation = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"%d", threeSuspectLocation]];
    NSMutableArray *tempAssignedSuspects = [tempLocation assignedSuspects];
    
    // Utility setup for the 3 SUSPECT LOCATION Option
    NSArray *threeSuspectOption1Values = [[NSArray alloc] initWithObjects:num12, num8, num7, nil]; // 3 SUSPECT LOCATION - 1ST CHOICE (12,8,7)
    NSArray *threeSuspectOption2Values = [[NSArray alloc] initWithObjects:num12, num8, num6, nil]; // 3 SUSPECT LOCATION - 2ND CHOICE (12,8,6)
    NSArray *masterLocationValues = [[NSArray alloc] initWithObjects:threeSuspectOption1Values, threeSuspectOption2Values, nil]; // Master container for 3 SUSPECT LOCATION values
    
    threeSuspectChoice = arc4random_uniform(2); // Either Option 1 or Option 2 in the masterLocationValues array
     
    for (int i = 0; i < 3; i++)
    {
        proceed = NO;// Reset flag
     
        do
         {
             int candidate = arc4random_uniform(3);
             tempAssignedSuspects = [tempLocation assignedSuspects];
             EDSuspect *tempSuspect = [tempAssignedSuspects objectAtIndex:candidate];
         
             if ([tempSuspect assignedAlibiType] == unassignedAlibiType)
             {
                 tempValues = [masterLocationValues objectAtIndex:threeSuspectChoice]; // Revert to either Option 1 or Option 2
                 [tempSuspect setAssignedAlibiType:[[tempValues objectAtIndex:i] intValue]];
                 proceed = YES;
             }
        }
        while (proceed == NO);
    }
    
    // Generate Alibi Statements
    
    // Helper variables for this specific routine
    int suspectA = 0;
    int suspectB = 0;
    
    for (int j = 0; j < 3; j++)
    {
        for (int i = 0; i < 3; i++)
        {
            tempSuspect = [tempAssignedSuspects objectAtIndex:i];
            
            switch (j)
            {
                case 0: // Look for suspectA with areaAtLocation alibiType - 8 and generate alibiString
                    
                    if ([tempSuspect assignedAlibiType] == areaAtLocation)
                    {
                        [tempSuspect generateAlibiStringWithSuspect1:0 Suspect2:0];
                        
                        suspectA = [tempSuspect suspectNumber];
                    }
                    break;
                    
                case 1: // Look for suspectB with EITHER areaWithSuspect - 6 OR sideWithSuspect - 7 alibiType and generate alibistring with accompanying suspectA
                    
                    if (([tempSuspect assignedAlibiType] == areaWithSuspect) || ([tempSuspect assignedAlibiType] == sideWithSuspect))
                    {
                        [tempSuspect generateAlibiStringWithSuspect1:suspectA Suspect2:0];
                        
                        suspectB = [tempSuspect suspectNumber];
                    }
                    break;
                    
                case 2: // Look for suspectC with sideAreaWithSuspect alibiType - 12 and generate alibiString with accompanying suspectB
                    
                    if ([tempSuspect assignedAlibiType] == sideAreaWithSuspect)
                    {
                        [tempSuspect generateAlibiStringWithSuspect1:suspectB Suspect2:0];
                    }
                    break;
                    
                default:
                    break;
            }
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
    oddMaleSelection = 0;
    evenMaleSelection = 0;
    oddFemaleSelection = 0;
    evenFemaleSelection = 0;
    
    do
    {
        location tempLocationNumber = arc4random_uniform(6);
        
        tempLocation = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"%d", tempLocationNumber]];
        
    }
    while ([tempLocation initCompleted] == YES);
        
    tempAssignedSuspects = [tempLocation assignedSuspects]; // Load the assignedSuspects array
    
    // Assign Type 1 to Odd Female
    for (int i = 0; i < 4; i++)
    {
        EDSuspect *candidate = [tempAssignedSuspects objectAtIndex:i];
        
        if ([candidate suspectType] == oddFemale) // Located Odd Female
        {
            [candidate setAssignedAlibiType:withSuspectAndSuspect];
            
            oddFemaleSelection = [candidate suspectNumber];
        }
    }
    // Assign Type 1 to Even Female
    for (int i = 0; i < 4; i++)
    {
        EDSuspect *candidate = [tempAssignedSuspects objectAtIndex:i];
        
        if ([candidate suspectType] == evenFemale) // Located Even Female
        {
            [candidate setAssignedAlibiType:withSuspectAndSuspect];
            
            evenFemaleSelection = [candidate suspectNumber];
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
        
        if ([candidate assignedAlibiType] == unassignedAlibiType) // Located an unassigned
        {
            int randomRemainingAlibi = arc4random_uniform(2);
            
            switch (randomRemainingAlibi)
            {
                case 0:
                    [candidate setAssignedAlibiType:sideArea];
                    unusedAlibiType = atLocation;
                    proceed = YES;
                    break;
                case 1:
                    [candidate setAssignedAlibiType:atLocation];
                    unusedAlibiType = sideArea;
                    proceed = YES;
                default:
                    break;
            }
            
            // Record the current candidate's type
            if (([candidate suspectNumber] + 2) % 2 == 0)
            {
                evenMaleSelection = [candidate suspectNumber];
            }
            else if (([candidate suspectNumber] + 2) % 2 != 0)
            {
                oddMaleSelection = [candidate suspectNumber];
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
        
        if ([candidate assignedAlibiType] == unassignedAlibiType) // Located final unassigned
        {
            [candidate setAssignedAlibiType:unusedAlibiType];
            
            // Record the current candidate's type
            if (([candidate suspectNumber] + 2) % 2 == 0)
            {
                evenMaleSelection = [candidate suspectNumber];
            }
            else if (([candidate suspectNumber] + 2) % 2 != 0)
            {
                oddMaleSelection = [candidate suspectNumber];
            }
            
            proceed = YES;
        }
    }
    
    // Generate Alibi Statements
    for (int i = 0; i < 4; i++)
    {
        EDSuspect *tempSuspect = [tempAssignedSuspects objectAtIndex:i];
        
        if ([tempSuspect assignedAlibiType] == atLocation)
        {
            [tempSuspect generateAlibiStringWithSuspect1:0 Suspect2:0];
        }
        
        if ([tempSuspect assignedAlibiType] == sideArea)
        {
            [tempSuspect generateAlibiStringWithSuspect1:0 Suspect2:0];
        }

        if ([tempSuspect assignedAlibiType] == withSuspectAndSuspect)
        {
            // Deteremine if odd or even
            if (([tempSuspect suspectNumber] + 2) % 2 == 0) // Even (female)
            {
                [tempSuspect generateAlibiStringWithSuspect1:oddMaleSelection Suspect2:oddFemaleSelection];
            }
            
            if (([tempSuspect suspectNumber] + 2) % 2 != 0) // Odd (female)
            {
                [tempSuspect generateAlibiStringWithSuspect1:evenMaleSelection Suspect2:evenFemaleSelection];
            }
        }
    }

    // Register alibiCombo at location
    [tempLocation setAlibiCombo:combo_1_1_5_4];
    
    [tempLocation setInitCompleted:YES]; // Flag the Location as completed
     
    // Select one of the remaining location as the (5,11,2,6) cluster
    
    // Reset these counters
    oddMaleSelection = 0;
    evenMaleSelection = 0;
    oddFemaleSelection = 0;
    evenFemaleSelection = 0;
    
    do
    {
        location tempLocationNumber = arc4random_uniform(6);
        
        tempLocation = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"%d", tempLocationNumber]];
        
    }
    while ([tempLocation initCompleted] == YES);
    
    tempAssignedSuspects = [tempLocation assignedSuspects]; // Load the assignedSuspects array

    // Assign Type 11 to Even Male
    for (int i = 0; i < 4; i++)
    {
        EDSuspect *candidate = [tempAssignedSuspects objectAtIndex:i];
        
        if ([candidate suspectType] == evenMale) // Located Even Male
        {
            [candidate setAssignedAlibiType:sideWithSuspectAndSuspect];
            
            evenMaleSelection = [candidate suspectNumber];
        }
    }
    // Assign Type 6 to Even Female
    for (int i = 0; i < 4; i++)
    {
        EDSuspect *candidate = [tempAssignedSuspects objectAtIndex:i];
        
        if ([candidate suspectType] == evenFemale) // Located Even Female
        {
            [candidate setAssignedAlibiType:areaWithSuspect];
            
            evenFemaleSelection = [candidate suspectNumber];
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
        
        if ([candidate assignedAlibiType] == unassignedAlibiType) // Located an unassigned
        {
            int randomRemainingAlibi = arc4random_uniform(2);
            
            switch (randomRemainingAlibi)
            {
                case 0:
                    [candidate setAssignedAlibiType:atLocation];
                    unusedAlibiType = areaOnly;
                    proceed = YES;
                    break;
                case 1:
                    [candidate setAssignedAlibiType:areaOnly];
                    unusedAlibiType = atLocation;
                    proceed = YES;
                default:
                    break;
            }
            
            if ([candidate suspectNumber] < 11) // (odd) Male
            {
                oddMaleSelection = [candidate suspectNumber];
            }
            else if ([candidate suspectNumber] >= 11) // (odd) Female
            {
                oddFemaleSelection = [candidate suspectNumber];
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
        
        if ([candidate assignedAlibiType] == unassignedAlibiType) // Located final unassigned
        {
            [candidate setAssignedAlibiType:unusedAlibiType];
            
            if ([candidate suspectNumber] < 11) // (odd) Male
            {
                oddMaleSelection = [candidate suspectNumber];
            }
            else if ([candidate suspectNumber] >= 11) // (odd) Female
            {
                oddFemaleSelection = [candidate suspectNumber];
            }
            
            proceed = YES;
        }
    }
    
    // Generate Alibi Statements
    for (int i = 0; i < 4; i++)
    {
        EDSuspect *tempSuspect = [tempAssignedSuspects objectAtIndex:i];
        
        if ([tempSuspect assignedAlibiType] == areaOnly)
        {
           [tempSuspect generateAlibiStringWithSuspect1:0 Suspect2:0];
        }
        
        if ([tempSuspect assignedAlibiType] == atLocation)
        {
            [tempSuspect generateAlibiStringWithSuspect1:0 Suspect2:0];
        }
        
        if ([tempSuspect assignedAlibiType] == sideWithSuspectAndSuspect)
        {
            [tempSuspect generateAlibiStringWithSuspect1:oddMaleSelection Suspect2:oddFemaleSelection];
        }
        
        if ([tempSuspect assignedAlibiType] == areaWithSuspect)
        {
            [tempSuspect generateAlibiStringWithSuspect1:evenMaleSelection Suspect2:0];
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
        oddMaleSelection = 0;
        evenMaleSelection = 0;
        oddFemaleSelection = 0;
        evenFemaleSelection = 0;
        
        do
        {
            location tempLocationNumber = arc4random_uniform(6);
            
            tempLocation = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"%d", tempLocationNumber]];
            
        }
        while ([tempLocation initCompleted] == YES);
        
        tempAssignedSuspects = [tempLocation assignedSuspects]; // Load the assignedSuspects array
        
        // Assign Type 1 to Odd Female
        for (int i = 0; i < 4; i++)
        {
            EDSuspect *candidate = [tempAssignedSuspects objectAtIndex:i];
            
            if ([candidate suspectType] == oddFemale) // Located Odd Female
            {
                [candidate setAssignedAlibiType:withSuspectAndSuspect];
                
                oddFemaleSelection = [candidate suspectNumber];
            }
        }
        // Assign Type 1 to Even Female
        for (int i = 0; i < 4; i++)
        {
            EDSuspect *candidate = [tempAssignedSuspects objectAtIndex:i];
            
            if ([candidate suspectType] == evenFemale) // Located Even Female
            {
                [candidate setAssignedAlibiType:withSuspectAndSuspect];
                
                evenFemaleSelection = [candidate suspectNumber];
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
            
            if ([candidate assignedAlibiType] == unassignedAlibiType) // Located an unassigned
            {
                int randomRemainingAlibi = arc4random_uniform(2);
                
                switch (randomRemainingAlibi)
                {
                    case 0:
                        [candidate setAssignedAlibiType:areaWithSuspect];
                        unusedAlibiType = sideAtLocation;
                        proceed = YES;
                        break;
                    case 1:
                        [candidate setAssignedAlibiType:sideAtLocation];
                        unusedAlibiType = areaWithSuspect;
                        proceed = YES;
                    default:
                        break;
                }
            
                // Record the current candidate's type
                if (([candidate suspectNumber] +2) % 2 == 0)
                {
                    evenMaleSelection = [candidate suspectNumber];
                }
                else if (([candidate suspectNumber] +2) % 2 != 0)
                {
                    oddMaleSelection = [candidate suspectNumber];
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
            
            if ([candidate assignedAlibiType] == unassignedAlibiType) // Located final unassigned
            {
                [candidate setAssignedAlibiType:unusedAlibiType];
                
                // Record the current candidate's type
                if (([candidate suspectNumber] +2) % 2 == 0)
                {
                    evenMaleSelection = [candidate suspectNumber];
                }
                else if (([candidate suspectNumber] +2) % 2 != 0)
                {
                    oddMaleSelection = [candidate suspectNumber];
                }
                
                proceed = YES;
            }
        }
        
        // Generate Alibi Statements
        for (int i = 0; i < 4; i++)
        {
            EDSuspect *tempSuspect = [tempAssignedSuspects objectAtIndex:i];
            
            if ([tempSuspect assignedAlibiType] == areaWithSuspect)
            {
                [tempSuspect generateAlibiStringWithSuspect1:evenMaleSelection Suspect2:0];
            }
            
            if ([tempSuspect assignedAlibiType] == sideAtLocation)
            {
                [tempSuspect generateAlibiStringWithSuspect1:0 Suspect2:0];
            }
            
            if ([tempSuspect assignedAlibiType] == withSuspectAndSuspect)
            {
                // Deteremine if odd or even
                if (([tempSuspect suspectNumber] + 2) % 2 == 0) // Even (female)
                {
                    // Get the odd male and odd female
                    [tempSuspect generateAlibiStringWithSuspect1:evenMaleSelection Suspect2:oddMaleSelection];
                }
                
                if (([tempSuspect suspectNumber] + 2) % 2 != 0) // Odd (female)
                {
                    // Get the even male and even female
                    [tempSuspect generateAlibiStringWithSuspect1:oddMaleSelection Suspect2:evenFemaleSelection];
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
        oddMaleSelection = 0;
        evenMaleSelection = 0;
        oddFemaleSelection = 0;
        evenFemaleSelection = 0;
        
        do
        {
            location tempLocationNumber = arc4random_uniform(6);
            
            tempLocation = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"%d", tempLocationNumber]];
            
        }
        while ([tempLocation initCompleted] == YES);
        
        tempAssignedSuspects = [tempLocation assignedSuspects]; // Load the assignedSuspects array
        
        // Assign Type 1 to Odd Male
        for (int i = 0; i < 4; i++)
        {
            EDSuspect *candidate = [tempAssignedSuspects objectAtIndex:i];
            
            if ([candidate suspectType] == oddMale) // Located Odd Male
            {
                [candidate setAssignedAlibiType:withSuspectAndSuspect];
                
                oddMaleSelection = [candidate suspectNumber];
            }
        }
        // Assign Type 10 to Even Male
        for (int i = 0; i < 4; i++)
        {
            EDSuspect *candidate = [tempAssignedSuspects objectAtIndex:i];
            
            if ([candidate suspectType] == evenMale) // Located Even Male
            {
                [candidate setAssignedAlibiType:atLocationWithSuspect];
                
                evenMaleSelection = [candidate suspectNumber];
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
            
            if ([candidate assignedAlibiType] == unassignedAlibiType) // Located an unassigned
            {
                int randomRemainingAlibi = arc4random_uniform(2);
                
                switch (randomRemainingAlibi)
                {
                    case 0:
                        [candidate setAssignedAlibiType:areaOnly];
                        unusedAlibiType = sideOnly;
                        proceed = YES;
                        break;
                    case 1:
                        [candidate setAssignedAlibiType:sideOnly];
                        unusedAlibiType = areaOnly;
                        proceed = YES;
                    default:
                        break;
                }
                
                // Record the current candidate's type
                if (([candidate suspectNumber] +2) % 2 == 0)
                {
                    evenFemaleSelection = [candidate suspectNumber];
                }
                else if (([candidate suspectNumber] +2) % 2 != 0)
                {
                    oddFemaleSelection = [candidate suspectNumber];
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
            
            if ([candidate assignedAlibiType] == unassignedAlibiType) // Located final unassigned
            {
                [candidate setAssignedAlibiType:unusedAlibiType];
                
                // Record the current candidate's type
                if (([candidate suspectNumber] +2) % 2 == 0)
                {
                    evenFemaleSelection = [candidate suspectNumber];
                }
                else if (([candidate suspectNumber] +2) % 2 != 0)
                {
                    oddFemaleSelection = [candidate suspectNumber];
                }
                
                proceed = YES;
            }
        }
        
        // Generate Alibi Statements
        for (int i = 0; i < 4; i++)
        {
            EDSuspect *tempSuspect = [tempAssignedSuspects objectAtIndex:i];
            
            if ([tempSuspect assignedAlibiType] == areaOnly)
            {
                [tempSuspect generateAlibiStringWithSuspect1:0 Suspect2:0];
            }
            
            if ([tempSuspect assignedAlibiType] == sideOnly)
            {
                [tempSuspect generateAlibiStringWithSuspect1:0 Suspect2:0];
            }
            
            if ([tempSuspect assignedAlibiType] == atLocationWithSuspect)
            {
                [tempSuspect generateAlibiStringWithSuspect1:oddMaleSelection Suspect2:0];
            }
            
            if ([tempSuspect assignedAlibiType] == withSuspectAndSuspect)
            {
                [tempSuspect generateAlibiStringWithSuspect1:evenFemaleSelection Suspect2:oddFemaleSelection];
            }
        }
        
        // Register alibiCombo at location
        [tempLocation setAlibiCombo:combo_2_10_1_3];
        
        [tempLocation setInitCompleted:YES]; // Flag the Location as completed
    }
    
    
    if ((clusterSelect1 == 2) || (clusterSelect2 == 2)) // the (4,8,10,11) cluster
    {
        // Reset these counters
        oddMaleSelection = 0;
        evenMaleSelection = 0;
        oddFemaleSelection = 0;
        evenFemaleSelection = 0;
        
        do
        {
            location tempLocationNumber = arc4random_uniform(6);
            
            tempLocation = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"%d", tempLocationNumber]];
            
        }
        while ([tempLocation initCompleted] == YES);
        
        tempAssignedSuspects = [tempLocation assignedSuspects]; // Load the assignedSuspects array
        
        // Assign Type 10 to Even Male
        for (int i = 0; i < 4; i++)
        {
            EDSuspect *candidate = [tempAssignedSuspects objectAtIndex:i];
            
            if ([candidate suspectType] == evenMale) // Located Even Male
            {
                [candidate setAssignedAlibiType:atLocationWithSuspect];
                
                evenMaleSelection = [candidate suspectNumber];
            }
        }
        // Assign Type 11 to Odd Female
        for (int i = 0; i < 4; i++)
        {
            EDSuspect *candidate = [tempAssignedSuspects objectAtIndex:i];
            
            if ([candidate suspectType] == oddFemale) // Located Odd Female
            {
                [candidate setAssignedAlibiType:sideWithSuspectAndSuspect];
                
                oddFemaleSelection = [candidate suspectNumber];
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
            
            if ([candidate assignedAlibiType] == unassignedAlibiType) // Located an unassigned
            {
                int randomRemainingAlibi = arc4random_uniform(2);
                
                switch (randomRemainingAlibi)
                {
                    case 0:
                        [candidate setAssignedAlibiType:sideArea];
                        unusedAlibiType = areaAtLocation;
                        proceed = YES;
                        break;
                    case 1:
                        [candidate setAssignedAlibiType:areaAtLocation];
                        unusedAlibiType = sideArea;
                        proceed = YES;
                    default:
                        break;
                }
                
                // Record the current candidate's type
                if (([candidate suspectNumber] +2) % 2 == 0)
                {
                    evenFemaleSelection = [candidate suspectNumber];
                }
                else if (([candidate suspectNumber] +2) % 2 != 0)
                {
                    oddMaleSelection = [candidate suspectNumber];
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
            
            if ([candidate assignedAlibiType] == unassignedAlibiType) // Located final unassigned
            {
                [candidate setAssignedAlibiType:unusedAlibiType];
                
                // Record the current candidate's type
                if (([candidate suspectNumber] +2) % 2 == 0)
                {
                    evenFemaleSelection = [candidate suspectNumber];
                }
                else if (([candidate suspectNumber] +2) % 2 != 0)
                {
                    oddMaleSelection = [candidate suspectNumber];
                }
                
                proceed = YES;
            }
        }
        
        // Generate Alibi Statements
        for (int i = 0; i < 4; i++)
        {
            EDSuspect *tempSuspect = [tempAssignedSuspects objectAtIndex:i];
            
            if ([tempSuspect assignedAlibiType] == sideArea)
            {
                [tempSuspect generateAlibiStringWithSuspect1:0 Suspect2:0];
            }
            
            if ([tempSuspect assignedAlibiType] == areaAtLocation)
            {
                [tempSuspect generateAlibiStringWithSuspect1:0 Suspect2:0];
            }
            
            if ([tempSuspect assignedAlibiType] == atLocationWithSuspect)
            {
                [tempSuspect generateAlibiStringWithSuspect1:oddFemaleSelection Suspect2:0];
            }
            
            if ([tempSuspect assignedAlibiType] == sideWithSuspectAndSuspect)
            {
                [tempSuspect generateAlibiStringWithSuspect1:oddMaleSelection Suspect2:evenFemaleSelection];
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
        answerString = @"EEEEE";
    }
    // If yes, process & return answerString
    else if (eligibleQuestion == YES)
    {
        switch (questionNumber)
        {
            case didMurdererGoEast: // didMurdererGoEast
                tempLocation = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"%d", murdererLocation]];
                if ([tempLocation locationSide] == east)
                {
                    answerString = @"YES";
                }
                else if ([tempLocation locationSide] == west)
                {
                    answerString = @"NO";
                }
                break;
                
            case isMaleMurderer: // isMaleMurderer
                if (murdererNumber <= 10)
                {
                    answerString = @"YES"; 
                }
                else if (murdererNumber >= 11)
                {
                    answerString = @"NO";
                }
                break;
                
            case whatAreaWasMurderer: // whatAreaWasMurderer
                tempLocation = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"%d", murdererLocation]];
                if ([tempLocation locationArea] == uptown)
                {
                    answerString = @"UPTOWN";
                }
                else if ([tempLocation locationArea] == midtown)
                {
                    answerString = @"MIDTOWN";
                }
                else if ([tempLocation locationArea] == downtown)
                {
                    answerString = @"DOWNTOWN";
                }
                break;
                
            case isMurderWeapon38: // isMurderWeapon38
                if (murderWeapon == handgun38)
                {
                    answerString = @"YES";
                }
                else if (murderWeapon == handgun45)
                {
                    answerString = @"NO";
                }
                break;
                
            case whereIs38: // locationOf38
                answerString = [self generateLocationString:locationOf38];
                break;
                
            case whereIs45: // locationOf45
                answerString = [self generateLocationString:locationOf45];
                break;
                
            case whereIsThreeSuspectLocation: // whereIsThreeSuspectLocation
                answerString = [self generateLocationString:threeSuspectLocation];
                break;
            
            case isMurdererAtABC: // isMurdererAtABC
                if (murdererLocation <= 3)
                {
                    answerString = @"YES";
                }
                else if (murdererLocation >= 4)
                {
                    answerString = @"NO";
                }
                break;

            case wereYouEast: // wereYouEast
                tempLocation = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"%d", [tempSuspect suspectLocation]]];
                if ([tempLocation locationSide] == east)
                {
                    answerString = @"YES";
                }
                else if ([tempLocation locationSide] == west)
                {
                    answerString = @"NO";
                }
                break;
                
            case whatWasYourArea: // whatWasYourArea
                tempLocation = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"%d", [tempSuspect suspectLocation]]];
                if ([tempLocation locationArea] == uptown)
                {
                    answerString = @"UPTOWN";
                }
                else if ([tempLocation locationArea] == midtown)
                {
                    answerString = @"MIDTOWN";
                }
                else if ([tempLocation locationArea] == downtown)
                {
                    answerString = @"DOWNTOWN";
                }
                break;
                
            case wereYouAtABC: // wereYouAtABC
                if ([tempSuspect suspectLocation] <= 3)
                {
                    answerString = @"YES";
                }
                else if ([tempSuspect suspectLocation] >= 4)
                {
                    answerString = @"NO";
                }
                break;
                
            case wereYouInAWeaponLocation: // wereYouInAWeaponLocation
                if (([tempSuspect suspectLocation] == locationOf38) || ([tempSuspect suspectLocation] == locationOf45))
                {
                    answerString = @"YES";
                }
                else
                {
                    answerString = @"NO";
                }
                break;
                
            case areOddPrintsOn38: // areOddPrintsOn38
                {
                    if (!([tempSuspect suspectLocation] == locationOf38))
                    {
                        answerString = @"I DON'T KNOW"; // Response if suspect is NOT in .38 weapon location
                    }
                    else if ([tempSuspect suspectLocation] == locationOf38) // If suspect IS in .38 location, process further
                    {
                        // Evaluate and flag correctLocation if the murderWeapon IS .38
                        BOOL correctLocation = NO;
                        
                        if (murderWeapon == handgun38) // A .38!
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
                            
                            if (murdererNumber <= 10)
                            {
                                murdererIsMale = YES;
                            }
                            else if (murdererNumber >= 11)
                            {
                                murdererIsMale = NO;
                            }
                            
                            // Then, evaluate suspect gender
                            BOOL suspectIsMale = '\0';
                            
                            if ([tempSuspect suspectNumber] <= 10)
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
                                if ((murdererNumber + 2) % 2 == 0) // Add 2 to correctly handle 1 murdererNumber value
                                {
                                    answerString = @"NO"; // Murderer is even
                                }
                                else if ((murdererNumber + 2) % 2 != 0) // Add 2 to correctly handle 1 murdererNumber value

                                {
                                    answerString = @"YES"; // Murderer is odd
                                }
                            }
                        }
                    }
                }
                break;
            
            case areOddPrintsOn45: // areOddPrintsOn45
                {
                    if (!([tempSuspect suspectLocation] == locationOf45))
                    {
                        answerString = @"I DON'T KNOW"; // Response if suspect is NOT in .45 weapon location
                    }
                    else if ([tempSuspect suspectLocation] == locationOf45)  // If suspect IS in .45 location, process further
                    {
                                                
                        // Evaluate and flag correctLocation if the murderWeapon IS .45
                        BOOL correctLocation = NO;
                        
                        if (murderWeapon == handgun45) // A .45!
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
                            
                            if (murdererNumber <= 10)
                            {
                                murdererIsMale = YES;
                            }
                            else if (murdererNumber >= 11)
                            {
                                murdererIsMale = NO;
                            }
                            
                            // Then, evaluate suspect gender
                            BOOL suspectIsMale = '\0';
                            
                            if ([tempSuspect suspectNumber] <= 10)
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
                                if ((murdererNumber + 2) % 2 == 0) // Add 2 to correctly handle 1 murdererNumber value
                                {
                                    answerString = @"NO"; // Murderer is even
                                }
                                else if ((murdererNumber + 2) % 2 != 0) // Add 2 to correctly handle 1 murdererNumber value
                                    
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
        case artShow:
            outputLocationString = @"ART SHOW";
            break;
        case boxAtTheatre:
            outputLocationString = @"BOX AT THEATRE";
            break;
        case cardParty:
            outputLocationString = @"CARD PARTY";
            break;
        case docks:
            outputLocationString = @"DOCKS";
            break;
        case embassy:
            outputLocationString = @"EMBASSY";
            break;
        case factory:
            outputLocationString = @"FACTORY";
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
        case handgun38:
            outputWeaponString = @".38";
            break;
        case handgun45:
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
        case unassignedQuestion:
            outputQuestionString = @"UNASSIGNED";
            break;
        case didMurdererGoEast:
            outputQuestionString = @"Did Murderer go the EAST SIDE?";
            break;
        case isMaleMurderer:
            outputQuestionString = @"Did a MALE do it?";
            break;
        case whatAreaWasMurderer:
            outputQuestionString = @"What AREA did the Murderer go to?";
            break;
        case isMurderWeapon38:
            outputQuestionString = @"Was the MURDER WEAPON a .38?";
            break;
        case whereIs38:
            outputQuestionString = @"Where was the .38 hidden?";
            break;
        case whereIs45:
            outputQuestionString = @"Where was the .45 hidden?";
            break;
        case whereIsThreeSuspectLocation:
            outputQuestionString = @"Which PLACE contained only 3 suspects?";
            break;
        case isMurdererAtABC:
            outputQuestionString = @"Did the murderer go to PLACE A, B or C?";
            break;
        case wereYouEast:
            outputQuestionString = @"Were you on the EAST SIDE?";
            break;
        case whatWasYourArea:
            outputQuestionString = @"What AREA were you in?";
            break;
        case wereYouAtABC:
            outputQuestionString = @"Were you at PLACE A,B or C?";
            break;
        case wereYouInAWeaponLocation:
            outputQuestionString = @"Were you where a WEAPON was hidden?";
            break;
        case areOddPrintsOn38:
            outputQuestionString = @"Are an odd-numbered suspect's PRINTS on the .38?";
            break;
        case areOddPrintsOn45:
            outputQuestionString = @"Are an odd-numbered suspect's PRINTS on the .45?";
            break;
        default:
            break;
    }
    
    return outputQuestionString;
}

#pragma mark - Log Methods

- (void) printLocationAssignedSuspects
{
    NSLog(@"\r\rLOCATIONS & ASSIGNED SUSPECTS:");
    
    for (int i = 0; i < 6; i++)
    {
        EDLocation *temp = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"%d", i]];
        
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
    
    for (int i = 1; i <= 20; i++) // Iterate through suspects
    {
        NSLog(@"\r\r");
        
        for (int j = 1; j <= 14; j++) // Iterate through private questions
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
    
    for (int i = 1; i <= 20; i++)
    {
        EDSuspect *temp = [masterSuspectDirectory objectForKey:[NSString stringWithFormat:@"%d", i]];
        
        NSLog(@"%@\r", [temp description]);
    }
}

#pragma mark - Save & Archive Methods

- (NSString *) itemArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
    
}

- (BOOL) saveGame
{
    // Create game save array (Add OBJECTS here w/integers wrapped in NSNumber objects)
    savedGameArray = [[NSMutableArray alloc] initWithObjects:masterSuspectDirectory, masterLocationDirectory, suspectNames, suspectOccupations, suspectMaritalStatuses, suspectPrivateQuestionLists, suspectTypes, [NSNumber numberWithInt:murderWeapon], [NSNumber numberWithInt:locationOf38], [NSNumber numberWithInt:locationOf45], [NSNumber numberWithInt:threeSuspectLocation], [NSNumber numberWithInt:murdererLocation], [NSNumber numberWithInt:murdererNumber], [NSNumber numberWithInt:victimNumber], [NSNumber numberWithInt:sceneOfTheCrime], nil];
    
    NSString *path = [self itemArchivePath];
    
    return [NSKeyedArchiver archiveRootObject:savedGameArray toFile:path];
}


- (void) restartNewGame
{
    // Destroy existing objects & reset variables
    suspectNames = nil;
    suspectOccupations = nil;
    suspectMaritalStatuses = nil;
    suspectPrivateQuestionLists = nil;
    suspectTypes = nil;
    
    masterLocationDirectory = nil;
    masterSuspectDirectory = nil;
    
    victimNumber = 0; // Suspect #0 is unassigned
    murdererNumber = 0; // Suspect #0 is unassigned
    
    murderWeapon = unassignedWeapon;
    locationOf38 = unassignedLocation;
    locationOf45 = unassignedLocation;
    threeSuspectLocation = unassignedLocation;
    murdererLocation = unassignedLocation;
    sceneOfTheCrime = unassignedLocation;
    
    // Destroy game save array & stored file
    savedGameArray = nil;
    NSString *path = [self itemArchivePath];
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    
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
    
}


@end 
