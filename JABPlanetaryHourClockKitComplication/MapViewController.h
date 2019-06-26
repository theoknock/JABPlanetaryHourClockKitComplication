//
//  MapViewController.h
//  JABPlanetaryHourClockKitComplication
//
//  Created by Xcode Developer on 6/8/19.
//  Copyright © 2019 The Life of a Demoniac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <JABPlanetaryHourCocoaTouchFramework/JABPlanetaryHourCocoaTouchFramework.h>

NS_ASSUME_NONNULL_BEGIN

@interface MapViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

NS_ASSUME_NONNULL_END
