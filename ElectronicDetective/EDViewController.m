//
//  EDViewController.m
//  ElectronicDetective
//
//  Created by James Diener on 8/22/13.
//  Copyright (c) 2013 James Diener. All rights reserved.
//

#import "EDViewController.h"
#import "EDGameStateStore.h"
#import "EDTypedefEnums.h"
#import "EDSuspect.h"
#import "EDLocation.h"

@interface EDViewController ()

@end

@implementation EDViewController

@synthesize key0, key1, key2, key3, key4, key5, key6, key7, key8, key9, suspect, privateQuestion, iAccuse, enter, endTurn, mainDisplay, suspectNumber, privateQuestionNumber, currentEntryString, buttonStatus, interrogatedSuspected;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSBundle *appBundle = [NSBundle mainBundle];
    
    self = [super initWithNibName:@"EDMainConsole" bundle:appBundle];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [EDGameStateStore sharedStore]; // Create a new Store or load a saved Store
    
    // [[EDGameStateStore sharedStore] restartNewGame];
    
    interrogatedSuspected = [[EDSuspect alloc] init];
    
    // Reset these flags & variables
    buttonStatus = newTurn;
    suspectNumber = 0;
    privateQuestionNumber = 0;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


#pragma mark - Entry Key methods


- (IBAction)key1pressed:(id)sender
{
    
    switch (buttonStatus)
    {
        case suspectPressed:
            [self suspectNumberCounter:1];
            break;
        
        case privateQuestionPressed:
            [self privateQuestionCounter:1];
            break;
            
        case iAccusePressed:
            [self iAccuseCounter:1];
            break;
            
        default:
            break;
    }
}


- (IBAction)key2pressed:(id)sender
{
    
    switch (buttonStatus)
    {
        case suspectPressed:
            [self suspectNumberCounter:2];
            break;
            
        case privateQuestionPressed:
            [self privateQuestionCounter:2];
            break;
            
        case iAccusePressed:
            [self iAccuseCounter:2];
            break;
            
        default:
            break;
    }
}


- (IBAction)key3pressed:(id)sender
{
    
    switch (buttonStatus)
    {
        case suspectPressed:
            [self suspectNumberCounter:3];
            break;
            
        case privateQuestionPressed:
            [self privateQuestionCounter:3];
            break;
            
        case iAccusePressed:
            [self iAccuseCounter:3];
            break;
            
        default:
            break;
    }
}


- (IBAction)key4pressed:(id)sender
{
    switch (buttonStatus)
    {
        case suspectPressed:
            [self suspectNumberCounter:4];
            break;
            
        case privateQuestionPressed:
            [self privateQuestionCounter:4];
            break;
            
        case iAccusePressed:
            [self iAccuseCounter:4];
            break;
            
        default:
            break;
    }
}


- (IBAction)key5pressed:(id)sender
{
    switch (buttonStatus)
    {
        case suspectPressed:
            [self suspectNumberCounter:5];
            break;
            
        case privateQuestionPressed:
            [self privateQuestionCounter:5];
            break;
            
        case iAccusePressed:
            [self iAccuseCounter:5];
            break;
            
        default:
            break;
    }
}


- (IBAction)key6pressed:(id)sender
{
    switch (buttonStatus)
    {
        case suspectPressed:
            [self suspectNumberCounter:6];
            break;
            
        case privateQuestionPressed:
            [self privateQuestionCounter:6];
            break;
            
        case iAccusePressed:
            [self iAccuseCounter:6];
            break;
            
        default:
            break;
    }
}


- (IBAction)key7pressed:(id)sender
{
    
    switch (buttonStatus)
    {
        case suspectPressed:
            [self suspectNumberCounter:7];
            break;
            
        case privateQuestionPressed:
            [self privateQuestionCounter:7];
            break;
            
        case iAccusePressed:
            [self iAccuseCounter:7];
            break;
            
        default:
            break;
    }
}


- (IBAction)key8pressed:(id)sender
{
    
    switch (buttonStatus)
    {
        case suspectPressed:
            [self suspectNumberCounter:8];
            break;
            
        case privateQuestionPressed:
            [self privateQuestionCounter:8];
            break;
            
        case iAccusePressed:
            [self iAccuseCounter:8];
            break;
            
        default:
            break;
    }
}


