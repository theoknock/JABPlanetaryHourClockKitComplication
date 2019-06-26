//
//  ViewController.m
//  JABPlanetaryHourClockKitComplication
//
//  Created by Xcode Developer on 4/22/19.
//  Copyright © 2019 The Life of a Demoniac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    dispatch_queue_t loggerQueue;
    dispatch_queue_t taskQueue;
    NSDictionary *_eventTextAttributes, *_operationTextAttributes, *_errorTextAttributes, *_successTextAttributes;
    
    __block EKEventStore *eventStore;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    loggerQueue = dispatch_queue_create_with_target("Logger queue", DISPATCH_QUEUE_SERIAL, dispatch_get_main_queue());
    taskQueue = dispatch_queue_create_with_target("Task queue", DISPATCH_QUEUE_SERIAL, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0));
    [self textStyles];
    [self activateSession];
    
    eventStore = [[EKEventStore alloc] init];
    
    [self calendarComplicationTimelineEntriesPlanetaryHours:720];
}

- (void)activateSession
{
    // WatchKit Connectivity
    [self log:@"WatchKit session" entry:@"Activating WatchKit session..." time:CMClockGetTime(CMClockGetHostTimeClock()) textAttributes:LogEntryTypeOperation];
    self.session = [WCSession defaultSession];
    [self.session setDelegate:(id<WCSessionDelegate> _Nullable)self];
    [self.session activateSession];
}

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *,id> *)message replyHandler:(void (^)(NSDictionary<NSString *,id> * _Nonnull))replyHandler
{
    if ([(NSString *)[message objectForKey:@"command"] isEqualToString:@"log"])
    {
        LogEntryType textAttributes = (LogEntryType)[(NSNumber *)[message objectForKey:@"event"] unsignedIntegerValue];
        [self log:[NSString stringWithFormat:@"%@", [message objectForKey:@"context"]] entry:[NSString stringWithFormat:@"%@", [message objectForKey:@"entry"]] time:CMClockGetTime(CMClockGetHostTimeClock()) textAttributes:textAttributes];
    } else if ([(NSString *)[message objectForKey:@"command"] isEqualToString:@"calendar"]) {
        [self calendarComplicationTimelineEntriesPlanetaryHours:(NSUInteger)[(NSNumber *)[message objectForKey:@"numberOfHours"] unsignedIntegerValue]];
    }
}

- (void)session:(nonnull WCSession *)session activationDidCompleteWithState:(WCSessionActivationState)activationState error:(nullable NSError *)error {
    [self log:@"WatchKit session" entry:[NSString stringWithFormat:@"WatckKit session activation completed (State: %@)", (activationState == 2) ? @"WCSessionActivationStateActivated" : ((activationState == 0) ? @"WCSessionActivationStateNotActivated" : @"WCSessionActivationStateInactive")] time:CMClockGetTime(CMClockGetHostTimeClock()) textAttributes:LogEntryTypeEvent];
    if (activationState != 2 || error)
    {
        [self log:@"WatchKit session (WatchKit extension)" entry:[NSString stringWithFormat:@"Error activating WatchKit session:\t%@", error.description] status:LogEntryTypeOperation];
        [self.session activateSession];
    }
}

- (void)sessionDidBecomeInactive:(nonnull WCSession *)session {
    [self log:@"WatchKit session" entry:@"WatchKit session inactivated" time:CMClockGetTime(CMClockGetHostTimeClock()) textAttributes:LogEntryTypeEvent];
}

- (void)sessionDidDeactivate:(nonnull WCSession *)session {
    [self log:@"WatchKit session" entry:@"WatchKit session deactivated" time:CMClockGetTime(CMClockGetHostTimeClock()) textAttributes:LogEntryTypeEvent];
}

