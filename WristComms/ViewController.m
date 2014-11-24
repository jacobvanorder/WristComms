//
//  ViewController.m
//  WristComms
//
//  Created by Jonathan Blocksom on 11/22/14.
//  Copyright (c) 2014 Capital One. All rights reserved.
//

#import "ViewController.h"

//You will have to change this group name string to match your App ID that you have on dev.apple.com.
//static NSString *const JBSuiteNameString = @"group.com.capitalone.Watch1";
static NSString *const JBSuiteNameString = @"group.sushiGrass.WatchComms";
static NSString *const JBSuiteDefaultsKeyString = @"message";
static NSString *const JBFileNameString = @"sharedString.txt";

@interface ViewController() <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *secondaryTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    self.textField.delegate = self;
    [self loadMessage:self];
    [self loadTextFile:self];
}

- (IBAction)loadMessage:(id)sender {
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:JBSuiteNameString];
    NSString *msg = [sharedDefaults objectForKey:JBSuiteDefaultsKeyString];
    self.textField.text = msg;
}

- (IBAction)loadTextFile:(id)sender {
    NSString *message = [NSString stringWithContentsOfFile:[self textFilePath]
                                               encoding:NSUTF8StringEncoding
                                                  error:nil];
    self.secondaryTextField.text = message;
}

- (IBAction)setNewMessage:(id)sender {
    NSLog(@"Setting message to %@", self.textField.text);
    
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:JBSuiteNameString];
    
    [sharedDefaults setObject:self.textField.text forKey:@"message"];
    [sharedDefaults synchronize];
}

- (IBAction)saveTextToAppGroupFile:(id)sender {
    if (self.secondaryTextField.text.length) {
        NSError *stringWriteError = nil;
        if (![self.secondaryTextField.text writeToFile:[self textFilePath]
                                            atomically:YES encoding:NSUTF8StringEncoding
                                                 error:&stringWriteError]) {
            NSLog(@"Something went horribly wrong with saving the string: %@", stringWriteError.localizedDescription);
        }
    }
}

- (NSString *)appGroupPathString {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *container = [fileManager containerURLForSecurityApplicationGroupIdentifier:JBSuiteNameString];
    
    if (![fileManager fileExistsAtPath:container.absoluteString] && container) {
        NSError *creationError = nil;
        if (![fileManager createDirectoryAtURL:container
                   withIntermediateDirectories:YES
                                    attributes:nil
                                         error:&creationError]) {
            NSLog(@"Something went horribly wrong with creating the App Group: %@", creationError.localizedDescription);
        }
    }
    
    return container.relativePath;
}

- (NSString *)textFilePath {
    NSString *appGroupPath = [self appGroupPathString];
    return [appGroupPath stringByAppendingPathComponent:JBFileNameString];
}

@end
