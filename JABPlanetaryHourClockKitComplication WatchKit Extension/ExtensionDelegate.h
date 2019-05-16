//
//  ExtensionDelegate.h
//  JABPlanetaryHourClockKitComplication WatchKit Extension
//
//  Created by Xcode Developer on 4/22/19.
//  Copyright © 2019 The Life of a Demoniac. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <WatchConnectivity/WatchConnectivity.h>
#import <JABPlanetaryHourWatchFramework/JABPlanetaryHourWatchFramework.h>

@interface ExtensionDelegate : NSObject <WKExtensionDelegate, WCSessionDelegate, PlanetaryHourDataSourceLogDelegate>

@property (strong, nonatomic) WCSession *session;

- (void)log:(NSString *)context entry:(NSString *)entry status:(LogEntryType)type;
- (void)reloadComplicationTimeline;

@end
