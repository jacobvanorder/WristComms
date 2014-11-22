//
//  InterfaceController.m
//  WristComms WatchKit Extension
//
//  Created by Jonathan Blocksom on 11/22/14.
//  Copyright (c) 2014 Capital One. All rights reserved.
//

#import "InterfaceController.h"


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
    NSString *message = [self.sharedDefaults objectForKey:@"message"];

    return message;
}

- (void)setMessage:(NSString *)newMessage {
    [self.sharedDefaults setObject:newMessage forKey:@"message"];
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
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    NSLog(@"%@ will activate", self);

    self.sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.capitalone.Watch1"];
    
    // Register for notification of changes in defaults
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



