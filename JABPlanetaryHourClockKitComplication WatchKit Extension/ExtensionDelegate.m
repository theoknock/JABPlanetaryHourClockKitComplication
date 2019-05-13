//
//  ExtensionDelegate.m
//  JABPlanetaryHourClockKitComplication WatchKit Extension
//
//  Created by Xcode Developer on 4/22/19.
//  Copyright © 2019 The Life of a Demoniac. All rights reserved.
//

#import "ExtensionDelegate.h"

@implementation ExtensionDelegate

- (void)applicationDidFinishLaunching {
    // Perform any final initialization of your application.
    self.session = [WCSession defaultSession];
    [self.session setDelegate:(id<WCSessionDelegate> _Nullable)self];
    [self.session activateSession];
    [self log:@"WatchKit session (WatchKit extension)" entry:@"Activating WatchKit session" status:Operation];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadComplicationTimeline) name:CLKComplicationServerActiveComplicationsDidChangeNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadComplicationTimeline) name:@"PlanetaryHoursDataSourceUpdatedNotification" object:nil];
}

- (void)log:(NSString *)context entry:(NSString *)entry status:(LogEntryType)type
{
    if (self.session.reachable)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.session sendMessage:@{@"context" : context, @"entry" : entry, @"type" : @(type)} replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
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

- (void)session:(nonnull WCSession *)session activationDidCompleteWithState:(WCSessionActivationState)activationState error:(nullable NSError *)error {
    if (!error)
        [self log:@"WatchKit session (WatchKit extension)" entry:[NSString stringWithFormat:@"Session activated (State: %d)", activationState] status:Event];
    else
        [self log:@"WatchKit session (WatchKit extension)" entry:[NSString stringWithFormat:@"Session activation error: %@", error.description] status:Error];
}

- (void)reloadComplicationTimeline
{
        [self log:@"ClockKit Complication Server" entry:@"Reloading complication timeline..." status:Operation];
        [[[CLKComplicationServer sharedInstance] activeComplications] enumerateObjectsUsingBlock:^(CLKComplication * _Nonnull complication, NSUInteger idx, BOOL * _Nonnull stop) {
            [self log:@"ClockKit Complication Server" entry:[NSString stringWithFormat:@"Reloaded timeline for complication: %@", complication.description] status:Operation];
            [[CLKComplicationServer sharedInstance] reloadTimelineForComplication:complication];
        }];
}

@end

