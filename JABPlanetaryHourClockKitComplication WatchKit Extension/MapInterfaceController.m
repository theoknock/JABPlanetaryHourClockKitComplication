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
    
    NSLog(@"Selected row: %ld", (long)((NSNumber *)context).integerValue);
    
    // Configure interface objects here.
    [self.map addAnnotation:PlanetaryHourDataSource.data.locationManager.location.coordinate withPinColor:WKInterfaceMapPinColorPurple];
    
    NSIndexSet *daysIndices  = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, 1)];
    NSIndexSet *dataIndices  = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, 8)];
    NSIndexSet *hoursIndices = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, 24)];
    [PlanetaryHourDataSource.dat
    [PlanetaryHourDataSource.data solarCyclesForDays:daysIndices
                                   planetaryHourData:dataIndices
                                      planetaryHours:hoursIndices
         planetaryHourDataSourceStartCompletionBlock:nil
                           solarCycleCompletionBlock:nil
                        planetaryHourCompletionBlock:nil
                       planetaryHoursCompletionBlock:^(NSArray<NSDictionary<NSNumber *,id> *> * _Nonnull planetaryHours) {
                           [planetaryHours enumerateObjectsUsingBlock:^(NSDictionary<NSNumber *,id> * _Nonnull planetaryHour, NSUInteger idx, BOOL * _Nonnull stop) {
                               NSDateInterval *dateInterval = [[NSDateInterval alloc] initWithStartDate:[planetaryHour objectForKey:@(StartDate)] endDate:[planetaryHour objectForKey:@(EndDate)]];
                               if ([dateInterval containsDate:[NSDate date]])
                               {
                                   CGPoint offset = CGPointMake(0.0, 0.0);
                                   [self.map addAnnotation:[(CLLocation *)[planetaryHour objectForKey:@(StartCoordinate)] coordinate] withImage:PlanetaryHourDataSource.data.imageFromText([planetaryHour objectForKey:@(Symbol)], [planetaryHour objectForKey:@(Color)], 9.0) centerOffset:offset];
                                   if (idx != 0) [self.map addAnnotation:[(CLLocation *)[planetaryHours[idx - 1] objectForKey:@(StartCoordinate)] coordinate] withImage:PlanetaryHourDataSource.data.imageFromText([planetaryHour objectForKey:@(Symbol)], [planetaryHour objectForKey:@(Color)], 9.0) centerOffset:offset];
                                   if (idx != 24) [self.map addAnnotation:[(CLLocation *)[planetaryHours[idx + 1] objectForKey:@(StartCoordinate)] coordinate] withImage:PlanetaryHourDataSource.data.imageFromText([planetaryHour objectForKey:@(Symbol)], [planetaryHour objectForKey:@(Color)], 9.0) centerOffset:offset];
                                   
                               }
                           }];
                       }

//              planetaryHourDataSourceCompletionBlock:nil  solarCyclesForDays:daysIndices
//                                   planetaryHourData:dataIndices
//                                      planetaryHours:hoursIndices
//         planetaryHourDataSourceStartCompletionBlock:nil
//                           solarCycleCompletionBlock:nil
//                        planetaryHourCompletionBlock:nil
//                       planetaryHoursCompletionBlock:^(NSArray<NSDictionary<NSNumber *,id> *> * _Nonnull planetaryHours) {
//                           [planetaryHours enumerateObjectsUsingBlock:^(NSDictionary<NSNumber *,id> * _Nonnull planetaryHour, NSUInteger idx, BOOL * _Nonnull stop) {
//                               NSDateInterval *dateInterval = [[NSDateInterval alloc] initWithStartDate:[planetaryHour objectForKey:@(StartDate)] endDate:[planetaryHour objectForKey:@(EndDate)]];
//                               if ([dateInterval containsDate:[NSDate date]])
//                               {
//                                   CGPoint offset = CGPointMake(0.0, 0.0);
//                                   [self.map addAnnotation:[(CLLocation *)[planetaryHour objectForKey:@(StartCoordinate)] coordinate] withImage:PlanetaryHourDataSource.data.imageFromText([planetaryHour objectForKey:@(Symbol)], [planetaryHour objectForKey:@(Color)], 9.0) centerOffset:offset];
//                                   if (idx != 0) [self.map addAnnotation:[(CLLocation *)[planetaryHours[idx - 1] objectForKey:@(StartCoordinate)] coordinate] withImage:PlanetaryHourDataSource.data.imageFromText([planetaryHour objectForKey:@(Symbol)], [planetaryHour objectForKey:@(Color)], 9.0) centerOffset:offset];
//                                   if (idx != 24) [self.map addAnnotation:[(CLLocation *)[planetaryHours[idx + 1] objectForKey:@(StartCoordinate)] coordinate] withImage:PlanetaryHourDataSource.data.imageFromText([planetaryHour objectForKey:@(Symbol)], [planetaryHour objectForKey:@(Color)], 9.0) centerOffset:offset];
//
//                               }
//                           }];
//
//                       }
//     // TO-DO: Add "all results" block (array of array of dictionaries)
//     planetaryHourDataSourceCompletionBlock:nil
//              planetaryHourDataSourceCompletionBlock:^(NSError * _Nullable error) {
//                  if (error)
//                      [ExtensionDelegate log:@"JABPlanetaryHourWatchFramework" entry:[NSString stringWithFormat:@"Error adding planetary hour annotations: %@", error] status:LogEntryTypeError];
//                  else
//                      [ExtensionDelegate log:@"ClockKit Complication" entry:[NSString stringWithFormat:@"Added planetary hour annotations."] status:LogEntryTypeSuccess];
//              }];
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

//
//  MapInterfaceController.m
//  PlanetaryHourClock WatchKit App
//
//  Created by Xcode Developer on 1/26/19.
//  Copyright © 2019 The Life of a Demoniac. All rights reserved.
//

//#import "MapInterfaceController.h"
//#import "ExtensionDelegate.h"
//
//@interface MapInterfaceController ()
//{
//    dispatch_source_t annotationUpdateTimer;
//}
//
//@end
//
//@implementation MapInterfaceController
//
//#pragma mark - WKInterfaceController methods
//
//- (IBAction)displayTimeline
//{
//    [(ExtensionDelegate *)[[WKExtension sharedExtension] delegate] switchControllersWithSelectedHour:[(ExtensionDelegate *)[[WKExtension sharedExtension] delegate] selectedIndex]];
//}
//
//- (IBAction)nextPlanetaryHourAnnotation:(WKSwipeGestureRecognizer *)sender
//{
//    [(ExtensionDelegate *)[[WKExtension sharedExtension] delegate] setSelectedIndex:[(ExtensionDelegate *)[[WKExtension sharedExtension] delegate] selectedIndex] + 1];
//}
//
//- (IBAction)previousPlanetaryHourAnnotation:(id)sender
//{
//    [(ExtensionDelegate *)[[WKExtension sharedExtension] delegate] setSelectedIndex:([(ExtensionDelegate *)[[WKExtension sharedExtension] delegate] selectedIndex] + HOURS_PER_DAY) - 1];
//}
//
//- (void)awakeWithContext:(id)context
//{
//    [super awakeWithContext:context];
//
//    // Annotations location update timer
//    //    [(ExtensionDelegate *)[[WKExtension sharedExtension] delegate] setCenter:PlanetaryHourDataSource.sharedDataSource.locationManager.location.coordinate];
//
//    annotationUpdateTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
//    dispatch_source_set_timer(annotationUpdateTimer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 1.0 * NSEC_PER_SEC);
//    dispatch_source_set_event_handler(annotationUpdateTimer, ^{
//        CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake([(ExtensionDelegate *)[[WKExtension sharedExtension] delegate] center].latitude, [(ExtensionDelegate *)[[WKExtension sharedExtension] delegate] center].longitude);
//        [self.map removeAllAnnotations];
//        [self.map addAnnotation:PlanetaryHourDataSource.sharedDataSource.locationManager.location.coordinate withPinColor:WKInterfaceMapPinColorPurple];
//        [PlanetaryHourDataSource.sharedDataSource planetaryHours](PlanetaryHourDataSource.sharedDataSource.locationManager.location, [NSDate date], ^(NSAttributedString *symbol, NSString *name, NSString *abbr, NSDate *startDate, NSDate *endDate, NSInteger hour, UIColor *color, CLLocation *location, CLLocationDistance distance, BOOL current)
//                                                                  {
//                                                                      CLLocation *centerLocation = [[CLLocation alloc] initWithLatitude:centerCoordinate.latitude longitude:centerCoordinate.longitude];
//                                                                      if ([location distanceFromLocation:centerLocation] <= (distance / 5.0))
//                                                                      {
//                                                                          [self.map addAnnotation:location.coordinate withImage:PlanetaryHourDataSource.sharedDataSource.imageFromText([symbol string], color, 18.0) centerOffset:CGPointZero];
//                                                                      }
//                                                                      centerLocation = nil;
//                                                                  });
//    });
//}
//
//- (void)willActivate {
//    // This method is called when watch view controller is about to be visible to user
//    [super willActivate];
//
//    MKCoordinateRegion visibleRegion = MKCoordinateRegionMake([(ExtensionDelegate *)[[WKExtension sharedExtension] delegate] center], [(ExtensionDelegate *)[[WKExtension sharedExtension] delegate] span]);
//    [self.map setRegion:visibleRegion];
//
//    dispatch_resume(annotationUpdateTimer);
//
//    [self.crownSequencer setDelegate:self];
//    [self.crownSequencer focus];
//}
//
//- (void)didDeactivate {
//    // This method is called when watch view controller is no longer visible
//    [super didDeactivate];
//
//    [self.crownSequencer resignFocus];
//    [self.map removeAllAnnotations];
//    dispatch_suspend(annotationUpdateTimer);
//}
//
//#pragma mark - WKCrownDelegate methods
//
//- (void)crownDidRotate:(WKCrownSequencer *)crownSequencer rotationalDelta:(double)rotationalDelta
//{
//    MKCoordinateSpan tempSpan        = [(ExtensionDelegate *)[[WKExtension sharedExtension] delegate] span];
//    tempSpan.latitudeDelta          += ((rotationalDelta * rotationalDelta) * (rotationalDelta)) + (tempSpan.latitudeDelta * rotationalDelta);
//    tempSpan.longitudeDelta         += ((rotationalDelta * rotationalDelta) * (rotationalDelta)) + (tempSpan.longitudeDelta * rotationalDelta);
//    tempSpan.latitudeDelta           = (tempSpan.latitudeDelta < 0) ? 0  : (tempSpan.latitudeDelta  > MKCoordinateRegionForMapRect(MKMapRectWorld).span.latitudeDelta)  ? MKCoordinateRegionForMapRect(MKMapRectWorld).span.latitudeDelta  : tempSpan.latitudeDelta;
//    tempSpan.longitudeDelta          = (tempSpan.longitudeDelta < 0) ? 0 : (tempSpan.longitudeDelta > MKCoordinateRegionForMapRect(MKMapRectWorld).span.longitudeDelta) ? MKCoordinateRegionForMapRect(MKMapRectWorld).span.longitudeDelta : tempSpan.longitudeDelta;
//    //    NSLog(@"\t\t%f, %f", tempSpan.latitudeDelta, tempSpan.longitudeDelta);
//    MKCoordinateRegion visibleRegion = MKCoordinateRegionMake([(ExtensionDelegate *)[[WKExtension sharedExtension] delegate] center], tempSpan);
//    [self.map setRegion:visibleRegion];
//    [(ExtensionDelegate *)[[WKExtension sharedExtension] delegate] setSpan:tempSpan];
//}
//
//@end
//
//
//
//
//
//
//
//
//@end
//
//
//