- (void)textStyles
{
    NSMutableParagraphStyle *leftAlignedParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    leftAlignedParagraphStyle.alignment = NSTextAlignmentLeft;
    _operationTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:0.87 green:0.5 blue:0.0 alpha:1.0],
                                 NSFontAttributeName: [UIFont systemFontOfSize:11.0 weight:UIFontWeightMedium]};
    
    NSMutableParagraphStyle *fullJustificationParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    fullJustificationParagraphStyle.alignment = NSTextAlignmentJustified;
    _errorTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:0.91 green:0.28 blue:0.5 alpha:1.0],
                             NSFontAttributeName: [UIFont systemFontOfSize:11.0 weight:UIFontWeightMedium]};
    
    NSMutableParagraphStyle *rightAlignedParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    rightAlignedParagraphStyle.alignment = NSTextAlignmentRight;
    _eventTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:0.0 green:0.54 blue:0.87 alpha:1.0],
                             NSFontAttributeName: [UIFont systemFontOfSize:11.0 weight:UIFontWeightMedium],
                             NSParagraphStyleAttributeName: rightAlignedParagraphStyle};
    
    NSMutableParagraphStyle *centerAlignedParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    centerAlignedParagraphStyle.alignment = NSTextAlignmentCenter;
    _successTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:0.0 green:0.87 blue:0.19 alpha:1.0],
                               NSFontAttributeName: [UIFont systemFontOfSize:11.0 weight:UIFontWeightMedium],
                               NSParagraphStyleAttributeName: rightAlignedParagraphStyle};
}

static NSString *stringFromCMTime(CMTime time)
{
    NSString *stringFromCMTime;
    float seconds = round(CMTimeGetSeconds(time));
    int hh = (int)floorf(seconds / 3600.0f);
    int mm = (int)floorf((seconds - hh * 3600.0f) / 60.0f);
    int ss = (((int)seconds) % 60);
    if (hh > 0)
    {
        stringFromCMTime = [NSString stringWithFormat:@"%02d:%02d:%02d", hh, mm, ss];
    }
    else
    {
        stringFromCMTime = [NSString stringWithFormat:@"%02d:%02d", mm, ss];
    }
    return stringFromCMTime;
}

- (void)log:(NSString *)context entry:(NSString *)entry time:(CMTime)time textAttributes:(NSUInteger)logTextAttributes
{
    NSDictionary *attributes;
    switch (logTextAttributes) {
        case 0:
            attributes = _errorTextAttributes;
            break;
        case 1:
            attributes = _successTextAttributes;
            break;
        case 2:
            attributes = _operationTextAttributes;
            break;
        case 3:
            attributes = _eventTextAttributes;
            break;
        default:
            attributes = _errorTextAttributes;
            break;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableAttributedString *log = [[NSMutableAttributedString alloc] initWithAttributedString:[self.eventLogTextView attributedText]];
        NSAttributedString *time_s = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n\n%@", stringFromCMTime(time)] attributes:attributes];
        NSAttributedString *context_s = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%@", context] attributes:attributes];
        NSAttributedString *entry_s = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%@", entry] attributes:attributes];
        [log appendAttributedString:time_s];
        [log appendAttributedString:context_s];
        [log appendAttributedString:entry_s];
        [self.eventLogTextView setAttributedText:log];
    });
}

EKEvent *(^planetaryHourEvent)(EKEventStore *, EKCalendar *, NSDictionary<NSNumber *,id> * _Nonnull, CLLocationCoordinate2D) = ^(EKEventStore *planetaryHourEventStore, EKCalendar *planetaryHourCalendar, NSDictionary<NSNumber *,id> * _Nonnull planetaryHourData, CLLocationCoordinate2D referenceCoordinate)
{
    EKEvent *event     = [EKEvent eventWithEventStore:planetaryHourEventStore];
    event.timeZone     = [NSTimeZone localTimeZone];
    event.calendar     = planetaryHourCalendar;
    event.title        = [NSString stringWithFormat:@"%@ %@", (NSString *)[(NSAttributedString *)[planetaryHourData objectForKey:@(Symbol)] string], [planetaryHourData objectForKey:@(Name)]];
    event.availability = EKEventAvailabilityFree;
    event.alarms       = @[[EKAlarm alarmWithAbsoluteDate:[planetaryHourData objectForKey:@(StartDate)]]];
    event.location     = [NSString stringWithFormat:@"%f, %f", referenceCoordinate.latitude, referenceCoordinate.longitude];
    event.notes        = [NSString stringWithFormat:@"Hour %lu", ((NSNumber *)[planetaryHourData objectForKey:@(Hour)]).integerValue + 1];
    event.startDate    = [planetaryHourData objectForKey:@(StartDate)];
    event.endDate      = [planetaryHourData objectForKey:@(EndDate)];
    event.allDay       = NO;
    
    return event;
};

