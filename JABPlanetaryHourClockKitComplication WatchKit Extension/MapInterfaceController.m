//
//  MapInterfaceController.m
//  JABPlanetaryHourClockKitComplication WatchKit Extension
//
//  Created by Xcode Developer on 5/16/19.
//  Copyright © 2019 The Life of a Demoniac. All rights reserved.
//

#import "MapInterfaceController.h"
#import <JABPlanetaryHourWatchFramework/JABPlanetaryHourWatchFramework.h>

@interface MapInterfaceController ()

@end

@implementation MapInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
    [self.map addAnnotation:PlanetaryHourDataSource.data.locationManager.location.coordinate withPinColor:WKInterfaceMapPinColorPurple];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



