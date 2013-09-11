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

@synthesize key0, key1, key2, key3, key4, key5, key6, key7, key8, key9, suspect, privateQuestion, iAccuse, enter,endTurn, mainDisplay, currentEntry, currentEntryString, entryCommenced, displayPrivateQuestion, interrogatedSuspected;


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
    
    entryCommenced = NO;
    displayPrivateQuestion = NO;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Main Button methods

- (IBAction)key1pressed:(id)sender
{
    if (entryCommenced) // Suspect key pressed first
    {
        
        if (currentEntry == 1)
        {
            currentEntry = (currentEntry + 9) + 1;
            
            currentEntryString = [NSString stringWithFormat:@"%d", currentEntry];
            mainDisplay.text = currentEntryString;
            
        }
        else if (currentEntry != 11)
        {
            currentEntry = 1;
         
            currentEntryString = [NSString stringWithFormat:@"%d", currentEntry];
            mainDisplay.text = currentEntryString;
        }
        
    }
    
}

- (IBAction)key2pressed:(id)sender
{
    if (entryCommenced) // Suspect key pressed first
    {
        
        if (currentEntry == 0)
        {
            currentEntry = 2;
            
            currentEntryString = [NSString stringWithFormat:@"%d", currentEntry];
            mainDisplay.text = currentEntryString;
            
        }
        else if (currentEntry < 11)
        {
            currentEntry = (currentEntry + 9) + 2;
            
            currentEntryString = [NSString stringWithFormat:@"%d", currentEntry];
            mainDisplay.text = currentEntryString;

        }
    }
}

- (IBAction)suspectPressed:(id)sender
{
    entryCommenced = YES;
    
    NSLog(@"ENTRY COMMENCED");
}

- (IBAction)privateQuestionPressed:(id)sender
{
    displayPrivateQuestion = YES;
    
    mainDisplay.text = @"";
}

- (IBAction)endTurnPressed:(id)sender
{
    currentEntry = 0;
    currentEntryString = @"";
    mainDisplay.text = currentEntryString;
    
    // Reset flags
    entryCommenced = NO;
    displayPrivateQuestion = NO;
    
    NSLog(@"END TURN");
}

- (IBAction)enterPressed:(id)sender
{
    if (!displayPrivateQuestion) // Display Suspect Alibi
    {
        interrogatedSuspected = [[[EDGameStateStore sharedStore] masterSuspectDirectory] objectForKey:[NSString stringWithFormat:@"%d", currentEntry]];
        mainDisplay.text = [interrogatedSuspected suspectAlibi];
        
        // Reset flag
        currentEntry = 0;
    }
    else if (displayPrivateQuestion) // Display Private Question Answer
    {
        NSLog(@"DISPLAY PRIVATE QUESTION ANSWER");
    }
}


@end