- (void)calendarComplicationTimelineEntriesPlanetaryHours:(NSUInteger)numberOfHours
{
    [self log:@"JABPlanetaryHourFramework" entry:@"Received GPS location data" time:CMClockGetTime(CMClockGetHostTimeClock()) textAttributes:LogEntryTypeEvent];
    [self log:@"EventKit" entry:@"Requesting access to Calendar..." time:CMClockGetTime(CMClockGetHostTimeClock()) textAttributes:LogEntryTypeOperation];
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
        if (granted)
        {
            [self log:@"EventKit" entry:@"Access to Calendar granted." time:CMClockGetTime(CMClockGetHostTimeClock()) textAttributes:LogEntryTypeSuccess];
            
            NSArray <EKCalendar *> *calendars = [self->eventStore calendarsForEntityType:EKEntityTypeEvent];
            [calendars enumerateObjectsUsingBlock:^(EKCalendar * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self log:@"EventKit" entry:[NSString stringWithFormat:@"Found %@ calendar...", obj.title] time:CMClockGetTime(CMClockGetHostTimeClock()) textAttributes:LogEntryTypeEvent];
                    
                    if ([obj.title isEqualToString:@"Planetary Hour"]) {
                        [self log:@"EventKit" entry:@"Removing existing Planetary Hour calendar..." time:CMClockGetTime(CMClockGetHostTimeClock()) textAttributes:LogEntryTypeOperation];
                        
                        //                    *stop = TRUE;
                        __autoreleasing NSError *error;
                        if ([self->eventStore removeCalendar:obj commit:TRUE error:&error])
                        {
                            [self log:@"EventKit" entry:@"Existing Planetary Hour calendar removed." time:CMClockGetTime(CMClockGetHostTimeClock()) textAttributes:LogEntryTypeSuccess];
                            [self log:@"EventKit" entry:@"Saving changes to Calendar..." time:CMClockGetTime(CMClockGetHostTimeClock()) textAttributes:LogEntryTypeSuccess];
                            
                            __autoreleasing NSError *removeOldCalendarError;
                            if ([self->eventStore saveCalendar:obj commit:TRUE error:&removeOldCalendarError])
                                [self log:@"EventKit" entry:@"Changes saved to Calendar." time:CMClockGetTime(CMClockGetHostTimeClock()) textAttributes:LogEntryTypeSuccess];
                            else
                                [self log:@"EventKit" entry:[NSString stringWithFormat:@"Error saving changes to Calendar:\t%@", removeOldCalendarError.description] time:CMClockGetTime(CMClockGetHostTimeClock()) textAttributes:LogEntryTypeError];
                        } else {
                            [self log:@"EventKit" entry:[NSString stringWithFormat:@"Error removing existing Planetary Hour calendar:\t%@", error.description] time:CMClockGetTime(CMClockGetHostTimeClock()) textAttributes:LogEntryTypeError];
                        }
                    }
                });
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (idx == (calendars.count - 1))
                    {
                        [self log:@"EventKit" entry:@"Creating new Planetary Hour calendar..." time:CMClockGetTime(CMClockGetHostTimeClock()) textAttributes:LogEntryTypeSuccess];
                        
                        __block EKCalendar *calendar = [EKCalendar calendarForEntityType:EKEntityTypeEvent eventStore:self->eventStore];
                        calendar.title = @"Planetary Hour";
                        calendar.source = self->eventStore.sources[1];
                        __autoreleasing NSError *error;
                        if ([self->eventStore saveCalendar:calendar commit:TRUE error:&error])
                        {
                            if (error)
                            {
                                [self log:@"EventKit" entry:[NSString stringWithFormat:@"Error creating new Planetary Hour calendar:\t%@\nCreating a default calendar for new planetary hour events...", error.localizedDescription] time:CMClockGetTime(CMClockGetHostTimeClock()) textAttributes:LogEntryTypeError];
                                calendar = [self->eventStore defaultCalendarForNewEvents];
                            } else {
                                [self log:@"EventKit" entry:@"New Planetary Hour calendar created." time:CMClockGetTime(CMClockGetHostTimeClock()) textAttributes:LogEntryTypeSuccess];
                            }
                            
                            [self log:@"EventKit" entry:@"Adding planetary hours to the Planetary Hour calendar..." time:CMClockGetTime(CMClockGetHostTimeClock()) textAttributes:LogEntryTypeOperation];
                            
                            __block NSUInteger event_count = 0;
                            NSUInteger numberOfDays = (numberOfHours / 24);
                            NSRange days = NSMakeRange(0, numberOfDays);
                            NSRange hours = NSMakeRange(0, 24);
                            NSIndexSet *daysIndices  = [[NSIndexSet alloc] initWithIndexesInRange:days];      // Calendar one year of events, starting today
                            NSMutableIndexSet *dataIndices  = [[NSMutableIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, 4)];
                            [dataIndices addIndex:6];                                                                       // Return 0-4 and  indices of planetary hour data
                            NSIndexSet *hoursIndices = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, 24)];      // Generate data for each planetary hour of the day
                            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(PlanetaryHourDataSource.data.locationManager.location.coordinate.latitude, PlanetaryHourDataSource.data.locationManager.location.coordinate.longitude);
                            [PlanetaryHourDataSource.data solarCyclesForDays:daysIndices planetaryHourData:dataIndices planetaryHours:hoursIndices
                                 planetaryHourDataSourceStartCompletionBlock:nil
                                                   solarCycleCompletionBlock:nil
                                                planetaryHourCompletionBlock:^(NSDictionary<NSNumber *,id> * _Nonnull planetaryHour) {
                                                    if (event_count < numberOfHours)
                                                    {
                                                        event_count++;
                                                        [self->eventStore saveEvent:planetaryHourEvent(self->eventStore, calendar, planetaryHour, coordinate) span:EKSpanThisEvent commit:FALSE error:nil];
                                                    }
                                                } planetaryHoursCompletionBlock:^(NSArray<NSDictionary<NSNumber *,NSDate *> *> * _Nonnull planetaryHours) {
                                                    [self->eventStore commit:nil];
                                                }
                                   planetaryHoursCalculationsCompletionBlock:nil
                                      planetaryHourDataSourceCompletionBlock:^(NSError * _Nullable error) {
                                          if (error)
                                              [self log:@"JABPlanetaryHourFramework" entry:error.description time:CMClockGetTime(CMClockGetHostTimeClock()) textAttributes:LogEntryTypeError];
                                          else
                                              [self log:@"JABPlanetaryHourFramework" entry:[NSString stringWithFormat:@"%lu planetary hours added to the Planetary Hour calendar", days.length * hours.length] time:CMClockGetTime(CMClockGetHostTimeClock()) textAttributes:LogEntryTypeSuccess];
                                          
                                          if ([self->eventStore saveCalendar:calendar commit:TRUE error:nil])
                                              [self log:@"JABPlanetaryHourFramework" entry:@"New planetary hour calendar saved." time:CMClockGetTime(CMClockGetHostTimeClock()) textAttributes:LogEntryTypeSuccess];
                                          else
                                              [self log:@"JABPlanetaryHourFramework" entry:@"Error saving new planetary hour calendar." time:CMClockGetTime(CMClockGetHostTimeClock()) textAttributes:LogEntryTypeError];
                                      }];
                        }
                    }
                });
            }];
        } else {
            [self log:@"JABPlanetaryHourFramework" entry:[NSString stringWithFormat:@"Access to Calendar denied: %@", error.description] time:CMClockGetTime(CMClockGetHostTimeClock()) textAttributes:LogEntryTypeError];
        }
    }];
}

@end


