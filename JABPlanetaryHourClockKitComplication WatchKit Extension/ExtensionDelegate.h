//
//  ExtensionDelegate.h
//  JABPlanetaryHourClockKitComplication WatchKit Extension
//
//  Created by Xcode Developer on 4/22/19.
//  Copyright © 2019 The Life of a Demoniac. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <WatchConnectivity/WatchConnectivity.h>

typedef NS_ENUM(NSUInteger, LogEntryType) {
    Error,
    Success,
    Operation, // a function
    Event      // a result
};

@interface ExtensionDelegate : NSObject <WKExtensionDelegate, WCSessionDelegate>

@property (strong, nonatomic) WCSession *session;

- (void)log:(NSString *)context entry:(NSString *)entry status:(LogEntryType)type;
- (void)reloadComplicationTimeline;

@end
