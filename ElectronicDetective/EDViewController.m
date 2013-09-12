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

#pragma mark - Main Button methods

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
            privateQuestionNumber = 1;
            
            currentEntryString = [NSString stringWithFormat:@"%d", privateQuestionNumber];
            
            mainDisplay.text = currentEntryString;
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
            privateQuestionNumber = 2;
            
            currentEntryString = [NSString stringWithFormat:@"%d", privateQuestionNumber];
            
            mainDisplay.text = currentEntryString;
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
            privateQuestionNumber = 3;
            
            currentEntryString = [NSString stringWithFormat:@"%d", privateQuestionNumber];
            
            mainDisplay.text = currentEntryString;
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
            privateQuestionNumber = 4;
            
            currentEntryString = [NSString stringWithFormat:@"%d", privateQuestionNumber];
            
            mainDisplay.text = currentEntryString;
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
            privateQuestionNumber = 5;
            
            currentEntryString = [NSString stringWithFormat:@"%d", privateQuestionNumber];
            
            mainDisplay.text = currentEntryString;
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
            privateQuestionNumber = 6;
            
            currentEntryString = [NSString stringWithFormat:@"%d", privateQuestionNumber];
            
            mainDisplay.text = currentEntryString;
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
            privateQuestionNumber = 7;
            
            currentEntryString = [NSString stringWithFormat:@"%d", privateQuestionNumber];
            
            mainDisplay.text = currentEntryString;
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
            privateQuestionNumber = 8;
            
            currentEntryString = [NSString stringWithFormat:@"%d", privateQuestionNumber];
            
            mainDisplay.text = currentEntryString;
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
            privateQuestionNumber = 9;
            
            currentEntryString = [NSString stringWithFormat:@"%d", privateQuestionNumber];
            
            mainDisplay.text = currentEntryString;
        }
    }
}


- (IBAction)key0pressed:(id)sender
{
    if (dataEntryInitiated)
    {
        if (!askPrivateQuestion)
        {
            
            [self suspectNumberCounter:0];
            
        }
        else if (askPrivateQuestion)
        {
            privateQuestionNumber = 0;
            
            currentEntryString = [NSString stringWithFormat:@"%d", privateQuestionNumber];
            
            mainDisplay.text = currentEntryString;
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

// TODO: Handle 0 key and suspectNumber = 20
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
}

@end
