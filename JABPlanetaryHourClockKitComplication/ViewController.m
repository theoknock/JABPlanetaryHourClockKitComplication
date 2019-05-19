//
//  ViewController.m
//  JABPlanetaryHourClockKitComplication
//
//  Created by Xcode Developer on 4/22/19.
//  Copyright © 2019 The Life of a Demoniac. All rights reserved.
//

#import "ViewController.h"

typedef NS_ENUM(NSUInteger, LogEntryType) {
    LogEntryTypeError,
    LogEntryTypeSuccess,
    LogEntryTypeOperation, // a function
    LogEntryTypeEvent      // a result
};

@interface ViewController ()
{
    dispatch_queue_t loggerQueue;
    dispatch_queue_t taskQueue;
    NSDictionary *_eventTextAttributes, *_operationTextAttributes, *_errorTextAttributes, *_successTextAttributes;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    loggerQueue = dispatch_queue_create_with_target("Logger queue", DISPATCH_QUEUE_SERIAL, dispatch_get_main_queue());
    taskQueue = dispatch_queue_create_with_target("Task queue", DISPATCH_QUEUE_SERIAL, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0));
    [self textStyles];
    self.session = [WCSession defaultSession];
    [self.session setDelegate:(id<WCSessionDelegate> _Nullable)self];
    [self.session activateSession];
    
    [self log:@"WatchKit session" entry:@"Activating WatchKit session..." time:CMClockGetTime(CMClockGetHostTimeClock()) textAttributes:LogEntryTypeOperation];
}

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *,id> *)message replyHandler:(void (^)(NSDictionary<NSString *,id> * _Nonnull))replyHandler
{
    LogEntryType textAttributes = (LogEntryType)[(NSNumber *)[message objectForKey:@"event"] unsignedIntegerValue];
      
    [self log:[NSString stringWithFormat:@"%@", [message objectForKey:@"context"]] entry:[NSString stringWithFormat:@"%@", [message objectForKey:@"entry"]] time:CMClockGetTime(CMClockGetHostTimeClock()) textAttributes:textAttributes];
}

- (void)session:(nonnull WCSession *)session activationDidCompleteWithState:(WCSessionActivationState)activationState error:(nullable NSError *)error {
    [self log:@"WatchKit session" entry:[NSString stringWithFormat:@"WatckKit session activation completed (State: %@)", (activationState == 2) ? @"WCSessionActivationStateActivated" : ((activationState == 0) ? @"WCSessionActivationStateNotActivated" : @"WCSessionActivationStateInactive")] time:CMClockGetTime(CMClockGetHostTimeClock()) textAttributes:LogEntryTypeEvent];
    if (error)
        [self log:@"WatchKit session" entry:[NSString stringWithFormat:@"%@", error.description] time:CMClockGetTime(CMClockGetHostTimeClock()) textAttributes:LogEntryTypeError];
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
    _operationTextAttributes = @{NSForegroundColorAttributeName: [UIColor orangeColor], // [UIColor colorWithRed:0.87 green:0.5 blue:0.0 alpha:1.0],
                                 NSFontAttributeName: [UIFont systemFontOfSize:11.0 weight:UIFontWeightMedium],
                                 NSParagraphStyleAttributeName: leftAlignedParagraphStyle};
    
    NSMutableParagraphStyle *fullJustificationParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    fullJustificationParagraphStyle.alignment = NSTextAlignmentJustified;
    _errorTextAttributes = @{NSForegroundColorAttributeName: [UIColor redColor], // [UIColor colorWithRed:0.91 green:0.28 blue:0.5 alpha:1.0],
                             NSFontAttributeName: [UIFont systemFontOfSize:11.0 weight:UIFontWeightMedium],
                             NSParagraphStyleAttributeName: fullJustificationParagraphStyle};
    
    NSMutableParagraphStyle *rightAlignedParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    rightAlignedParagraphStyle.alignment = NSTextAlignmentRight;
    _eventTextAttributes = @{NSForegroundColorAttributeName: [UIColor blueColor], // [UIColor colorWithRed:0.0 green:0.54 blue:0.87 alpha:1.0],
                             NSFontAttributeName: [UIFont systemFontOfSize:11.0 weight:UIFontWeightMedium],
                             NSParagraphStyleAttributeName: rightAlignedParagraphStyle};
    
    NSMutableParagraphStyle *centerAlignedParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    centerAlignedParagraphStyle.alignment = NSTextAlignmentCenter;
    _successTextAttributes = @{NSForegroundColorAttributeName: [UIColor greenColor], // [UIColor colorWithRed:0.0 green:0.87 blue:0.19 alpha:1.0],
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
        case LogEntryTypeEvent:
            attributes = _eventTextAttributes;
            break;
        case LogEntryTypeOperation:
            attributes = _operationTextAttributes;
            break;
        case LogEntryTypeSuccess:
            attributes = _successTextAttributes;
            break;
        case LogEntryTypeError:
            attributes = _errorTextAttributes;
            break;
        default:
            attributes = _errorTextAttributes;
            break;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableAttributedString *log = [[NSMutableAttributedString alloc] initWithAttributedString:[self.logTextView attributedText]];
        NSAttributedString *time_s = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n\n%@", stringFromCMTime(time)] attributes:attributes];
        NSAttributedString *context_s = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%@", context] attributes:attributes];
        NSAttributedString *entry_s = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%@", entry] attributes:attributes];
        [log appendAttributedString:time_s];
        [log appendAttributedString:context_s];
        [log appendAttributedString:entry_s];
        [self.logTextView setAttributedText:log];
    });
}

@end
