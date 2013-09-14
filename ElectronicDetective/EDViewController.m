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

@synthesize key0, key1, key2, key3, key4, key5, key6, key7, key8, key9, suspect, privateQuestion, iAccuse, enter, endTurn, mainDisplay, suspectNumber, privateQuestionNumber, currentEntryString, dataEntryInitiated, askPrivateQuestion, interrogatedSuspected;


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
    
    interrogatedSuspected = [[EDSuspect alloc] init];
    
    // Reset these flags & variables
    dataEntryInitiated = NO;
    askPrivateQuestion = NO;
    suspectNumber = 0;
    privateQuestionNumber = 0;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Entry Key methods

- (IBAction)key1pressed:(id)sender
{
    if (dataEntryInitiated)
    {
        if (!askPrivateQuestion)
        {
            [self suspectNumberCounter:1];
        }
        else if (askPrivateQuestion)
        {
            [self privateQuestionCounter:1];
        }
    }
}


- (IBAction)key2pressed:(id)sender
{
    if (dataEntryInitiated)
    {
        if (!askPrivateQuestion)
        {
            [self suspectNumberCounter:2];
        }
        else if (askPrivateQuestion)
        {
            [self privateQuestionCounter:2];
        }
    }
}

- (IBAction)key3pressed:(id)sender
{
    if (dataEntryInitiated)
    {
        if (!askPrivateQuestion)
        {
            [self suspectNumberCounter:3];
        }
        else if (askPrivateQuestion)
        {
            [self privateQuestionCounter:3];
        }
    }
}

- (IBAction)key4pressed:(id)sender
{
    if (dataEntryInitiated)
    {
        if (!askPrivateQuestion)
        {
            [self suspectNumberCounter:4];
        }
        else if (askPrivateQuestion)
        {
            [self privateQuestionCounter:4];
        }
    }
}

- (IBAction)key5pressed:(id)sender
{
    if (dataEntryInitiated)
    {
        if (!askPrivateQuestion)
        {
            [self suspectNumberCounter:5];
        }
        else if (askPrivateQuestion)
        {
            [self privateQuestionCounter:5];
        }
    }
}

- (IBAction)key6pressed:(id)sender
{
    if (dataEntryInitiated)
    {
        if (!askPrivateQuestion)
        {
            [self suspectNumberCounter:6];
        }
        else if (askPrivateQuestion)
        {
            [self privateQuestionCounter:6];
        }
    }
}

- (IBAction)key7pressed:(id)sender
{
    if (dataEntryInitiated)
    {
        if (!askPrivateQuestion)
        {
            [self suspectNumberCounter:7];
        }
        else if (askPrivateQuestion)
        {
            [self privateQuestionCounter:7];
        }
    }
}

- (IBAction)key8pressed:(id)sender
{
    if (dataEntryInitiated)
    {
        if (!askPrivateQuestion)
        {
            [self suspectNumberCounter:8];
        }
        else if (askPrivateQuestion)
        {
            [self privateQuestionCounter:8];
        }
    }
}

- (IBAction)key9pressed:(id)sender
{
    if (dataEntryInitiated)
    {
        if (!askPrivateQuestion)
        {
            [self suspectNumberCounter:9];
        }
        else if (askPrivateQuestion)
        {
            [self privateQuestionCounter:9];
        }
    }
}


- (IBAction)key0pressed:(id)sender
{
    if (dataEntryInitiated)
    {
        if (suspectNumber != 0)
        {
            if (!askPrivateQuestion)
            {
                [self suspectNumberCounter:0];
            }
            else if (askPrivateQuestion)
            {
                [self privateQuestionCounter:0];
            }
        }
    }
}



- (IBAction)suspectPressed:(id)sender
{
    dataEntryInitiated = YES;
    
    mainDisplay.text = @"";
    
    NSLog(@"DATA ENTRY INITIATED");
    
}


- (IBAction)privateQuestionPressed:(id)sender
{
    askPrivateQuestion = YES;
    
    mainDisplay.text = @"";
    
    NSLog(@"ASK PRIVATE QUESTION");
}


- (IBAction)iAccusePressed:(id)sender
{
    NSLog(@"I ACCUSE...");
}


- (IBAction)enterPressed:(id)sender
{
    if (dataEntryInitiated)
    {
        
        if (!askPrivateQuestion) // Display Suspect Alibi
        {
            interrogatedSuspected = [[[EDGameStateStore sharedStore] masterSuspectDirectory] objectForKey:[NSString stringWithFormat:@"%d", suspectNumber]];
            
            mainDisplay.text = [NSString stringWithFormat:@"%@ #%d - %@", [[interrogatedSuspected suspectName] uppercaseString], suspectNumber, [interrogatedSuspected suspectAlibi]];
            
        }
        else if (askPrivateQuestion) // Display Private Question Answer
        {
            NSLog(@"DISPLAY PRIVATE QUESTION #%d FOR SUSPECT #%d", privateQuestionNumber, suspectNumber);
            
            mainDisplay.text = [[EDGameStateStore sharedStore] askPrivateQuestion:privateQuestionNumber toSuspect:[interrogatedSuspected suspectNumber]];
        }
    }
}

- (IBAction)endTurnPressed:(id)sender
{
    suspectNumber = 0;
    privateQuestionNumber = 0;
    
    dataEntryInitiated = NO;
    askPrivateQuestion = NO;
    
    currentEntryString = @"";
    mainDisplay.text = currentEntryString;
    
    NSLog(@"END TURN");
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

@end