- (IBAction)key9pressed:(id)sender
{
    switch (buttonStatus)
    {
        case suspectPressed:
            [self suspectNumberCounter:9];
            break;
            
        case privateQuestionPressed:
            [self privateQuestionCounter:9];
            break;
            
        case iAccusePressed:
            [self iAccuseCounter:9];
            break;
            
        default:
            break;
    }
}


- (IBAction)key0pressed:(id)sender
{
    switch (buttonStatus)
    {
        case suspectPressed:
            [self suspectNumberCounter:0];
            break;
            
        case privateQuestionPressed:
            [self privateQuestionCounter:0];
            break;
            
        case iAccusePressed:
            [self iAccuseCounter:0];
            break;
            
        default:
            break;
    }
}


#pragma mark - Main Button Methods


- (IBAction)suspectPressed:(id)sender
{
    buttonStatus = suspectPressed;
    
    mainDisplay.text = @"";
    
    NSLog(@"SUSPECT BUTTON INITIATED");
    
}


- (IBAction)privateQuestionPressed:(id)sender
{
    buttonStatus = privateQuestionPressed;
    
    mainDisplay.text = @"";
    
    NSLog(@"ASK PRIVATE QUESTION");
}


- (IBAction)iAccusePressed:(id)sender
{
    buttonStatus = iAccusePressed;
    
    mainDisplay.text = @"";
    
    NSLog(@"I ACCUSE...");
}


- (IBAction)enterPressed:(id)sender
{
    NSLog(@"Enter Button at %d", buttonStatus);
    
    NSString *outputString;
    
    switch (buttonStatus)
    {
        case newTurn:
            break;
            
        case suspectPressed:
            interrogatedSuspected = [[[EDGameStateStore sharedStore] masterSuspectDirectory] objectForKey:[NSString stringWithFormat:@"%d", suspectNumber]];
            mainDisplay.text = [NSString stringWithFormat:@"%@ #%d - %@", [[interrogatedSuspected suspectName] uppercaseString], suspectNumber, [interrogatedSuspected suspectAlibi]];
            break;
            
        case privateQuestionPressed:
            NSLog(@"DISPLAY PRIVATE QUESTION #%d FOR SUSPECT #%d", privateQuestionNumber, suspectNumber);
            
            outputString = [NSString stringWithFormat:@"%@ %@", [[EDGameStateStore sharedStore] generatePrivateQuestionString:privateQuestionNumber], [[EDGameStateStore sharedStore] askPrivateQuestion:privateQuestionNumber toSuspect:[interrogatedSuspected suspectNumber]]];
            mainDisplay.text = outputString;
            break;
            
        case iAccusePressed:
            if (suspectNumber == [[EDGameStateStore sharedStore] murdererNumber])
            {
                interrogatedSuspected = [[[EDGameStateStore sharedStore] masterSuspectDirectory] objectForKey:[NSString stringWithFormat:@"%d", suspectNumber]];
                mainDisplay.text = [NSString stringWithFormat: @"CORRECT - YOU WIN %@ #%d IS THE MURDERER!", [interrogatedSuspected suspectName], [interrogatedSuspected suspectNumber]];
            }
            else
            {
                mainDisplay.text = @"INCORRECT - YOU LOSE";
            }
            break;
            
        default:
            break;
    }
}


- (IBAction)endTurnPressed:(id)sender
{
    suspectNumber = 0;
    privateQuestionNumber = 0;
    
    buttonStatus = newTurn;
    currentEntryString = @"";
    mainDisplay.text = currentEntryString;
    
    NSLog(@"END TURN");
}

- (IBAction)restartGamePressed:(id)sender
{
    NSLog(@"\r\r\rRESTART GAME");
    
    [[EDGameStateStore sharedStore] initializeNewGame];
    
    [self displayInitialCrimeInfo];
   
}


#pragma mark - Helper Methods


