//
//  EDViewController.h
//  ElectronicDetective
//
//  Created by James Diener on 8/22/13.
//  Copyright (c) 2013 James Diener. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    newTurn = 0,
    suspectPressed = 1,
    privateQuestionPressed = 2,
    iAccusePressed = 3,
        
} status;


@class EDSuspect;

@interface EDViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *key1;
@property (weak, nonatomic) IBOutlet UIButton *key2;
@property (weak, nonatomic) IBOutlet UIButton *key3;
@property (weak, nonatomic) IBOutlet UIButton *key4;
@property (weak, nonatomic) IBOutlet UIButton *key5;
@property (weak, nonatomic) IBOutlet UIButton *key6;
@property (weak, nonatomic) IBOutlet UIButton *key7;
@property (weak, nonatomic) IBOutlet UIButton *key8;
@property (weak, nonatomic) IBOutlet UIButton *key9;
@property (weak, nonatomic) IBOutlet UIButton *key0;

@property (weak, nonatomic) IBOutlet UIButton *suspect;
@property (weak, nonatomic) IBOutlet UIButton *privateQuestion;
@property (weak, nonatomic) IBOutlet UIButton *iAccuse;
@property (weak, nonatomic) IBOutlet UIButton *enter;
@property (weak, nonatomic) IBOutlet UIButton *endTurn;
@property (weak, nonatomic) IBOutlet UIButton *restartGame;

@property (weak, nonatomic) IBOutlet UILabel *mainDisplay;

@property (nonatomic, strong) EDSuspect *interrogatedSuspected;

// Data entry variables
@property int suspectNumber;
@property int privateQuestionNumber;

@property (nonatomic, strong) NSString *currentEntryString;

@property status buttonStatus;


- (IBAction)key1pressed:(id)sender;
- (IBAction)key2pressed:(id)sender;
- (IBAction)key3pressed:(id)sender;
- (IBAction)key4pressed:(id)sender;
- (IBAction)key5pressed:(id)sender;
- (IBAction)key6pressed:(id)sender;
- (IBAction)key7pressed:(id)sender;
- (IBAction)key8pressed:(id)sender;
- (IBAction)key9pressed:(id)sender;
- (IBAction)key0pressed:(id)sender;

- (IBAction)suspectPressed:(id)sender;
- (IBAction)privateQuestionPressed:(id)sender;
- (IBAction)iAccusePressed:(id)sender;
- (IBAction)enterPressed:(id)sender;
- (IBAction)endTurnPressed:(id)sender;
- (IBAction)restartGamePressed:(id)sender;

- (void) suspectNumberCounter: (int) keyNumber;
- (void) privateQuestionCounter: (int) keyNumber;
- (void) iAccuseCounter: (int) keyNumber;


@end
