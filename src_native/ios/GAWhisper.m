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
    NSString    *callbackId = command.callbackId;
    NSString    *trackingNumber = [command.arguments objectAtIndex:0];
    NSInteger   dispatchPeriod = [[command.arguments objectAtIndex:1] intValue];
    
    CDVPluginResult *result = nil;
    
    [GAI sharedInstance].dispatchInterval = dispatchPeriod;
    // Optional: if that propert is sate to yes - additional debug info will be displayed in the console
    //[GAI sharedInstance].debug = YES;
    
    // Create tracker instance.
    [[GAI sharedInstance] trackerWithTrackingId:trackingNumber];
    
    initialized = YES;
    
    NSString *message = [NSString stringWithFormat:@"GAWhisper succefully initialized with tracking number = %@ and interval = %d seconds",trackingNumber, dispatchPeriod];
    
    [self sendSuccessMessage:message to:callbackId];
}

- (void) trackEvent:(CDVInvokedUrlCommand*)command
{
    NSString    *callbackId = command.callbackId;
    NSString    *category = [command.arguments objectAtIndex:0];
    NSString    *eventAction = [command.arguments objectAtIndex:1];
    NSString    *eventLabel = [command.arguments objectAtIndex:2];
    NSNumber    *eventValue = [NSNumber numberWithInt:[[command.arguments objectAtIndex:3] intValue]];

    if (initialized)
    {
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:category action:eventAction label:eventLabel value:eventValue] build]];
        NSString *message = @"Track event function called";
        
        [self sendSuccessMessage:message to:callbackId];
    }
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
    NSString    *callbackId = command.callbackId;
    NSString    *screenName = [command.arguments objectAtIndexedSubscript:0];
    
    if (initialized){
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        [tracker set:kGAIScreenName value:screenName];
        
        [tracker send:[[GAIDictionaryBuilder createAppView] build]];
        
        NSString *message = @"Track view function called";
        
        [self sendSuccessMessage:message to:callbackId];
    }
}

- (void) setCustomValue:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
{
    //todo
}
- (void) exitGAWhisper: (NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
{
    //todo
}

//calling success callback function of javascript part
-(void) sendSuccessMessage:(NSString *)message to:(NSString *)callbackId
{
    CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:message];
    [self writeJavascript:[commandResult toSuccessCallbackString:callbackId]];
}


@end
