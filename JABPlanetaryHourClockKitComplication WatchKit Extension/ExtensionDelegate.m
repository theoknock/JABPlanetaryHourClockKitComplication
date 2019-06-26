//
//  ExtensionDelegate.m
//  JABPlanetaryHourClockKitComplication WatchKit Extension
//
//  Created by Xcode Developer on 4/22/19.
//  Copyright © 2019 The Life of a Demoniac. All rights reserved.
//

#import "ExtensionDelegate.h"

@implementation ExtensionDelegate

@synthesize reloadingComplicationTimeline = _reloadingComplicationTimeline;

- (NSNumber *)reloadingComplicationTimelime
{
    return self->_reloadingComplicationTimeline;
}

- (void)setReloadingComplicationTimeline:(NSNumber *)reloadingComplicationTimeline
{
    self->_reloadingComplicationTimeline = reloadingComplicationTimeline;
}

- (void)applicationDidFinishLaunching {
    // Perform any final initialization of your application.
    [self activateSession];
    
    [PlanetaryHourDataSource.data setPlanetaryHourDataSourceDelegate:(id<PlanetaryHourDataSourceLogDelegate> _Nullable)self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadComplicationTimeline) name:CLKComplicationServerActiveComplicationsDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadComplicationTimeline) name:@"PlanetaryHoursDataSourceUpdatedNotification" object:nil];
}

- (void)activateSession
{
    // WatchKit Connectivity
    [self log:@"WatchKit session (WatchKit extension)" entry:@"Activating WatchKit session" status:LogEntryTypeOperation];
    self.session = [WCSession defaultSession];
    [self.session setDelegate:(id<WCSessionDelegate> _Nullable)self];
    [self.session activateSession];
}

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *,id> *)message replyHandler:(void (^)(NSDictionary<NSString *,id> * _Nonnull))replyHandler
{
    if ([(NSString *)[message objectForKey:@"command"] isEqualToString:@"log"])
    {
        LogEntryType textAttributes = (LogEntryType)[(NSNumber *)[message objectForKey:@"event"] unsignedIntegerValue];
        [self log:[NSString stringWithFormat:@"%@", [message objectForKey:@"context"]] entry:[NSString stringWithFormat:@"%@", [message objectForKey:@"entry"]] status:textAttributes];
    }
}

- (void)session:(nonnull WCSession *)session activationDidCompleteWithState:(WCSessionActivationState)activationState error:(nullable NSError *)error {
    [self log:@"WatchKit session" entry:[NSString stringWithFormat:@"WatckKit session activation completed (State: %@)", (activationState == 2) ? @"WCSessionActivationStateActivated" : ((activationState == 0) ? @"WCSessionActivationStateNotActivated" : @"WCSessionActivationStateInactive")] status:LogEntryTypeEvent];
    if (activationState != 2 || error)
    {
        [self log:@"WatchKit session (WatchKit extension)" entry:[NSString stringWithFormat:@"Error activating WatchKit session:\t%@", error.description] status:LogEntryTypeOperation];
        [self.session activateSession];
    }
}

- (void)log:(NSString *)context entry:(NSString *)entry status:(LogEntryType)type
{
    if (self.session.reachable)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.session sendMessage:@{@"command" : @"log", @"context" : context, @"entry" : entry, @"type" : @(type)} replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
                NSLog(@"%@", [replyMessage objectForKey:@"reply"]);
            } errorHandler:^(NSError * _Nonnull error) {
                NSLog(@"Error sending message: %@", error.description);
            }];
        });
    }
}

- (void)applicationDidBecomeActive {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillResignActive {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, etc.
}

- (void)handleBackgroundTasks:(NSSet<WKRefreshBackgroundTask *> *)backgroundTasks {
    // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
    for (WKRefreshBackgroundTask * task in backgroundTasks) {
        // Check the Class of each task to decide how to process it
        if ([task isKindOfClass:[WKApplicationRefreshBackgroundTask class]]) {
            // Be sure to complete the background task once you’re done.
            WKApplicationRefreshBackgroundTask *backgroundTask = (WKApplicationRefreshBackgroundTask*)task;
            [backgroundTask setTaskCompletedWithSnapshot:NO];
        } else if ([task isKindOfClass:[WKSnapshotRefreshBackgroundTask class]]) {
            // Snapshot tasks have a unique completion call, make sure to set your expiration date
            WKSnapshotRefreshBackgroundTask *snapshotTask = (WKSnapshotRefreshBackgroundTask*)task;
            [snapshotTask setTaskCompletedWithDefaultStateRestored:YES estimatedSnapshotExpiration:[NSDate distantFuture] userInfo:nil];
        } else if ([task isKindOfClass:[WKWatchConnectivityRefreshBackgroundTask class]]) {
            // Be sure to complete the background task once you’re done.
            WKWatchConnectivityRefreshBackgroundTask *backgroundTask = (WKWatchConnectivityRefreshBackgroundTask*)task;
            [backgroundTask setTaskCompletedWithSnapshot:NO];
        } else if ([task isKindOfClass:[WKURLSessionRefreshBackgroundTask class]]) {
            // Be sure to complete the background task once you’re done.
            WKURLSessionRefreshBackgroundTask *backgroundTask = (WKURLSessionRefreshBackgroundTask*)task;
            [backgroundTask setTaskCompletedWithSnapshot:NO];
        } else if ([task isKindOfClass:[WKRelevantShortcutRefreshBackgroundTask class]]) {
            // Be sure to complete the relevant-shortcut task once you’re done.
            WKRelevantShortcutRefreshBackgroundTask *relevantShortcutTask = (WKRelevantShortcutRefreshBackgroundTask*)task;
            [relevantShortcutTask setTaskCompletedWithSnapshot:NO];
        } else if ([task isKindOfClass:[WKIntentDidRunRefreshBackgroundTask class]]) {
            // Be sure to complete the intent-did-run task once you’re done.
            WKIntentDidRunRefreshBackgroundTask *intentDidRunTask = (WKIntentDidRunRefreshBackgroundTask*)task;
            [intentDidRunTask setTaskCompletedWithSnapshot:NO];
        } else {
            // make sure to complete unhandled task types
            [task setTaskCompletedWithSnapshot:NO];
        }
    }
}

- (void)reloadComplicationTimeline
{
    if ([[self reloadingComplicationTimelime] boolValue] == FALSE)
    {
        [self log:@"ClockKit Complication Server" entry:@"Reloading complication timeline..." status:LogEntryTypeOperation];
        [[[CLKComplicationServer sharedInstance] activeComplications] enumerateObjectsUsingBlock:^(CLKComplication * _Nonnull complication, NSUInteger idx, BOOL * _Nonnull stop) {
            [self log:@"ClockKit Complication Server" entry:[NSString stringWithFormat:@"Reloaded timeline for complication: %@", complication.description] status:LogEntryTypeOperation];
            [[CLKComplicationServer sharedInstance] reloadTimelineForComplication:complication];
        }];
    } else {
        [self log:@"ClockKit Complication Server" entry:@"Request to reload complication timeline denied; reloading is already in progress." status:LogEntryTypeOperation];
        
    }
}

@end

