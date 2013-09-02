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
    [self hideWeapons];
    [self randomizeSuspectsInCity];
    
    [self identify3SuspectLocation];
    [self assignSideAreaToLocation];
    [self assignAlibiTypesToSuspects];
    
    NSLog(@"\rMASTER SUSPECT DIRECTORY: %@\r", [masterSuspectDirectory description]);
    NSLog(@"\rMASTER LOCATION DIRECTORY: %@\r", [masterLocationDirectory description]);
    
    [self printLocationAssignedSuspects];
    
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
        [masterSuspectDirectory setObject:[[EDSuspect alloc] initWithInitialValues:i + 1 suspectType:[[suspectTypes objectAtIndex:i] intValue] name:[suspectNames objectAtIndex:i] occupation:[suspectOccupations objectAtIndex:i] maritalStatus:[suspectMaritalStatuses objectAtIndex:i] privateQuestionList:[suspectPrivateQuestionLists objectAtIndex:i]] forKey:[NSString stringWithFormat:@"suspect%d", i + 1]];
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
    victimNumber = arc4random_uniform(20);
    murderLocation = arc4random_uniform(6);
    murderWeapon = arc4random_uniform(2);

    // Flag victim on EDSuspect object
    EDSuspect *victim = [masterSuspectDirectory objectForKey:[NSString stringWithFormat:@"suspect%d", victimNumber + 1]];
    [victim setVictim:YES];
    
    // Flag location on EDLocation object
    EDLocation *murderSite = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", murderLocation]];
    [murderSite setMurderLocation:YES];
    
    NSLog(@"The Victim Was #%d - %@\nThe body was found at %@\nThe murder weapon was a %@\n\n", [victim suspectNumber], [victim suspectName], [self generateLocationString:murderLocation], [self generateWeaponString:murderWeapon]);
    
}

- (void) assignMurderer
{
    do
    {
        murdererNumber = arc4random_uniform(20);
    }
    while (murdererNumber == victimNumber);
    
    // Flag murderer on EDSuspect object
    EDSuspect *murderer = [masterSuspectDirectory objectForKey:[NSString stringWithFormat:@"suspect%d", murdererNumber + 1]];
    [murderer setMurderer:YES];
    
    NSLog(@"The Murderer is #%d - %@\n", [murderer suspectNumber], [murderer suspectName]);

}

- (void) hideWeapons
{
    
    // First, hide the .38
    do
    {
        locationOf38 = arc4random_uniform(6);
        
        NSString *locationOf38String = [self generateLocationString:locationOf38];
        
        NSLog(@"Hiding the .38 at %@\n", locationOf38String);
    }
    while (locationOf38 == murderLocation);
    
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
    while (locationOf45 == murderLocation || locationOf45 == locationOf38);
    
    // Flag location of .45 on EDLocation object
    EDLocation *siteOf45 = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", locationOf45]];
    [siteOf45 setLocationOf45:YES];
}


