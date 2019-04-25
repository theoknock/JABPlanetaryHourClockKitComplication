//
//  ComplicationController.m
//  JABPlanetaryHourClockKitComplication WatchKit Extension
//
//  Created by Xcode Developer on 4/22/19.
//  Copyright © 2019 The Life of a Demoniac. All rights reserved.
//

#import "ComplicationController.h"
#import <JABPlanetaryHourWatchFramework/JABPlanetaryHourWatchFramework.h>

@interface ComplicationController ()

@end

@implementation ComplicationController

#pragma mark - Templates

CLKComplicationTemplateModularLargeTallBody *(^complicationTemplateModularLargeTallBody)(NSString *, NSString *, UIColor *) = ^(NSString *headerText, NSString *bodyText, UIColor *tint)
{
    CLKComplicationTemplateModularLargeTallBody *template = [[CLKComplicationTemplateModularLargeTallBody alloc] init];
    template.headerTextProvider = [CLKSimpleTextProvider textProviderWithText:(headerText) ? headerText : @"㊏"];
    template.bodyTextProvider = [CLKSimpleTextProvider textProviderWithText:(bodyText) ? bodyText : @"㊏"];
    template.tintColor = tint;
    
    return template;
};

CLKComplicationTemplateModularLargeTable *(^complicationTemplateModularLargeTable)(NSString *, NSString *, NSString *, NSString *, NSString *, UIColor *) = ^(NSString *text, NSString *row1Column1TextProvider, NSString *row1Column2TextProvider, NSString *row2Column1TextProvider, NSString *row2Column2TextProvider, UIColor *color)
{
    CLKComplicationTemplateModularLargeTable *template = [[CLKComplicationTemplateModularLargeTable alloc] init];
    template.headerTextProvider = [CLKSimpleTextProvider textProviderWithText:(text) ? text : @"㊏"];
    template.row1Column1TextProvider = [CLKSimpleTextProvider textProviderWithText:(row1Column1TextProvider) ? row1Column1TextProvider : @"㊏"];
    template.row1Column2TextProvider = [CLKSimpleTextProvider textProviderWithText:(row1Column2TextProvider) ? row1Column2TextProvider : @"㊏"];
    template.row2Column1TextProvider = [CLKSimpleTextProvider textProviderWithText:(row2Column1TextProvider) ? row2Column1TextProvider : @"㊏"];
    template.row2Column2TextProvider = [CLKSimpleTextProvider textProviderWithText:(row2Column2TextProvider) ? row2Column2TextProvider : @"㊏"];
    template.tintColor = color;
    //    template.headerImageProvider...
    
    return template;
};

CLKComplicationTemplateModularSmallSimpleText *(^complicationTemplateModularSmallSimpleText)(NSString *, UIColor *) = ^(NSString *text, UIColor *tint)
{
    CLKComplicationTemplateModularSmallSimpleText *template = [[CLKComplicationTemplateModularSmallSimpleText alloc] init];
    template.textProvider = [CLKSimpleTextProvider textProviderWithText:(text) ? text : @"㊏"];
    template.tintColor = tint;
    
    return template;
};


CLKComplicationTemplateUtilitarianLargeFlat *(^complicationTemplateUtilitarianLargeFlat)(NSString *, UIColor *) = ^(NSString *text, UIColor *tint)
{
    CLKComplicationTemplateUtilitarianLargeFlat *template = [[CLKComplicationTemplateUtilitarianLargeFlat alloc] init];
    template.textProvider = [CLKSimpleTextProvider textProviderWithText:(text) ? text : @"㊏"];
    template.tintColor = tint;
    
    return template;
};

CLKComplicationTemplateUtilitarianSmallFlat *(^complicationTemplateUtilitarianSmallFlat)(NSString *, UIColor *) = ^(NSString *text, UIColor *tint)
{
    CLKComplicationTemplateUtilitarianSmallFlat *template = [[CLKComplicationTemplateUtilitarianSmallFlat alloc] init];
    template.textProvider = [CLKSimpleTextProvider textProviderWithText:(text) ? text : @"㊏"];
    template.tintColor = tint;
    
    return template;
};

