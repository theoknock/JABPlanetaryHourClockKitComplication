//
//  ExtensionDelegate.h
//  JABPlanetaryHourClockKitComplication WatchKit Extension
//
//  Created by Xcode Developer on 4/22/19.
//  Copyright © 2019 The Life of a Demoniac. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <WatchConnectivity/WatchConnectivity.h>
#import <UserNotifications/UserNotifications.h>
#import <JABPlanetaryHourWatchFramework/JABPlanetaryHourWatchFramework.h>

@interface ExtensionDelegate : NSObject <WKExtensionDelegate, WCSessionDelegate, PlanetaryHourDataSourceLogDelegate>

@property (strong, nonatomic) WCSession * _Nonnull session;

- (void)log:(NSString *_Nonnull)context entry:(NSString *_Nonnull)entry status:(LogEntryType)type;
- (void)reloadComplicationTimeline;
- (void)addNotificationsForPlanetaryHours:(NSArray<NSDictionary<NSNumber *,id> *> * _Nonnull)planetaryHours;
@property (assign, nonatomic, setter=setReloadingComplicationTimeline:) NSNumber * _Nonnull reloadingComplicationTimeline;

@end
