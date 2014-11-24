//
//  FileManagerController.m
//  WristComms
//
//  Created by mrJacob on 11/24/14.
//  Copyright (c) 2014 Capital One. All rights reserved.
//

#import "FileManagerController.h"

//static NSString *const JBSuiteNameString = @"group.com.capitalone.Watch1";
static NSString *const JBSuiteNameString = @"group.sushiGrass.WatchComms";
static NSString *const JBFileNameString = @"sharedString.txt";

@interface FileManagerController ()

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *label;

@end

@implementation FileManagerController

- (NSString *)sharedMessage {
    NSError *stringReadError = nil;
    NSString *messageString = [NSString stringWithContentsOfFile:[self textFilePath]
                                                        encoding:NSUTF8StringEncoding
                                                           error:&stringReadError];
    if (!messageString && stringReadError) {
        NSLog(@"Something went horribly wrong reading that string: %@", stringReadError.localizedDescription);
    }
    return messageString;
}

- (void)setMessage:(NSString *)newMessage {
    [newMessage writeToFile:[self textFilePath]
                 atomically:YES
                   encoding:NSUTF8StringEncoding
                      error:NULL];
}

- (IBAction)update {
    // Read NSUserDefaults to get the message
    NSString *msg = [self sharedMessage];
    NSLog(@"Message is %@", msg);
    self.label.text = msg;
}

- (IBAction)changeMessage {
    NSString *msg = self.sharedMessage;
    NSString *newMsg = [msg stringByAppendingString:@"+"];
    self.message = newMsg;
    [self update];
}

- (void)defaultsChanged:(NSNotification *)info
{
    NSLog(@"Defaults changed");
    [self update];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    NSLog(@"%@ will activate", self);
    [self update];
}

- (NSString *)appGroupPathString {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *container = [fileManager containerURLForSecurityApplicationGroupIdentifier:JBSuiteNameString];
    return container.relativePath;
}

- (NSString *)textFilePath {
    NSString *appGroupPath = [self appGroupPathString];
    return [appGroupPath stringByAppendingPathComponent:JBFileNameString];
}

@end
