//
//  TableInterfaceController.m
//  JABPlanetaryHourClockKitComplication WatchKit Extension
//
//  Created by Xcode Developer on 5/14/19.
//  Copyright © 2019 The Life of a Demoniac. All rights reserved.
//

#import "PlanetaryHoursTableInterfaceController.h"
#import "PlanetaryHourRowController.h"
#import "MapInterfaceController.h"
#import <JABPlanetaryHourWatchFramework/JABPlanetaryHourWatchFramework.h>

@implementation PlanetaryHoursTableInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:CLKComplicationServerActiveComplicationsDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        __weak typeof(WKInterfaceTable *) weakPlanetaryHoursTable = self.planetaryHoursTable;
        updatePlanetaryHoursTable(weakPlanetaryHoursTable);
    }];
}
- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    __weak typeof(WKInterfaceTable *) weakPlanetaryHoursTable = self.planetaryHoursTable;
    updatePlanetaryHoursTable(weakPlanetaryHoursTable);
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

void (^updatePlanetaryHoursTable)(__weak WKInterfaceTable *) = ^(__weak WKInterfaceTable *planetaryHoursTable)
{
    __strong typeof(WKInterfaceTable *) table = planetaryHoursTable;
    [table setNumberOfRows:24 withRowType:@"PlanetaryHoursTableRow"];
    NSIndexSet *daysIndices  = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, 1)];
    NSIndexSet *dataIndices  = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, 8)];
    NSIndexSet *hoursIndices = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, 24)];
    [PlanetaryHourDataSource.data solarCyclesForDays:daysIndices planetaryHourData:dataIndices planetaryHours:hoursIndices
                           solarCycleCompletionBlock:nil
                        planetaryHourCompletionBlock:^(NSDictionary<NSNumber *,id> * _Nonnull planetaryHour) {
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            PlanetaryHourRowController* row = (PlanetaryHourRowController *)[table rowControllerAtIndex:(NSInteger)[(NSNumber *)[planetaryHour objectForKey:@(Hour)] integerValue]];
                                                            [row.symbol setAttributedText:(NSAttributedString *)[planetaryHour objectForKey:@(Symbol)]];
                                                            [row.planet setText:(NSString *)[planetaryHour objectForKey:@(Name)]];
                                                            [row.hour setText:[NSString stringWithFormat:@"%ld", (long)(NSInteger)[(NSNumber *)[planetaryHour objectForKey:@(Hour)] integerValue] + 1]];
                                                            [row.hour setTextColor:(UIColor *)[planetaryHour objectForKey:@(Color)]]; // ((NSInteger)[(NSNumber *)[planetaryHour objectForKey:@(Hour)] integerValue] < 12) ? [UIColor yellowColor] : [UIColor blueColor]];
                                                            NSDateFormatter *dateFormatter      = [[NSDateFormatter alloc] init];
                                                            dateFormatter.dateStyle             = NSDateFormatterShortStyle;
                                                            NSString *dateString                = [dateFormatter stringFromDate:(NSDate *)[planetaryHour objectForKey:@(StartDate)]];
                                                            [row.date setText:dateString];
                                                            
                                                            NSDateFormatter *startDateFormatter = [[NSDateFormatter alloc] init];
                                                            startDateFormatter.timeStyle        = NSDateFormatterShortStyle;
                                                            NSString *startDateString           = [startDateFormatter stringFromDate:(NSDate *)[planetaryHour objectForKey:@(StartDate)]];
                                                            [row.start setText:startDateString];
                                                            
                                                            NSDateFormatter *endDateFormatter   = [[NSDateFormatter alloc] init];
                                                            endDateFormatter.timeStyle          = NSDateFormatterShortStyle;
                                                            NSString *endDateString             = [endDateFormatter stringFromDate:(NSDate *)[planetaryHour objectForKey:@(EndDate)]];
                                                            [row.end setText:endDateString];
                                                            
                                                            //                               if (current)
                                                            //                                   [table scrollToRowAtIndex:hour];
                                                        });
    } planetaryHoursCompletionBlock:nil
              planetaryHourDataSourceCompletionBlock:nil];
    
