//
//  ViewController.m
//  WristComms
//
//  Created by Jonathan Blocksom on 11/22/14.
//  Copyright (c) 2014 Capital One. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.capitalone.Watch1"];
    [sharedDefaults setObject:@"hello there" forKey:@"message"];
    [sharedDefaults synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
