//
//  ViewController.m
//  WristComms
//
//  Created by Jonathan Blocksom on 11/22/14.
//  Copyright (c) 2014 Capital One. All rights reserved.
//

#import "ViewController.h"

@interface ViewController() <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    self.textField.delegate = self;
    
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.capitalone.Watch1"];
    [sharedDefaults setObject:@"hello there" forKey:@"message"];
    [sharedDefaults synchronize];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [self setNewMessage:self];
    return YES;
}

- (IBAction)setNewMessage:(id)sender {
    NSLog(@"Setting message to %@", self.textField.text);
    
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.capitalone.Watch1"];
    
    [sharedDefaults setObject:self.textField.text forKey:@"message"];
}

@end
