//
//  MapInterfaceController.h
//  JABPlanetaryHourClockKitComplication WatchKit Extension
//
//  Created by Xcode Developer on 5/16/19.
//  Copyright © 2019 The Life of a Demoniac. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

#import "ExtensionDelegate.h"
#define ExtensionDelegate ((ExtensionDelegate *)[[WKExtension sharedExtension] delegate])

NS_ASSUME_NONNULL_BEGIN

@interface MapInterfaceController : WKInterfaceController <WKCrownDelegate>

@property (weak, nonatomic) IBOutlet WKInterfaceMap *map;

@property (class) NSInteger centerHour;
@property (class) MKCoordinateSpan coordinateSpan;
@property (class) CLLocationCoordinate2D centerCoordinate;

@end

NS_ASSUME_NONNULL_END
