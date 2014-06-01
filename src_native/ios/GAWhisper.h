//
//  GAWhisper.h
//  Implementation file for GA plugin
//
//  Created by Dima Maleev on 5/28/14.
//  Copyright (c) 2014 Dima Maleev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"

@interface GAWhisper : CDVPlugin
{
    BOOL initialized;
}

/*!
Current method is used to initialise Googlge Analytics tracking object.
Params in command should contain two values:

@id - this is an google analytics tracking number 
@period - Google Analytics dispatch interval 

 */
- (void) init:(CDVInvokedUrlCommand*)command;


/*!
 Current method is used to track event which occurs in the application.
 Params in command should contain:

 @category - The event category
 @eventAction - The event action
 @eventLabel - Optional.The event label
 @eventValue - Optional.The event value

 */
- (void) trackEvent:(CDVInvokedUrlCommand*)command;
- (void) trackTransaction:(CDVInvokedUrlCommand*)command;
- (void) trackItem:(CDVInvokedUrlCommand*)command;
- (void) trackView:(CDVInvokedUrlCommand*)command;
- (void) setCustomValue:(CDVInvokedUrlCommand*)command;
- (void) exitGAWhisper: (NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;

@end