- (void) randomizeSuspectsInCity
{
    // Assign the Victim to the morgue
    EDSuspect *temp = [masterSuspectDirectory objectForKey:[NSString stringWithFormat:@"suspect%d", victimNumber + 1]];
    [temp setSuspectLocation:6]; // Assign to the morgue
    [temp setAssignedYet:YES];
    
    // Initialize helper variables/objects
    EDSuspect *candidateSuspect;
    type candidateType;
    int candidateSuspectNumber;
    BOOL candidateAssigned = NO;
    
    location targetLocationNumber;
    EDLocation *targetLocation;
    BOOL successfulAssignment;
    
    // Iterate 19x representing the remaining 19 suspects
    for (int i = 0; i < 19; i++)
    {
        successfulAssignment = NO; // Reset successfulAssignment
        
        do
        {
            // Select a random number between 0 - 19
            candidateSuspectNumber = arc4random_uniform(20);
            
            // Test if candidate suspect has been assigned yet
            candidateSuspect = [masterSuspectDirectory objectForKey:[NSString stringWithFormat:@"suspect%d", candidateSuspectNumber + 1]];
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
            while (targetLocationNumber == murderLocation); // Keep looping if targetLocation == murderLocation
            
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
        tempSuspect = [masterSuspectDirectory objectForKey:[NSString stringWithFormat:@"suspect%d", i]];
        tempLocation = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", [tempSuspect suspectLocation]]];
        [tempSuspect setSuspectSide:[tempLocation locationSide]]; // Register Side
        [tempSuspect setSuspectArea:[tempLocation locationArea]]; // Register Area
    }
}


- (void) assignAlibiTypesToSuspects
{
    // Utility setup
    
    NSArray *tempValues = [[NSArray alloc] init]; // A temp container for routines below
    BOOL proceed; // Loop flag
    
    
    // First, set the MURDER LOCATION as Init Completed
    
    EDLocation *tempLocation = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", murderLocation]];
    [tempLocation setInitCompleted:YES]; // Flag the Location as completed

    
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
        
    [tempLocation setInitCompleted:YES]; // Flag the Location as completed

    
    // Select one of the remaining location as the (1,1,4,5) cluster
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
        }
    }
    // Assign Type 1 to Even Female
    for (int i = 0; i < 4; i++)
    {
        EDSuspect *candidate = [tempAssignedSuspects objectAtIndex:i];
        
        if ([candidate suspectType] == 3) // Located Even Female
        {
            [candidate setAssignedAlibiType:1];
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
            proceed = YES;
        }
    }
    
    [tempLocation setInitCompleted:YES]; // Flag the Location as completed

    
    // Select one of the remaining location as the (5,11,2,6) cluster
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
        }
    }
    // Assign Type 6 to Even Female
    for (int i = 0; i < 4; i++)
    {
        EDSuspect *candidate = [tempAssignedSuspects objectAtIndex:i];
        
        if ([candidate suspectType] == 3) // Located Even Female
        {
            [candidate setAssignedAlibiType:6];
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
            proceed = YES;
        }
    }
    
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
            }
        }
        // Assign Type 1 to Even Female
        for (int i = 0; i < 4; i++)
        {
            EDSuspect *candidate = [tempAssignedSuspects objectAtIndex:i];
            
            if ([candidate suspectType] == 3) // Located Even Female
            {
                [candidate setAssignedAlibiType:1];
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
                proceed = YES;
            }
        }
        
        [tempLocation setInitCompleted:YES]; // Flag the Location as completed
    }
    
    if ((clusterSelect1 == 1) || (clusterSelect2 == 1)) // the (2,10,1,3) cluster
    {
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
            }
        }
        // Assign Type 10 to Even Male
        for (int i = 0; i < 4; i++)
        {
            EDSuspect *candidate = [tempAssignedSuspects objectAtIndex:i];
            
            if ([candidate suspectType] == 1) // Located Even Male
            {
                [candidate setAssignedAlibiType:10];
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
                proceed = YES;
            }
        }
        
        [tempLocation setInitCompleted:YES]; // Flag the Location as completed
    }
    
    if ((clusterSelect1 == 2) || (clusterSelect2 == 2)) // the (4,8,10,11) cluster
    {
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
            }
        }
        // Assign Type 11 to Odd Female
        for (int i = 0; i < 4; i++)
        {
            EDSuspect *candidate = [tempAssignedSuspects objectAtIndex:i];
            
            if ([candidate suspectType] == 2) // Located Odd Female
            {
                [candidate setAssignedAlibiType:11];
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
                proceed = YES;
            }
        }
        
        [tempLocation setInitCompleted:YES]; // Flag the Location as completed
    }
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
        default:
            break;
    }
    
    return outputWeaponString;
}

- (void) printLocationAssignedSuspects
{
    NSLog(@"\r\rLOCATIONS & ASSIGNED SUSPECTS:");
    
    for (int i = 0; i < 6; i++)
    {
        EDLocation *temp = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", i]];
        
        if ([[temp assignedSuspects] count] == 0)
        {
            NSLog(@"\rLOCATION #%d - %@ = MURDER LOCATION", i, [temp locationName]);
        }
        else
        {
            NSLog(@"\rLOCATION #%d - %@", i, [temp locationName]);
        }
        
        for (int j = 0; j < [[temp assignedSuspects] count]; j++)
        {
            EDSuspect *temp2 = [[temp assignedSuspects] objectAtIndex:j];
            NSLog(@"Suspect #%d - %@, SuspectType: %@, Alibi Type: %d", ([temp2 suspectNumber]), [temp2 suspectName], [temp2 generateTypeString:[temp2 suspectType]], [temp2 assignedAlibiType]);
        }
    }
}

@end
