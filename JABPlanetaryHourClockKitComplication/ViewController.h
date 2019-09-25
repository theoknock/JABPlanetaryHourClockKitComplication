//
//  ViewController.h
//  JABPlanetaryHourClockKitComplication
//
//  Created by Xcode Developer on 4/22/19.
//  Copyright © 2019 The Life of a Demoniac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMedia/CoreMedia.h>
#import <WatchConnectivity/WatchConnectivity.h>
#import <EventKit/EventKit.h>
#import <JABPlanetaryHourCocoaTouchFramework/JABPlanetaryHourCocoaTouchFramework.h>

@interface ViewController : UIViewController <WCSessionDelegate, PlanetaryHourDataSourceLogDelegate>

@property (strong, nonatomic) WCSession *session;
@property (weak, nonatomic) IBOutlet UITextView *eventLogTextView;

//- (void)log:(NSString *)context entry:(NSString *)entry status:(LogEntryType)status;
- (void)log:(NSString *)context entry:(NSString *)entry time:(CMTime)time textAttributes:(NSUInteger)logTextAttributes;
@end