- (void) suspectNumberCounter: (int) keyNumber
{
    if (suspectNumber == 0)
    {
        suspectNumber = keyNumber;
        
        currentEntryString = [NSString stringWithFormat:@"%d", suspectNumber];
        
        mainDisplay.text = currentEntryString;
        
        NSLog(@"SUSPECT NUMBER IS NOW %d", suspectNumber);
    }
    else if (suspectNumber == 1)
    {
        suspectNumber = 10 + keyNumber;
        
        currentEntryString = [NSString stringWithFormat:@"%d", suspectNumber];
        
        mainDisplay.text = currentEntryString;
        
        NSLog(@"SUSPECT NUMBER IS NOW %d", suspectNumber);
    }
    else if (suspectNumber == 2)
    {
        suspectNumber = 20 + keyNumber;
        
        if (suspectNumber < 21)
        {
        
            currentEntryString = [NSString stringWithFormat:@"%d", suspectNumber];
            
            mainDisplay.text = currentEntryString;
            
            NSLog(@"SUSPECT NUMBER IS NOW %d", suspectNumber);
            
        }
        else
        {
            suspectNumber = 2;
            
            currentEntryString = [NSString stringWithFormat:@"%d", suspectNumber];
            
            mainDisplay.text = currentEntryString;
            
            NSLog(@"SUSPECT NUMBER IS NOW %d", suspectNumber);
            
        }
    }
}


- (void) privateQuestionCounter: (int) keyNumber
{
    
    if (privateQuestionNumber == 0)
    {
        privateQuestionNumber = keyNumber;
        
        currentEntryString = [NSString stringWithFormat:@"%d", privateQuestionNumber];
        
        mainDisplay.text = currentEntryString;
        
        NSLog(@"PRIVATE QUESTION NUMBER IS NOW %d", privateQuestionNumber);
    }
    else if (privateQuestionNumber == 1)
    {
        privateQuestionNumber = 10 + keyNumber;
        
        if (privateQuestionNumber < 15)
        {
            
            currentEntryString = [NSString stringWithFormat:@"%d", privateQuestionNumber];
            
            mainDisplay.text = currentEntryString;
            
            NSLog(@"PRIVATE QUESTION NUMBER IS NOW %d", privateQuestionNumber);
            
        }
        else
        {
            privateQuestionNumber = 1;
            
            currentEntryString = [NSString stringWithFormat:@"%d", privateQuestionNumber];
            
            mainDisplay.text = currentEntryString;
            
            NSLog(@"PRIVATE QUESTION NUMBER IS NOW %d", privateQuestionNumber);
        }
    }
}


- (void) iAccuseCounter: (int) keyNumber
{
    
    if (suspectNumber == 0)
    {
        suspectNumber = keyNumber;
        
        currentEntryString = [NSString stringWithFormat:@"%d", suspectNumber];
        
        mainDisplay.text = currentEntryString;
        
        NSLog(@"SUSPECT NUMBER IS NOW %d", suspectNumber);
    }
    else if (suspectNumber == 1)
    {
        suspectNumber = 10 + keyNumber;
        
        currentEntryString = [NSString stringWithFormat:@"%d", suspectNumber];
        
        mainDisplay.text = currentEntryString;
        
        NSLog(@"SUSPECT NUMBER IS NOW %d", suspectNumber);
    }
    else if (suspectNumber == 2)
    {
        suspectNumber = 20 + keyNumber;
        
        if (suspectNumber < 21)
        {
            
            currentEntryString = [NSString stringWithFormat:@"%d", suspectNumber];
            
            mainDisplay.text = currentEntryString;
            
            NSLog(@"SUSPECT NUMBER IS NOW %d", suspectNumber);
            
        }
        else
        {
            suspectNumber = 2;
            
            currentEntryString = [NSString stringWithFormat:@"%d", suspectNumber];
            
            mainDisplay.text = currentEntryString;
            
            NSLog(@"SUSPECT NUMBER IS NOW %d", suspectNumber);
            
        }
    }
}

- (void) displayInitialCrimeInfo
{
    int victimNumber = [[EDGameStateStore sharedStore] victimNumber];
    int sceneOfTheCrime = [[EDGameStateStore sharedStore] sceneOfTheCrime];
    
    EDSuspect *victim = [[[EDGameStateStore sharedStore] masterSuspectDirectory] objectForKey:[NSString stringWithFormat:@"%d", victimNumber ]];
    
    currentEntryString = [NSString stringWithFormat:@"The VICTIM was #%d - %@ found at %@", victimNumber, [[victim suspectName] uppercaseString], [[[EDGameStateStore sharedStore] generateLocationString: sceneOfTheCrime] uppercaseString]];
    
    mainDisplay.text = currentEntryString;
}

@end