CLKComplicationTemplateExtraLargeSimpleText *(^complicationTemplateExtraLargeSimpleText)(NSString *, UIColor *) = ^(NSString *text, UIColor *tint)
{
    CLKComplicationTemplateExtraLargeSimpleText *template = [[CLKComplicationTemplateExtraLargeSimpleText alloc] init];
    template.textProvider = [CLKSimpleTextProvider textProviderWithText:(text) ? text : @"㊏"];
    template.tintColor = tint;
    
    return template;
};

CLKComplicationTemplateCircularSmallSimpleText *(^complicationTemplateCircularSmallSimpleText)(NSString *, UIColor *) = ^(NSString *text, UIColor *tint)
{
    CLKComplicationTemplateCircularSmallSimpleText *template = [[CLKComplicationTemplateCircularSmallSimpleText alloc] init];
    template.textProvider = [CLKSimpleTextProvider textProviderWithText:(text) ? text : @"㊏"] ;
    template.tintColor = tint;
    
    return template;
};

CLKComplicationTemplateCircularSmallStackText *(^complicationTemplateCircularSmallStackText)(NSString *, NSString *) = ^(NSString *line1textProvider, NSString *line2TextProvider)
{
    CLKComplicationTemplateCircularSmallStackText *template = [[CLKComplicationTemplateCircularSmallStackText alloc] init];
    template.line1TextProvider = [CLKSimpleTextProvider textProviderWithText:(line1textProvider) ? line1textProvider : @"㊏"];
    template.line2TextProvider = [CLKSimpleTextProvider textProviderWithText:(line2TextProvider) ? line2TextProvider : @"㊏"];
    
    return template;
};

CLKComplicationTemplateExtraLargeRingImage *(^complicationTemplateExtraLargeRingImage)(NSString *, CLKComplicationRingStyle, float, UIColor *) = ^(NSString *text, CLKComplicationRingStyle ringStyle, float fillFraction, UIColor *color)
{
    CLKComplicationTemplateExtraLargeRingImage *template = [[CLKComplicationTemplateExtraLargeRingImage alloc] init];
    template.imageProvider = [CLKImageProvider imageProviderWithOnePieceImage:[PlanetaryHourDataSource.data imageFromText](text, color, 72.0)];
    template.ringStyle = ringStyle;
    template.fillFraction = fillFraction;
    template.tintColor = color;
    
    return template;
};

CLKComplicationTemplateModularSmallRingText *(^complicationTemplateModularSmallRingText)(NSString *, CLKComplicationRingStyle, float)  = ^(NSString *text, CLKComplicationRingStyle ringStyle, float fillFraction)
{
    CLKComplicationTemplateModularSmallRingText *template = [[CLKComplicationTemplateModularSmallRingText alloc] init];
    template.textProvider = [CLKSimpleTextProvider textProviderWithText:(text) ? text : @"㊏"];
    template.ringStyle    = ringStyle;
    template.fillFraction = fillFraction;
    
    return template;
};

