//
//  ComplicationController.h
//  JABPlanetaryHourClockKitComplication WatchKit Extension
//
//  Created by Xcode Developer on 4/22/19.
//  Copyright © 2019 The Life of a Demoniac. All rights reserved.
//

#import <ClockKit/ClockKit.h>

#import "ExtensionDelegate.h"
#define ExtensionDelegate ((ExtensionDelegate *)[[WKExtension sharedExtension] delegate])

@interface ComplicationController : NSObject <CLKComplicationDataSource>

@end
