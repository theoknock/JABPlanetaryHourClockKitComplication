//
//  ViewController.h
//  JABPlanetaryHourClockKitComplication
//
//  Created by Xcode Developer on 4/22/19.
//  Copyright © 2019 The Life of a Demoniac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMedia/CoreMedia.h>
#import <WatchConnectivity/WatchConnectivity.h>

@interface ViewController : UIViewController <WCSessionDelegate>

@property (strong, nonatomic) WCSession *session;
@property (weak, nonatomic) IBOutlet UITextView *logTextView;

@end

