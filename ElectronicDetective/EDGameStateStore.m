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

#pragma mark - Init Methods

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
    
    NSLog(@"Master Suspect Directory: %@", [masterSuspectDirectory description]);
    NSLog(@"Master Location Directory: %@", [masterLocationDirectory description]);
    
    return self;
}

- (void) createMasterSuspectDirectory
{
    
    masterSuspectDirectory = [[NSMutableDictionary alloc] init];
    
    // Initial Array Values
    suspectNames = [[NSArray alloc] initWithObjects :@"Lenny Little", @"Al Farook", @"Pepe Perez", @"Tony Racheti", @"Mickey O'Malley", @"Max Fineflugle", @"Ripp Rapp", @"Buster Bailey", @"Rocky Roll", @"Ling Tong", @"Ivy Little", @"Lucy Tumble", @"Piper Perez", @"Dina Racheti", @"Eileen Stellar", @"Joan Fineflugle", @"Rose Pettle", @"Doris Dill", @"Candy Roll", @"Sing Wong", nil];
    
    suspectOccupations = [[NSArray alloc] initWithObjects: @"Bartender", @"Tycoon", @"Flamenco Dancer", @"Promoter", @"Retired Cop", @"Producer", @"Dockworker", @"Basketball Player", @"Musician", @"Restaurant Owner", @"Landlady", @"Secretary", @"Latin Singer", @"Socialite", @"Actress", @"Accountant", @"Gossip Columnist", @"Lady Newscaster", @"Groupie", @"Waitress", nil];
    
    suspectMaritalStatuses = [[NSArray alloc] initWithObjects: @"Married to #11, Ivy Little", @"Playboy", @"Married to #13, Piper Perez", @"Married to #14, Dina Racheti", @"Single", @"Married to #16, Joan Fineflugle", @"Single", @"Single", @"Married to #19, Candy Roll", @"Bachelor", @"Married to #1, Lenny Little", @"Still Looking", @"Married to #3, Pepe Perez", @"Married to #4, Tony Racheti", @"Eligible", @"Married to #6, Max Fineflugle", @"Unattached", @"Not Looking", @"Married to #9, Rocky Roll", @"Single", nil];
    
    
    // Need to wrap ints into NSNumbers for suspectPrivateQuestion & suspectType arrays
    NSNumber *num0 = [NSNumber numberWithInt:0];
    NSNumber *num1 = [NSNumber numberWithInt:1];
    NSNumber *num2 = [NSNumber numberWithInt:2];
    NSNumber *num3 = [NSNumber numberWithInt:3];
    NSNumber *num4 = [NSNumber numberWithInt:4];
    NSNumber *num5 = [NSNumber numberWithInt:5];
    NSNumber *num6 = [NSNumber numberWithInt:6];
    NSNumber *num7 = [NSNumber numberWithInt:7];
    NSNumber *num8 = [NSNumber numberWithInt:8];
    NSNumber *num9 = [NSNumber numberWithInt:9];
    NSNumber *num10 = [NSNumber numberWithInt:10];
    NSNumber *num11= [NSNumber numberWithInt:11];
    NSNumber *num12 = [NSNumber numberWithInt:12];
    NSNumber *num13 = [NSNumber numberWithInt:13];
    NSNumber *num14 = [NSNumber numberWithInt:14];

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

// TODO: Delete Me
/* - (void) randomizeSuspectsInCity
{
    NSLog(@"Randomizing suspects in city, excluding the murder location at %@\n\n", [self generateLocationString:murderLocation]);
    
    NSMutableArray *oddMalesForUse = [[NSMutableArray alloc] init];
    NSMutableArray *evenMalesForUse = [[NSMutableArray alloc] init];
    NSMutableArray *oddFemalesForUse = [[NSMutableArray alloc] init];
    NSMutableArray *evenFemalesForUse = [[NSMutableArray alloc] init];

    // Males
    for (int i = 0; i < 10; i = i + 2)
    {
        [oddMalesForUse addObject:[masterSuspectDirectory objectForKey:[NSString stringWithFormat:@"suspect%d", i + 1]]];
        [evenMalesForUse addObject:[masterSuspectDirectory objectForKey:[NSString stringWithFormat:@"suspect%d", i + 2]]];
    }
    // Females
    for (int i = 10; i < 20; i = i + 2)
    {
        [oddFemalesForUse addObject:[masterSuspectDirectory objectForKey:[NSString stringWithFormat:@"suspect%d", i + 1]]];
        [evenFemalesForUse addObject:[masterSuspectDirectory objectForKey:[NSString stringWithFormat:@"suspect%d", i + 2]]];
    }
    
    // Remove the victim (NB: victimNumber starts at 0 index)
    if ((victimNumber % 2 == 0) && (victimNumber < 10)) // Odd Male
    {
        NSLog(@"Remove ODD MALE");
    }
    else if ((victimNumber % 2 != 0) && (victimNumber < 10)) // Even Male
    {
        NSLog(@"Remove EVEN MALE");
    }
    else if ((victimNumber % 2 == 0) && (victimNumber >= 10)) // Odd Female
    {
        NSLog(@"Remove ODD FEMALE");
    }
    else if ((victimNumber % 2 != 0) && (victimNumber >= 10)) // Even Female
    {
        NSLog(@"Remove EVEN FEMALE");
    }

    
    NSLog(@"Odd Males: %@", oddMalesForUse);
    NSLog(@"Even Males: %@", evenMalesForUse);
    NSLog(@"Odd Females: %@", oddFemalesForUse);
    NSLog(@"Even Females: %@", evenFemalesForUse);
    
    // Start with the 3-Suspect location, exclude murderLocation or location of any weapons
    int tempLocation;
    do
    {
        tempLocation = arc4random_uniform(5);
    }
    while (tempLocation == murderLocation || tempLocation == locationOf38 || tempLocation == locationOf45);
    
    // Flag threeSuspectLocation on EDLocation object
    EDLocation *threelocation = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", tempLocation]];
    [threelocation setThreeSuspectLocation:YES];
    
    NSLog(@"3-Suspect Location = %@\n\n", [threelocation description]);
     
    // Initialize helper variables
    int testSuspectNumber;
    int numberOfSuccessfulTests = 0;
    
    // Create an NSMutableArray of AllocatedSuspectNumbers
    NSMutableArray *allocatedSuspects = [[NSMutableArray alloc] init];
    
    do 
    {
            // Generate a random Suspect Number
            testSuspectNumber = arc4random_uniform(20);
            
            // Test if testSuspect equals the victim?
            if (testSuspectNumber != victimNumber)
            {
                NSLog(@"TestSuspect !=  Victim");
                
                // Test if already an AllocatedSuspect
                int i = [allocatedSuspects count];
                            
                if (i == 0)
                {
                    // First, Allocated Suspects array
                    [allocatedSuspects addObject:[NSNumber numberWithInt:testSuspectNumber]];
                    
                    // Then, Determine Gender...
                    BOOL male;
                    if (testSuspectNumber <=10)
                    {
                        male = YES;
                        NSLog(@"TestSuspect is Male");
                    }
                    else if (testSuspectNumber > 10 && testSuspectNumber <= 20)
                    {
                        male = NO;
                        NSLog(@"TestSuspect is Female");
                    }
                    
                    // Then, Determine Odd/Even
                    BOOL odd;
                    if (testSuspectNumber % 2 != 0)
                    {
                        odd = YES;
                        NSLog(@"TestSuspect is Odd");
                    }
                    else if (testSuspectNumber % 2 == 0)
                    {
                        odd = NO;
                        NSLog(@"TestSuspect is Even");
                    }
                    
                    // Then, add to EDLocation object with correct variable flagged
                    
                    if (male == YES && odd == YES) // Odd Male
                    {
                        [[masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", tempLocation]] setOddMaleSuspect:[masterSuspectDirectory objectForKey:[NSString stringWithFormat:@"suspect%d", testSuspectNumber]]];
                        NSLog(@"Success!!");
                    }
                    else if (male == YES && odd == NO) // Even Male
                    {
                        [[masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", tempLocation]] setEvenMaleSuspect:[masterSuspectDirectory objectForKey:[NSString stringWithFormat:@"suspect%d", testSuspectNumber]]];
                         NSLog(@"Success!!");
                    }
                    else if (male == NO && odd == YES) // Odd Female
                    {
                        [[masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", tempLocation]] setOddFemaleSuspect:[masterSuspectDirectory objectForKey:[NSString stringWithFormat:@"suspect%d", testSuspectNumber]]];
                         NSLog(@"Success!!");
                    }
                    else if (male == NO && odd == NO) // Even Female
                    {
                        [[masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", tempLocation]] setEvenFemaleSuspect:[masterSuspectDirectory objectForKey:[NSString stringWithFormat:@"suspect%d", testSuspectNumber]]];
                         NSLog(@"Success!!");
                    }
                    
                    // Finally, increment numberOfSuccessfulTests by 1
                    numberOfSuccessfulTests ++;
                }
                else
                {
                    for (int j = 0; j < i; j++)
                    {
                        NSNumber *allocatedSuspectNumber = [allocatedSuspects objectAtIndex:j];
                        
                        // Test if already allocated...
                        if (testSuspectNumber != [allocatedSuspectNumber intValue])
                        {
                            NSLog(@"TestSuspect != Allocated Suspect Number");
                            
                            // First, Allocated Suspects array
                            [allocatedSuspects addObject:[NSNumber numberWithInt:testSuspectNumber]];
                            
                            // Then, Determine Gender...
                            BOOL male;
                            if (testSuspectNumber <=10)
                            {
                                male = YES;
                                NSLog(@"TestSuspect is Male");
                            }
                            else if (testSuspectNumber > 10 && testSuspectNumber <= 20)
                            {
                                male = NO;
                                NSLog(@"TestSuspect is Female");
                            }
                            
                            // Then, Determine Odd/Even
                            BOOL odd;
                            if (testSuspectNumber % 2 != 0)
                            {
                                odd = YES;
                                NSLog(@"TestSuspect is Odd");
                            }
                            else if (testSuspectNumber % 2 == 0)
                            {
                                odd = NO;
                                NSLog(@"TestSuspect is Even");
                            }
                            
                            // Then, add to EDLocation object with correct variable flagged
                            
                            if (male == YES && odd == YES) // Odd Male
                            {
                                [[masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", tempLocation]] setOddMaleSuspect:[masterSuspectDirectory objectForKey:[NSString stringWithFormat:@"suspect%d", testSuspectNumber]]];
                                NSLog(@"Success!!");
                            }
                            else if (male == YES && odd == NO) // Even Male
                            {
                                [[masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", tempLocation]] setEvenMaleSuspect:[masterSuspectDirectory objectForKey:[NSString stringWithFormat:@"suspect%d", testSuspectNumber]]];
                                NSLog(@"Success!!");
                            }
                            else if (male == NO && odd == YES) // Odd Female
                            {
                                [[masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", tempLocation]] setOddFemaleSuspect:[masterSuspectDirectory objectForKey:[NSString stringWithFormat:@"suspect%d", testSuspectNumber]]];
                                NSLog(@"Success!!");
                            }
                            else if (male == NO && odd == NO) // Even Female
                            {
                                [[masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", tempLocation]] setEvenFemaleSuspect:[masterSuspectDirectory objectForKey:[NSString stringWithFormat:@"suspect%d", testSuspectNumber]]];
                                NSLog(@"Success!!");
                            }
                            
                            // Finally, increment numberOfSuccessfulTests by 1
                            numberOfSuccessfulTests ++;
                            
                        }
                        else
                        {
                            NSLog(@"TestSuspect = Allocated Suspect Number");
                        };
                    }
                }
            }
            else if (testSuspectNumber == victimNumber)
            {
                NSLog(@"TestSuspect =  Victim");
            };
    }
    while (numberOfSuccessfulTests < 3);
     
    // Then, do the 4 other locations
        
} */

/*- (void) randomizeSuspectsInCity
{
    NSLog(@"\nRandomizing suspects in city, excluding the murder location at %@\n\n", [self generateLocationString:murderLocation]);
    
    // Define helper variables
    location targetLocation;
    EDSuspect *targetSuspect;
    type targetType;
    
    // *A* Iterate through Suspects in the masterSuspectsDirectory
    for (int i = 0; i < 20; i++)
    {
        // Test if targetSuspect = the victim
        if (i != victimNumber) // targetSuspect is NOT the victim & proceed
        {
            targetSuspect = [masterSuspectDirectory objectForKey:[NSString stringWithFormat:@"suspect%d", i + 1]];
            
            NSLog(@"A target suspect: %d - %@", [targetSuspect suspectNumber], [targetSuspect suspectName]);
            
            // *B* 
            targetLocation = arc4random_uniform(6);
            NSLog(@"targetLocation: %@", [self generateLocationString:targetLocation]);
            
            // Test targetLocation
            
            // If targetLocation == murderLocation, return to *B*
            // If targetLocation != murderLocation, then proceed...
            
            // Evaluate the targetSuspect's targetType
            targetType = [targetSuspect suspectType];
            NSLog(@"targetType = %d", targetType);
            
            // Test if that suspectType is available to be filled at targetLocation
            
            // If no, goto *B*
            // If yes, then assign suspect to targetLocation & goto *A*
            
        }
        else if (i == victimNumber) // targetSuspect IS the victim
        {
            // Return to *A*
        }
    }
    
    // Determine and flag the 3-suspect location
}*/

- (void) randomizeSuspectsInCity
{
    // Assign the Victim to the morgue
    EDSuspect *temp = [masterSuspectDirectory objectForKey:[NSString stringWithFormat:@"suspect%d", victimNumber + 1]];
    [temp setSuspectLocation:6]; // Assign to the morgue
    [temp setAssignedYet:YES];
    
    NSLog(@"Assigned victim to the morgue: %@\n", [temp description]);
    
    // Initialize helper variables/objects
    EDSuspect *candidateSuspect = nil;
    type candidateType;
    int candidateSuspectNumber;
    BOOL candidateAssigned = NO;
    
    location targetLocationNumber;
    EDLocation *targetLocation;
    BOOL successfulAssignment = NO;
    
    // Iterate 19x representing the remaining 19 suspects
    for (int i = 0; i < 19; i++)
    {
        
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
            targetLocationNumber = arc4random_uniform(6);
            
            targetLocation = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", targetLocationNumber]];
            
            if ([[targetLocation assignedSuspects] count] == 0) // No assignedSuspects yet
            {
                // Assign Suspect...
                [[targetLocation assignedSuspects] addObject:candidateSuspect]; // Add to EDLocation assignedSuspects NSArray
                [candidateSuspect setAssignedYet:YES]; // Flag on the EDSuspect candidateSuspect object
                successfulAssignment = YES; // Change the successfulAssignment flag to YES
            }
            else if ([[targetLocation assignedSuspects] count] > 0) // Some assignedSuspects already
            {
                // Determine how many existing assignedSuspects at targetLocation
                int numberOfSuspectsAtTargetLocation = [[targetLocation assignedSuspects] count];
                
                EDSuspect *testSuspect;
                type testSuspectType;
                BOOL assignHere = NO;
                
                // Iterate through the number of assignedSuspects at targetLocation and test their suspectType vs. candidateType
                for (int j = 0; j < numberOfSuspectsAtTargetLocation; j++)
                {
                    testSuspect = [[targetLocation assignedSuspects] objectAtIndex:j];
                    testSuspectType = [testSuspect suspectType];
                    
                    // TODO: Fix this loop and finish routine
                    if (testSuspectType == candidateType)
                    {
                        assignHere = NO;
                    }
                    else if (testSuspectType != candidateType)
                    {
                        assignHere = YES;
                    }
                    
                }

            }
        }
        while (successfulAssignment == NO);
        
        NSLog(@"Loop = %d, Candidate Suspect = %d - %@, Candidate Type = %d, Assigned Location = %d", i + 1, [candidateSuspect suspectNumber], [candidateSuspect suspectName], candidateType, targetLocationNumber);
    }
    
}

- (void) identify3SuspectLocation
{
    for (int i = 1; i < 6; i++)
    {
        EDLocation *testLocation = [masterLocationDirectory objectForKey:[NSString stringWithFormat:@"location%d", i]];
        
        if ([[testLocation assignedSuspects] count] == 3)
        {
            NSLog(@"Found 3-Suspect Location at %@", [testLocation locationName]);
            [testLocation setThreeSuspectLocation:YES];
        }
    }
}

- (NSString *)generateLocationString: (location)location
{
    NSString *outputLocationString;
    
    switch (location)
    {
        case 0:
            outputLocationString = @"A - Art Show";
            break;
        case 1:
            outputLocationString = @"B - Box At Theatre";
            break;
        case 2:
            outputLocationString = @"C - Card Party";
            break;
        case 3:
            outputLocationString = @"D - Docks";
            break;
        case 4:
            outputLocationString = @"E - Embassy";
            break;
        case 5:
            outputLocationString = @"F - Factory";
            break;
        default:
            break;
    };
    
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

@end