CLKComplicationTemplateGraphicCornerGaugeText *(^complicationTemplateGraphicCornerGaugeText)(NSString *, UIColor *, NSNumber *, NSDate *, NSDate *) = ^(NSString *symbol, UIColor *tintColor, NSNumber *hour, NSDate *startDate, NSDate *endDate)
{
    CLKComplicationTemplateGraphicCornerGaugeText *template = [[CLKComplicationTemplateGraphicCornerGaugeText alloc] init];
    
    Planet leadingPlanet           = (Planet)([PlanetaryHourDataSource.data planetForPlanetSymbol]((symbol) ? symbol : @"㊏") + 1) % NUMBER_OF_PLANETS;
    NSString *leadingPlanetSymbol  = [PlanetaryHourDataSource.data planetSymbolForPlanet](leadingPlanet);
    UIColor *leadingPlanetColor    = [PlanetaryHourDataSource.data colorForPlanetSymbol]((leadingPlanetSymbol) ? leadingPlanetSymbol : @"㊏");
    
    Planet trailingPlanet          = (Planet)([PlanetaryHourDataSource.data planetForPlanetSymbol]((symbol) ? symbol : @"㊏") + 6) % NUMBER_OF_PLANETS;
    NSString *trailingPlanetSymbol = [PlanetaryHourDataSource.data planetSymbolForPlanet](trailingPlanet);
    UIColor *trailingPlanetColor   = [PlanetaryHourDataSource.data colorForPlanetSymbol]((trailingPlanetSymbol) ? trailingPlanetSymbol : @"㊏");
    
    NSDate *earlierDate            = [startDate earlierDate:endDate];
    NSDate *laterDate              = ([earlierDate isEqualToDate:startDate]) ? endDate : startDate;
    
    template.outerTextProvider     = [CLKSimpleTextProvider textProviderWithText:(symbol) ? symbol : @"㊏"];
    template.tintColor             = tintColor;
    template.trailingTextProvider  = [CLKSimpleTextProvider textProviderWithText:(leadingPlanetSymbol) ? leadingPlanetSymbol : @"㊏"];
    template.leadingTextProvider   = [CLKSimpleTextProvider textProviderWithText:(trailingPlanetSymbol) ? trailingPlanetSymbol : @"㊏"];
    template.gaugeProvider         = [CLKTimeIntervalGaugeProvider gaugeProviderWithStyle:CLKGaugeProviderStyleRing gaugeColors:@[trailingPlanetColor, tintColor, leadingPlanetColor] gaugeColorLocations:@[[NSNumber numberWithFloat:0.0], [NSNumber numberWithFloat:0.5], [NSNumber numberWithFloat:1.0]] startDate:earlierDate startFillFraction:0.0 endDate:laterDate endFillFraction:1.0];
    
    return template;
};

CLKComplicationTemplateGraphicCircularOpenGaugeImage *(^complicationTemplateGraphicCircularOpenGaugeImage)(NSString *, UIColor *, NSNumber *, NSDate *, NSDate *, NSArray<UIColor *> *, NSArray<NSNumber *> *, CLKGaugeProviderStyle) = ^(NSString *symbol, UIColor *color, NSNumber *hour, NSDate *startDate, NSDate *endDate, NSArray<UIColor *> *gaugeColors, NSArray<NSNumber *> *gaugeColorLocations, CLKGaugeProviderStyle style)
{
    CLKComplicationTemplateGraphicCircularOpenGaugeImage *template = [[CLKComplicationTemplateGraphicCircularOpenGaugeImage alloc] init];
    template.centerTextProvider  = [CLKSimpleTextProvider textProviderWithText:(symbol) ? symbol : @"㊏"];
    template.bottomImageProvider = [CLKFullColorImageProvider providerWithFullColorImage:[PlanetaryHourDataSource.data imageFromText]([NSString stringWithFormat:@"%ld", hour.longValue], color, 9.0)];
    template.gaugeProvider       = [CLKTimeIntervalGaugeProvider gaugeProviderWithStyle:style gaugeColors:gaugeColors gaugeColorLocations:gaugeColorLocations startDate:startDate endDate:endDate];
    
    return template;
};

