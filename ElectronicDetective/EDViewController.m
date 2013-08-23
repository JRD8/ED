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

@end
