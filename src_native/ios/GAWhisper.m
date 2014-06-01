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


/**
 * Method is used to track transaction.
 * @param  {function} success
 * @param  {function} fail
 * @param  {object} params - params of the request
 *                           @transactionId - A unique ID representing the transaction. This ID should not collide with other transaction IDs.
 *                           @affilation - An entity with which the transaction should be affiliated (e.g. a particular store)
 *                           @revenue - The total revenue of a transaction, including tax and shipping
 *                           @tax - The total tax for a transaction
 *                           @shipping - The total cost of shipping for a transaction
 *                           @currency_code - Optional.The local currency of a transaction.
 */

- (void) trackTransaction:(CDVInvokedUrlCommand*)command
{
    NSString    *callbackId = command.callbackId;
    NSString    *transcationId = [command.arguments objectAtIndexedSubscript:0];
    NSString    *affilation_value = [command.arguments objectAtIndexedSubscript:1];
    NSNumber    *revenue = [NSNumber numberWithInt:[[command.arguments objectAtIndexedSubscript:2] intValue]];
    NSNumber    *tax = [NSNumber numberWithInt:[[command.arguments objectAtIndexedSubscript:3] intValue]];
    NSNumber    *shipping = [NSNumber numberWithInt:[[command.arguments objectAtIndexedSubscript:4] intValue]];
    NSString    *currency_code = [command.arguments objectAtIndexedSubscript:5];
    
    
    if (initialized)
    {
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        
        [tracker send:
        [[GAIDictionaryBuilder createTransactionWithId:transcationId affiliation:affilation_value
                                                revenue:revenue
                                                    tax:tax
                                               shipping:shipping
                                           currencyCode:currency_code] build]];
        
        NSString *message = @"Track transaction function called";
        
        [self sendSuccessMessage:message to:callbackId];
        
    }

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

- (void) setCustomValue:(CDVInvokedUrlCommand*)command;
{
    NSString    *callbackId = command.callbackId;
    
    NSInteger   index =[[command.arguments objectAtIndex:0] intValue];
    NSString    *value =[command.arguments objectAtIndexedSubscript:1];
    
    if (initialized){
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        
        [tracker set:[GAIFields customDimensionForIndex:index ] value:value];
        [tracker send:[[GAIDictionaryBuilder createAppView] build]];
        
        NSString *message = @"Track view function called";
        
        [self sendSuccessMessage:message to:callbackId];
    }


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