CLKComplicationTemplateGraphicCircularOpenGaugeRangeText *(^complicationTemplateGraphicCircularOpenGaugeRangeText)(NSString *, UIColor *, NSNumber *, NSDate *, NSDate *) = ^(NSString *symbol, UIColor *tintColor, NSNumber *hour, NSDate *startDate, NSDate *endDate)
{
    CLKComplicationTemplateGraphicCircularOpenGaugeRangeText *template = [[CLKComplicationTemplateGraphicCircularOpenGaugeRangeText alloc] init];
    Planet leadingPlanet           = (Planet)([PlanetaryHourDataSource.data planetForPlanetSymbol](symbol) + 1) % NUMBER_OF_PLANETS;
    NSString *leadingPlanetSymbol  = [PlanetaryHourDataSource.data planetSymbolForPlanet](leadingPlanet);
    UIColor *leadingPlanetColor    = [PlanetaryHourDataSource.data colorForPlanetSymbol](leadingPlanetSymbol);
    
    Planet trailingPlanet          = (Planet)([PlanetaryHourDataSource.data planetForPlanetSymbol](symbol) + 6) % NUMBER_OF_PLANETS;
    NSString *trailingPlanetSymbol = [PlanetaryHourDataSource.data planetSymbolForPlanet](trailingPlanet);
    UIColor *trailingPlanetColor   = [PlanetaryHourDataSource.data colorForPlanetSymbol](trailingPlanetSymbol);
    
    NSDate *earlierDate            = [startDate earlierDate:endDate];
    NSDate *laterDate              = ([earlierDate isEqualToDate:startDate]) ? endDate : startDate;
    
    template.centerTextProvider    = [CLKSimpleTextProvider textProviderWithText:symbol];
    template.tintColor             = tintColor;
    template.trailingTextProvider  = [CLKSimpleTextProvider textProviderWithText:leadingPlanetSymbol];
    template.leadingTextProvider   = [CLKSimpleTextProvider textProviderWithText:trailingPlanetSymbol];
    template.gaugeProvider         = [CLKTimeIntervalGaugeProvider gaugeProviderWithStyle:CLKGaugeProviderStyleRing gaugeColors:@[trailingPlanetColor, tintColor, leadingPlanetColor] gaugeColorLocations:@[[NSNumber numberWithFloat:0.0], [NSNumber numberWithFloat:0.5], [NSNumber numberWithFloat:1.0]] startDate:earlierDate startFillFraction:0.0 endDate:laterDate endFillFraction:1.0];
    
    return template;
};

CLKComplicationTemplate *(^templateForComplication)(CLKComplicationFamily, NSDictionary *) = ^(CLKComplicationFamily family, NSDictionary *data) {
    CLKComplicationTemplate *template = nil;
    
    switch (family) {
        case CLKComplicationFamilyModularLarge:
        {
            long hour = [(NSNumber *)[data objectForKey:@(Hour)] longValue] + 1;
            NSString *hourString = [NSString stringWithFormat:@"Hour %lu", hour];
            
            NSDateFormatter *startDateFormatter = [[NSDateFormatter alloc] init];
            startDateFormatter.timeStyle        = NSDateFormatterShortStyle;
            NSString *startDateString           = [startDateFormatter stringFromDate:[data objectForKey:@(StartDate)]];
            
            NSDateFormatter *endDateFormatter   = [[NSDateFormatter alloc] init];
            endDateFormatter.timeStyle          = NSDateFormatterShortStyle;
            NSString *endDateString             = [endDateFormatter stringFromDate:[data objectForKey:@(EndDate)]];
            
            template = complicationTemplateModularLargeTable([data objectForKey:@(Symbol)], [data objectForKey:@(Name)], hourString, startDateString, endDateString, [data objectForKey:@(Color)]);
            //            template = complicationTemplateModularLargeTallBody([data objectForKey:@"symbol"], [data objectForKey:@"name"], [data objectForKey:@"color"]);
            break ;
        }
        case CLKComplicationFamilyModularSmall:
        {
            template = complicationTemplateModularSmallSimpleText([data objectForKey:@"symbol"], [data objectForKey:@"color"]);
            //            template = [self complicationTemplateModularSmallRingText];
            break ;
        }
        case CLKComplicationFamilyUtilitarianLarge:
        {
            template = complicationTemplateUtilitarianLargeFlat([data objectForKey:@"symbol"], [data objectForKey:@"color"]);
            break;
        }
        case CLKComplicationFamilyUtilitarianSmall:
        {
            template = complicationTemplateUtilitarianSmallFlat([data objectForKey:@"symbol"], [data objectForKey:@"color"]);
            break;
        }
        case CLKComplicationFamilyExtraLarge:
        {
            //            template = complicationTemplateExtraLargeSimpleText([data objectForKey:@"symbol"], [data objectForKey:@"color"]);
            long hour = [(NSNumber *)[data objectForKey:@"hour"] longValue] + 1;
            float dayExpiry = ((hour * 60) * 60) / SECONDS_PER_DAY;
            template = complicationTemplateExtraLargeRingImage([data objectForKey:@"symbol"], CLKComplicationRingStyleOpen, dayExpiry, [data objectForKey:@"color"]);
            break;
        }
        case CLKComplicationFamilyCircularSmall:
        {
            template = complicationTemplateCircularSmallSimpleText([data objectForKey:@"symbol"], [data objectForKey:@"color"]);
            //            template = [self complicationTemplateCircularSmallStackText];
            break;
        }
        case CLKComplicationFamilyGraphicCorner:
        {
            template = complicationTemplateGraphicCornerGaugeText([data objectForKey:@"symbol"], [data objectForKey:@"color"], [data objectForKey:@"hour"], [data objectForKey:@"start"], [data objectForKey:@"end"]);
            break;
        }
        case CLKComplicationFamilyGraphicCircular:
        {
            template = complicationTemplateGraphicCircularOpenGaugeRangeText([data objectForKey:@"symbol"], [data objectForKey:@"color"], [data objectForKey:@"hour"], [data objectForKey:@"start"], [data objectForKey:@"end"]);
            break;
        }
        default:
        {
            break;
        }
    }
    
    return template;
};

