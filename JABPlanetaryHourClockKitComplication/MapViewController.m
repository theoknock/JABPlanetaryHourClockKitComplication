//
//  MapViewController.m
//  JABPlanetaryHourClockKitComplication
//
//  Created by Xcode Developer on 6/8/19.
//  Copyright © 2019 The Life of a Demoniac. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    // add location markers to map
    
    // add multipolygon overlays
    // Get planetary hour location at start time
    // Get planetary hour location at end time
    // TO-DO: Add coordinate of planetary hour at sunrise, and add coordinate to North Pole
    //        Add coordinate of planetary hour at sunrise one planetaty hour later
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:(MKPolyline *)overlay];
    [renderer setStrokeColor:[UIColor redColor]];
    [renderer setLineWidth:1.0];
    
    return (MKOverlayRenderer *)renderer;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
