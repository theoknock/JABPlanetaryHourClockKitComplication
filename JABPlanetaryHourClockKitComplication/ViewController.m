//
//  ViewController.m
//  JABPlanetaryHourClockKitComplication
//
//  Created by Xcode Developer on 4/22/19.
//  Copyright © 2019 The Life of a Demoniac. All rights reserved.
//

#import "ViewController.h"

typedef NS_ENUM(NSUInteger, LogTextAttributes) {
    LogTextAttributes_Error,
    LogTextAttributes_Success,
    LogTextAttributes_Operation,
    LogTextAttributes_Event
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

    self.session = [WCSession defaultSession];
    [self.session setDelegate:(id<WCSessionDelegate> _Nullable)self];
    [self.session activateSession];
    
    [self log:@"WatchKit session" entry:@"Activating WatchKit session..." time:CMClockGetTime(CMClockGetHostTimeClock()) textAttributes:LogTextAttributes_Operation];
}

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *,id> *)message replyHandler:(void (^)(NSDictionary<NSString *,id> * _Nonnull))replyHandler
{
    LogTextAttributes textAttributes = (LogTextAttributes)[(NSNumber *)[message objectForKey:@"event"] unsignedIntegerValue];
      
    [self log:[NSString stringWithFormat:@"%@", [message objectForKey:@"context"]] entry:[NSString stringWithFormat:@"%@", [message objectForKey:@"entry"]] time:CMClockGetTime(CMClockGetHostTimeClock()) textAttributes:textAttributes];
}

- (void)session:(nonnull WCSession *)session activationDidCompleteWithState:(WCSessionActivationState)activationState error:(nullable NSError *)error {
    [self log:@"WatchKit session" entry:[NSString stringWithFormat:@"WatckKit activation completed (State: %@)", (activationState == 2) ? @"WCSessionActivationStateActivated" : ((activationState == 0) ? @"WCSessionActivationStateNotActivated" : @"WCSessionActivationStateInactive")] time:CMClockGetTime(CMClockGetHostTimeClock()) textAttributes:LogTextAttributes_Event];
    if (error)
        [self log:@"WatchKit session" entry:[NSString stringWithFormat:@"%@", error.description] time:CMClockGetTime(CMClockGetHostTimeClock()) textAttributes:LogTextAttributes_Error];
}

- (void)sessionDidBecomeInactive:(nonnull WCSession *)session {
    [self log:@"WatchKit session" entry:@"WatchKit session inactivated" time:CMClockGetTime(CMClockGetHostTimeClock()) textAttributes:LogTextAttributes_Event];
}

- (void)sessionDidDeactivate:(nonnull WCSession *)session {
    [self log:@"WatchKit session" entry:@"WatchKit session deactivated" time:CMClockGetTime(CMClockGetHostTimeClock()) textAttributes:LogTextAttributes_Event];
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
                               NSParagraphStyleAttributeName: rightAlignedParagraphStyle}; // cnanged to right-aligned
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
        case LogTextAttributes_Event:
            attributes = _eventTextAttributes;
            break;
        case LogTextAttributes_Operation:
            attributes = _operationTextAttributes;
            break;
        case LogTextAttributes_Success:
            attributes = _successTextAttributes;
            break;
        case LogTextAttributes_Error:
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
        
        //        CGRect rect = [self.eventLogTextView firstRectForRange:[self.eventLogTextView textRangeFromPosition:self.eventLogTextView.beginningOfDocument toPosition:self.eventLogTextView.endOfDocument]];
        //        [self displayYHeightForFrameBoundsRect:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height) withLabel:@"First rect for range"];
        //        CGFloat heightDifference = rect.size.height - self.eventLogTextView.bounds.size.height;
        //        NSLog(@"heightDifference\t%f", heightDifference);
        //        CGRect visibleRect = CGRectMake(rect.origin.x, rect.origin.y + heightDifference, rect.size.width, rect.size.height);
        ////        [self displayYHeightForFrameBoundsRect:CGRectMake(visibleRect.origin.x, visibleRect.origin.y, visibleRect.size.width, visibleRect.size.height) withLabel:@"Visible rect"];
        //        if (heightDifference > 0)
        //        {
        //            CGRect newRect = CGRectMake(0, heightDifference, visibleRect.size.width, self.eventLogTextView.bounds.size.height);
        //            [self.eventLogTextView scrollRectToVisible:newRect animated:TRUE];
        ////            NSLog(@"New rect\tx: %f, y: %f, w: %f, h: %f\n\n", newRect.origin.x, newRect.origin.y, newRect.size.width, newRect.size.height);
        //        }
        ////        [self displayYHeightForFrameBoundsRect:CGRectMake(self.eventLogTextView.frame.origin.y, self.eventLogTextView.frame.size.height, self.eventLogTextView.bounds.origin.y, self.eventLogTextView.bounds.size.height) withLabel:@"END\n\n"];
    });
}

@end
