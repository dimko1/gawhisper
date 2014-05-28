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

@interface GAWhisper : CDVPlugin
{
    BOOL initialized;
}

- (void) init:(CDVInvokedUrlCommand*)command;
- (void) trackEvent:(CDVInvokedUrlCommand*)command;
- (void) trackTransaction:(CDVInvokedUrlCommand*)command;
- (void) trackItem:(CDVInvokedUrlCommand*)command;
- (void) trackView:(CDVInvokedUrlCommand*)command;
- (void) setCustomValue:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;
- (void) exitGAWhisper: (NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;

@end
