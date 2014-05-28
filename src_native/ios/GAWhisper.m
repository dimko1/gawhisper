//
//  GAWhisper.m
//  Implementation file for GA plugin
//
//  Created by Dima Maleev on 5/28/14.
//  Copyright (c) 2014 Dima Maleev. All rights reserved.
//

#import "GAWhisper.h"


@implementation GAWhisper

-(void) init:(CDVInvokedUrlCommand *)command
{
    NSString *callbackId = command.callbackId;
    NSString *trackingNumber = [command.arguments objectAtIndex:0];
    NSInteger dispatchPeriod = [[command.arguments objectAtIndex:1] intValue];
    
    CDVPluginResult *result = nil;
    
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
    [GAI sharedInstance].dispatchInterval = dispatchPeriod;
    // Optional: set debug to YES for extra debugging information.
    //[GAI sharedInstance].debug = YES;
    // Create tracker instance.
    [[GAI sharedInstance] trackerWithTrackingId:trackingNumber];
    
    initialized = YES;
    
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:
              [NSString stringWithFormat:@"GAWhisper succefully initialized with tracking number = %@ and interval = %d seconds",trackingNumber, dispatchPeriod]];
    
    [self success:result callbackId:callbackId];
}

- (void) trackEvent:(CDVInvokedUrlCommand*)command
{
    //todo
}
- (void) trackTransaction:(CDVInvokedUrlCommand*)command
{
    //todo
}
- (void) trackItem:(CDVInvokedUrlCommand*)command
{
    //todo
}
- (void) trackView:(CDVInvokedUrlCommand*)command
{
    //todo
}
- (void) setCustomValue:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
{
    //todo
}
- (void) exitGAWhisper: (NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
{
    //todo
}

@end