//    [PlanetaryHourDataSource.data solarCyclesForDays:daysIndices planetaryHourData:dataIndices planetaryHours:daysIndices
//                           solarCycleCompletionBlock:nil
//                        planetaryHourCompletionBlock:^(NSDictionary<NSNumber *,id> * _Nonnull planetaryHour) {
//                                                        dispatch_async(dispatch_get_main_queue(), ^{
//                                                            PlanetaryHourRowController* row = (PlanetaryHourRowController *)[table rowControllerAtIndex:(NSInteger)[(NSNumber *)[planetaryHour objectForKey:@(Hour)] integerValue]];
//                                                            [row.symbol setAttributedText:(NSAttributedString *)[planetaryHour objectForKey:@(Symbol)]];
//                                                            [row.planet setText:(NSString *)[planetaryHour objectForKey:@(Name)]];
//                                                            [row.hour setText:[NSString stringWithFormat:@"%ld", (long)(NSInteger)[(NSNumber *)[planetaryHour objectForKey:@(Hour)] integerValue] + 1]];
//                                                            [row.hour setTextColor:(UIColor *)[planetaryHour objectForKey:@(Color)]]; // ((NSInteger)[(NSNumber *)[planetaryHour objectForKey:@(Hour)] integerValue] < 12) ? [UIColor yellowColor] : [UIColor blueColor]];
//                                                            NSDateFormatter *dateFormatter      = [[NSDateFormatter alloc] init];
//                                                            dateFormatter.dateStyle             = NSDateFormatterShortStyle;
//                                                            NSString *dateString                = [dateFormatter stringFromDate:(NSDate *)[planetaryHour objectForKey:@(StartDate)]];
//                                                            [row.date setText:dateString];
//                                                            
//                                                            NSDateFormatter *startDateFormatter = [[NSDateFormatter alloc] init];
//                                                            startDateFormatter.timeStyle        = NSDateFormatterShortStyle;
//                                                            NSString *startDateString           = [startDateFormatter stringFromDate:(NSDate *)[planetaryHour objectForKey:@(StartDate)]];
//                                                            [row.start setText:startDateString];
//                                                            
//                                                            NSDateFormatter *endDateFormatter   = [[NSDateFormatter alloc] init];
//                                                            endDateFormatter.timeStyle          = NSDateFormatterShortStyle;
//                                                            NSString *endDateString             = [endDateFormatter stringFromDate:(NSDate *)[planetaryHour objectForKey:@(EndDate)]];
//                                                            [row.end setText:endDateString];
//                                                            
//                                                            //                               if (current)
//                                                            //                                   [table scrollToRowAtIndex:hour];
//                                                        });
//
//    } planetaryHoursCompletionBlock:nil
//              planetaryHourDataSourceCompletionBlock:nil];
    
//    [PlanetaryHourDataSource.data
//     solarCyclesForDays:daysIndices
//     planetaryHourData:dataIndices
//     planetaryHours:hoursIndices
//     planetaryHourDataSourceStartCompletionBlock:nil
//     solarCycleCompletionBlock:nil
//     planetaryHourCompletionBlock:^(NSDictionary<NSNumber *,id> * _Nonnull planetaryHour) {
//         dispatch_async(dispatch_get_main_queue(), ^{
//             PlanetaryHourRowController* row = (PlanetaryHourRowController *)[table rowControllerAtIndex:(NSInteger)[(NSNumber *)[planetaryHour objectForKey:@(Hour)] integerValue]];
//             [row.symbol setAttributedText:(NSAttributedString *)[planetaryHour objectForKey:@(Symbol)]];
//             [row.planet setText:(NSString *)[planetaryHour objectForKey:@(Name)]];
//             [row.hour setText:[NSString stringWithFormat:@"%ld", (long)(NSInteger)[(NSNumber *)[planetaryHour objectForKey:@(Hour)] integerValue] + 1]];
//             [row.hour setTextColor:(UIColor *)[planetaryHour objectForKey:@(Color)]]; // ((NSInteger)[(NSNumber *)[planetaryHour objectForKey:@(Hour)] integerValue] < 12) ? [UIColor yellowColor] : [UIColor blueColor]];
//             NSDateFormatter *dateFormatter      = [[NSDateFormatter alloc] init];
//             dateFormatter.dateStyle             = NSDateFormatterShortStyle;
//             NSString *dateString                = [dateFormatter stringFromDate:(NSDate *)[planetaryHour objectForKey:@(StartDate)]];
//             [row.date setText:dateString];
//
//             NSDateFormatter *startDateFormatter = [[NSDateFormatter alloc] init];
//             startDateFormatter.timeStyle        = NSDateFormatterShortStyle;
//             NSString *startDateString           = [startDateFormatter stringFromDate:(NSDate *)[planetaryHour objectForKey:@(StartDate)]];
//             [row.start setText:startDateString];
//
//             NSDateFormatter *endDateFormatter   = [[NSDateFormatter alloc] init];
//             endDateFormatter.timeStyle          = NSDateFormatterShortStyle;
//             NSString *endDateString             = [endDateFormatter stringFromDate:(NSDate *)[planetaryHour objectForKey:@(EndDate)]];
//             [row.end setText:endDateString];
//
//             //                               if (current)
//             //                                   [table scrollToRowAtIndex:hour];
//         });
//     }
//     planetaryHoursCompletionBlock:nil
//     planetaryHoursCalculationsCompletionBlock:nil
//     planetaryHourDataSourceCompletionBlock:nil];
};

- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex
{
    [self presentControllerWithName:@"MapInterfaceController" context:[NSNumber numberWithInteger:rowIndex]];
}


@end




