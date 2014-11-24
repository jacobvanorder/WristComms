//
//  InterfaceController.m
//  WristComms WatchKit Extension
//
//  Created by Jonathan Blocksom on 11/22/14.
//  Copyright (c) 2014 Capital One. All rights reserved.
//

#import "InterfaceController.h"

//static NSString *const JBSuiteNameString = @"group.com.capitalone.Watch1";
static NSString *const JBSuiteNameString = @"group.sushiGrass.WatchComms";
static NSString *const JBSuiteDefaultsKeyString = @"message";

@interface InterfaceController()

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *label;

@property (nonatomic) NSUserDefaults *sharedDefaults;
@property (nonatomic) NSString *message;

@end


@implementation InterfaceController

- (instancetype)initWithContext:(id)context {
    self = [super initWithContext:context];
    if (self){
        // Initialize variables here.
        // Configure interface objects here.
        NSLog(@"%@ initWithContext", self);
        
    }
    return self;
}

- (NSString *)sharedMessage {
    NSString *message = [self.sharedDefaults objectForKey:JBSuiteDefaultsKeyString];

    return message;
}

- (void)setMessage:(NSString *)newMessage {
    [self.sharedDefaults setObject:newMessage forKey:JBSuiteDefaultsKeyString];
}

- (IBAction)update {
    // Read NSUserDefaults to get the message
    NSString *msg = self.sharedMessage;
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

    self.sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:JBSuiteNameString];
    
    // Register for notification of changes in defaults
    // This doesn't seem to work yet -- if you change
    // the defaults from the host app the notification
    // does not happen.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(defaultsChanged:)
                                                 name:NSUserDefaultsDidChangeNotification
                                               object:self.sharedDefaults];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);
    self.sharedDefaults = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end