#pragma mark - Timeline Configuration

- (void)getSupportedTimeTravelDirectionsForComplication:(CLKComplication *)complication withHandler:(void(^)(CLKComplicationTimeTravelDirections directions))handler {
    handler(CLKComplicationTimeTravelDirectionForward|CLKComplicationTimeTravelDirectionBackward);
}

- (void)getTimelineStartDateForComplication:(CLKComplication *)complication withHandler:(void(^)(NSDate * __nullable date))handler {
    handler(nil);
}

- (void)getTimelineEndDateForComplication:(CLKComplication *)complication withHandler:(void(^)(NSDate * __nullable date))handler {
    handler(nil);
}

- (void)getPrivacyBehaviorForComplication:(CLKComplication *)complication withHandler:(void(^)(CLKComplicationPrivacyBehavior privacyBehavior))handler {
    handler(CLKComplicationPrivacyBehaviorShowOnLockScreen);
}

#pragma mark - Timeline Population

- (void)getCurrentTimelineEntryForComplication:(CLKComplication *)complication withHandler:(void(^)(CLKComplicationTimelineEntry * __nullable))handler {
    __block CLKComplicationTemplate *template;
    
    NSIndexSet *daysIndices  = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, 1)];
    NSIndexSet *dataIndices  = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, 8)];
    NSIndexSet *hoursIndices = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, 24)];
    [PlanetaryHourDataSource.data solarCyclesForDays:daysIndices
                                   planetaryHourData:dataIndices
                                      planetaryHours:hoursIndices
                           solarCycleCompletionBlock:nil
                        planetaryHourCompletionBlock:^(NSDictionary<NSNumber *,id> * _Nonnull planetaryHour) {
                               NSDateInterval *dateInterval = [[NSDateInterval alloc] initWithStartDate:[planetaryHour objectForKey:@(StartDate)] endDate:[planetaryHour objectForKey:@(EndDate)]];
                               if ([dateInterval containsDate:[NSDate date]])
                               {
                                   template = templateForComplication(complication.family, planetaryHour);
                                   CLKComplicationTimelineEntry *tle = [CLKComplicationTimelineEntry entryWithDate:[planetaryHour objectForKey:@(StartDate)] complicationTemplate:template] ;
                                   handler(tle);
                               }
                           }
                       planetaryHoursCompletionBlock:nil
              planetaryHourDataSourceCompletionBlock:nil];
}

- (void)getTimelineEntriesForComplication:(CLKComplication *)complication beforeDate:(NSDate *)date limit:(NSUInteger)limit withHandler:(void(^)(NSArray<CLKComplicationTimelineEntry *> * __nullable entries))handler {
    // Call the handler with the timeline entries prior to the given date
    handler(nil);
}

- (void)getTimelineEntriesForComplication:(CLKComplication *)complication afterDate:(NSDate *)date limit:(NSUInteger)limit withHandler:(void(^)(NSArray<CLKComplicationTimelineEntry *> * __nullable entries))handler {
    // Call the handler with the timeline entries after to the given date
    handler(nil);
}

#pragma mark - Placeholder Templates

- (void)getLocalizableSampleTemplateForComplication:(CLKComplication *)complication withHandler:(void(^)(CLKComplicationTemplate * __nullable complicationTemplate))handler {
    // This method will be called once per supported complication, and the results will be cached
    handler(nil);
}

@end
