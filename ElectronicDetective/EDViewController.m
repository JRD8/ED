//
//  EDViewController.m
//  ElectronicDetective
//
//  Created by James Diener on 8/22/13.
//  Copyright (c) 2013 James Diener. All rights reserved.
//

#import "EDViewController.h"
#import "EDGameStateStore.h"

@interface EDViewController ()

@end

@implementation EDViewController

@synthesize key0, key1, key2, key3, key4, key5, key6, key7, key8, key9, suspect, privateQuestion, iAccuse, enter,endTurn, mainDisplay;


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

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Main Button methods

- (IBAction)key1pressed:(id)sender
{
    mainDisplay.text = @"1";
}

@end
