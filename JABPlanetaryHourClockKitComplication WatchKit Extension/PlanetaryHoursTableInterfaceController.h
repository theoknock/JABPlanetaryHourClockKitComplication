//
//  TableInterfaceController.h
//  JABPlanetaryHourClockKitComplication WatchKit Extension
//
//  Created by Xcode Developer on 5/14/19.
//  Copyright © 2019 The Life of a Demoniac. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlanetaryHoursTableInterfaceController : WKInterfaceController

@property (weak, nonatomic) IBOutlet WKInterfaceTable *planetaryHoursTable;

@end

NS_ASSUME_NONNULL_END
