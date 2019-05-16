//
//  PlanetaryHourRowController.h
//  JABPlanetaryHourClockKitComplication WatchKit Extension
//
//  Created by Xcode Developer on 5/14/19.
//  Copyright © 2019 The Life of a Demoniac. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlanetaryHourRowController : NSObject

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *hour;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *symbol;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *planet;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *date;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *start;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *end;


@end

NS_ASSUME_NONNULL_END
