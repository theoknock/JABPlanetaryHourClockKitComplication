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
    //printf("%s", __PRETTY_FUNCTION__);
    CLKComplicationTemplateModularLargeTallBody *template = [[CLKComplicationTemplateModularLargeTallBody alloc] init];
    template.headerTextProvider = [CLKSimpleTextProvider textProviderWithText:(headerText) ? headerText : @"㊏"];
    template.headerTextProvider.tintColor = tint;
    template.bodyTextProvider = [CLKSimpleTextProvider textProviderWithText:(bodyText) ? bodyText : @"㊏"];
    template.bodyTextProvider.tintColor = tint;
    template.tintColor = tint;
    
    return template;
};

CLKComplicationTemplateModularLargeTable *(^complicationTemplateModularLargeTable)(NSString *, NSString *, NSString *, NSString *, NSString *, UIColor *) = ^(NSString *text, NSString *row1Column1TextProvider, NSString *row1Column2TextProvider, NSString *row2Column1TextProvider, NSString *row2Column2TextProvider, UIColor *tintColor)
{
    printf("%s", __PRETTY_FUNCTION__);
    CLKComplicationTemplateModularLargeTable *template = [[CLKComplicationTemplateModularLargeTable alloc] init];
    template.headerTextProvider = [CLKSimpleTextProvider textProviderWithText:(text) ? text : @"㊏"];
    template.headerTextProvider.tintColor = tintColor;
    template.row1Column1TextProvider = [CLKSimpleTextProvider textProviderWithText:(row1Column1TextProvider) ? row1Column1TextProvider : @"㊏"];
    template.row1Column2TextProvider = [CLKSimpleTextProvider textProviderWithText:(row1Column2TextProvider) ? row1Column2TextProvider : @"㊏"];
    template.row2Column1TextProvider = [CLKSimpleTextProvider textProviderWithText:(row2Column1TextProvider) ? row2Column1TextProvider : @"㊏"];
    template.row2Column2TextProvider = [CLKSimpleTextProvider textProviderWithText:(row2Column2TextProvider) ? row2Column2TextProvider : @"㊏"];
    template.tintColor = tintColor;
    //    template.headerImageProvider = [CLKImageProvider imageProviderWithOnePieceImage:[PlanetaryHourDataSource.data imageFromText](text, color, 72.0)];
    
    return template;
};

CLKComplicationTemplateModularSmallSimpleText *(^complicationTemplateModularSmallSimpleText)(NSString *, UIColor *) = ^(NSString *text, UIColor *tint)
{
    //printf("%s", __PRETTY_FUNCTION__);
    CLKComplicationTemplateModularSmallSimpleText *template = [[CLKComplicationTemplateModularSmallSimpleText alloc] init];
    template.textProvider = [CLKSimpleTextProvider textProviderWithText:(text) ? text : @"㊏"];
    template.textProvider.tintColor = tint;
    template.tintColor = tint;
    
    return template;
};


CLKComplicationTemplateUtilitarianLargeFlat *(^complicationTemplateUtilitarianLargeFlat)(NSString *, UIColor *) = ^(NSString *text, UIColor *tint)
{
    //printf("%s", __PRETTY_FUNCTION__);
    CLKComplicationTemplateUtilitarianLargeFlat *template = [[CLKComplicationTemplateUtilitarianLargeFlat alloc] init];
    template.textProvider = [CLKSimpleTextProvider textProviderWithText:(text) ? text : @"㊏"];
    template.textProvider.tintColor = tint;
    template.tintColor = tint;
    
    return template;
};

CLKComplicationTemplateUtilitarianSmallFlat *(^complicationTemplateUtilitarianSmallFlat)(NSString *, UIColor *) = ^(NSString *text, UIColor *tint)
{
    //printf("%s", __PRETTY_FUNCTION__);
    CLKComplicationTemplateUtilitarianSmallFlat *template = [[CLKComplicationTemplateUtilitarianSmallFlat alloc] init];
    template.textProvider = [CLKSimpleTextProvider textProviderWithText:(text) ? text : @"㊏"];
    template.textProvider.tintColor = tint;
    template.tintColor = tint;
    
    return template;
};

CLKComplicationTemplateExtraLargeSimpleText *(^complicationTemplateExtraLargeSimpleText)(NSString *, UIColor *) = ^(NSString *text, UIColor *tint)
{
    //printf("%s", __PRETTY_FUNCTION__);
    CLKComplicationTemplateExtraLargeSimpleText *template = [[CLKComplicationTemplateExtraLargeSimpleText alloc] init];
    template.textProvider = [CLKSimpleTextProvider textProviderWithText:(text) ? text : @"㊏"];
    template.textProvider.tintColor = tint;
    template.tintColor = tint;
    
    return template;
};

CLKComplicationTemplateExtraLargeRingText *(^complicationTemplateExtraLargeRingText)(NSString *, UIColor *, CLKComplicationRingStyle, float) = ^(NSString *text, UIColor *tint, CLKComplicationRingStyle ringStyle, float fillFraction)
{
    //printf("%s", __PRETTY_FUNCTION__);
    CLKComplicationTemplateExtraLargeRingText *template = [[CLKComplicationTemplateExtraLargeRingText alloc] init];
    template.textProvider = [CLKSimpleTextProvider textProviderWithText:(text) ? text : @"㊏"];
    template.textProvider.tintColor = tint;
    template.tintColor = tint;
    template.ringStyle = ringStyle;
    template.fillFraction = fillFraction;
    
    return template;
};

CLKComplicationTemplateCircularSmallSimpleText *(^complicationTemplateCircularSmallSimpleText)(NSString *, UIColor *) = ^(NSString *text, UIColor *tint)
{
    //printf("%s", __PRETTY_FUNCTION__);
    CLKComplicationTemplateCircularSmallSimpleText *template = [[CLKComplicationTemplateCircularSmallSimpleText alloc] init];
    template.textProvider = [CLKSimpleTextProvider textProviderWithText:(text) ? text : @"㊏"];
    template.textProvider.tintColor = tint;
    template.tintColor = tint;
    
    return template;
};

CLKComplicationTemplateCircularSmallStackText *(^complicationTemplateCircularSmallStackText)(NSString *, NSString *, UIColor *) = ^(NSString *line1text, NSString *line2Text, UIColor *tintColor)
{
    //printf("%s", __PRETTY_FUNCTION__);
    CLKComplicationTemplateCircularSmallStackText *template = [[CLKComplicationTemplateCircularSmallStackText alloc] init];
    template.line1TextProvider = [CLKSimpleTextProvider textProviderWithText:(line1text) ? line1text : @"㊏"];
    template.line1TextProvider.tintColor = tintColor;
    template.line2TextProvider = [CLKSimpleTextProvider textProviderWithText:(line2Text) ? line2Text : @"Earth"];
    
    return template;
};

CLKComplicationTemplateExtraLargeRingImage *(^complicationTemplateExtraLargeRingImage)(NSString *, CLKComplicationRingStyle, float, UIColor *) = ^(NSString *text, CLKComplicationRingStyle ringStyle, float fillFraction, UIColor *tintColor)
{
    //    printf("%s", __PRETTY_FUNCTION__);
    CLKComplicationTemplateExtraLargeRingImage *template = [[CLKComplicationTemplateExtraLargeRingImage alloc] init];
    template.imageProvider = [CLKImageProvider imageProviderWithOnePieceImage:[PlanetaryHourDataSource.data imageFromText](text, tintColor, 72.0)];
    template.ringStyle = ringStyle;
    template.fillFraction = fillFraction;
    template.tintColor = tintColor;
    
    return template;
};

CLKComplicationTemplateModularSmallRingText *(^complicationTemplateModularSmallRingText)(NSString *, UIColor *, CLKComplicationRingStyle, float)  = ^(NSString *text, UIColor *tintColor, CLKComplicationRingStyle ringStyle, float fillFraction)
{
    //printf("%s", __PRETTY_FUNCTION__);
    CLKComplicationTemplateModularSmallRingText *template = [[CLKComplicationTemplateModularSmallRingText alloc] init];
    template.textProvider = [CLKSimpleTextProvider textProviderWithText:(text) ? text : @"㊏"];
    template.textProvider.tintColor = tintColor;
    template.ringStyle    = ringStyle;
    template.fillFraction = fillFraction;
    
    return template;
};

CLKComplicationTemplateGraphicCornerGaugeText *(^complicationTemplateGraphicCornerGaugeText)(NSString *, UIColor *, NSNumber *, NSDate *, NSDate *) = ^(NSString *symbol, UIColor *tintColor, NSNumber *hour, NSDate *startDate, NSDate *endDate)
{
    //printf("%s", __PRETTY_FUNCTION__);
    CLKComplicationTemplateGraphicCornerGaugeText *template = [[CLKComplicationTemplateGraphicCornerGaugeText alloc] init];
    template.tintColor             = tintColor;
    
    Planet leadingPlanet           = (symbol) ? ([PlanetaryHourDataSource.data planetForPlanetSymbol](symbol) + 1) % NUMBER_OF_PLANETS : (Planet)NAN;
    NSString *leadingPlanetSymbol  = (leadingPlanet != NAN) ? [PlanetaryHourDataSource.data planetSymbolForPlanet](leadingPlanet) : @"㊏";
    UIColor *leadingPlanetColor    = [PlanetaryHourDataSource.data colorForPlanetSymbol]((leadingPlanetSymbol) ? leadingPlanetSymbol : @"㊏");
    
    Planet trailingPlanet          = (symbol) ? ([PlanetaryHourDataSource.data planetForPlanetSymbol](symbol) + 6) % NUMBER_OF_PLANETS : (Planet)NAN;
    NSString *trailingPlanetSymbol = (trailingPlanet != NAN) ? [PlanetaryHourDataSource.data planetSymbolForPlanet](trailingPlanet) : @"㊏";
    UIColor *trailingPlanetColor   = [PlanetaryHourDataSource.data colorForPlanetSymbol]((trailingPlanetSymbol) ? trailingPlanetSymbol : @"㊏");
    
    template.outerTextProvider     = [CLKSimpleTextProvider textProviderWithText:(symbol) ? symbol : @"㊏"];
    template.outerTextProvider.tintColor = tintColor;
    template.trailingTextProvider  = [CLKSimpleTextProvider textProviderWithText:(leadingPlanetSymbol) ? leadingPlanetSymbol : @"㊏"];
    template.trailingTextProvider.tintColor = leadingPlanetColor;
    template.leadingTextProvider   = [CLKSimpleTextProvider textProviderWithText:(trailingPlanetSymbol) ? trailingPlanetSymbol : @"㊏"];
    template.leadingTextProvider.tintColor = trailingPlanetColor;
    
    template.gaugeProvider         = [CLKTimeIntervalGaugeProvider gaugeProviderWithStyle:CLKGaugeProviderStyleRing gaugeColors:@[trailingPlanetColor, tintColor, leadingPlanetColor] gaugeColorLocations:@[[NSNumber numberWithFloat:0.0], [NSNumber numberWithFloat:0.5], [NSNumber numberWithFloat:1.0]] startDate:startDate startFillFraction:0.0 endDate:endDate endFillFraction:1.0];
    
    return template;
};

CLKComplicationTemplateGraphicCircularOpenGaugeImage *(^complicationTemplateGraphicCircularOpenGaugeImage)(NSString *, UIColor *, NSNumber *, NSDate *, NSDate *, NSArray<UIColor *> *, NSArray<NSNumber *> *, CLKGaugeProviderStyle) = ^(NSString *symbol, UIColor *tintColor, NSNumber *hour, NSDate *startDate, NSDate *endDate, NSArray<UIColor *> *gaugeColors, NSArray<NSNumber *> *gaugeColorLocations, CLKGaugeProviderStyle style)
{
    //printf("%s", __PRETTY_FUNCTION__);
    CLKComplicationTemplateGraphicCircularOpenGaugeImage *template = [[CLKComplicationTemplateGraphicCircularOpenGaugeImage alloc] init];
    template.centerTextProvider  = [CLKSimpleTextProvider textProviderWithText:(symbol) ? symbol : @"㊏"];
    template.centerTextProvider.tintColor = tintColor;
    template.bottomImageProvider = [CLKFullColorImageProvider providerWithFullColorImage:[PlanetaryHourDataSource.data imageFromText]([NSString stringWithFormat:@"%ld", hour.longValue], tintColor, 9.0)];
    template.gaugeProvider       = [CLKTimeIntervalGaugeProvider gaugeProviderWithStyle:style gaugeColors:gaugeColors gaugeColorLocations:gaugeColorLocations startDate:startDate endDate:endDate];
    
    return template;
};

CLKComplicationTemplateGraphicCircularOpenGaugeRangeText *(^complicationTemplateGraphicCircularOpenGaugeRangeText)(NSString *, UIColor *, NSNumber *, NSDate *, NSDate *) = ^(NSString *symbol, UIColor *tintColor, NSNumber *hour, NSDate *startDate, NSDate *endDate)
{
    //printf("%s", __PRETTY_FUNCTION__);
    CLKComplicationTemplateGraphicCircularOpenGaugeRangeText *template = [[CLKComplicationTemplateGraphicCircularOpenGaugeRangeText alloc] init];
    template.tintColor             = tintColor;
    
    Planet leadingPlanet           = (Planet)([PlanetaryHourDataSource.data planetForPlanetSymbol](symbol) + 1) % NUMBER_OF_PLANETS;
    NSString *leadingPlanetSymbol  = [PlanetaryHourDataSource.data planetSymbolForPlanet](leadingPlanet);
    UIColor *leadingPlanetColor    = [PlanetaryHourDataSource.data colorForPlanetSymbol](leadingPlanetSymbol);
    
    Planet trailingPlanet          = (Planet)([PlanetaryHourDataSource.data planetForPlanetSymbol](symbol) + 6) % NUMBER_OF_PLANETS;
    NSString *trailingPlanetSymbol = [PlanetaryHourDataSource.data planetSymbolForPlanet](trailingPlanet);
    UIColor *trailingPlanetColor   = [PlanetaryHourDataSource.data colorForPlanetSymbol](trailingPlanetSymbol);
    
    template.centerTextProvider    = [CLKSimpleTextProvider textProviderWithText:symbol];
    template.centerTextProvider.tintColor = tintColor;
    template.trailingTextProvider  = [CLKSimpleTextProvider textProviderWithText:(leadingPlanetSymbol) ? leadingPlanetSymbol : @"㊏"];
    template.trailingTextProvider.tintColor = leadingPlanetColor;
    template.leadingTextProvider   = [CLKSimpleTextProvider textProviderWithText:(trailingPlanetSymbol) ? trailingPlanetSymbol : @"㊏"];
    template.leadingTextProvider.tintColor = trailingPlanetColor;
    
    template.gaugeProvider         = [CLKTimeIntervalGaugeProvider gaugeProviderWithStyle:CLKGaugeProviderStyleRing gaugeColors:@[trailingPlanetColor, tintColor, leadingPlanetColor] gaugeColorLocations:@[[NSNumber numberWithFloat:0.0], [NSNumber numberWithFloat:0.5], [NSNumber numberWithFloat:1.0]] startDate:startDate startFillFraction:0.0 endDate:endDate endFillFraction:1.0];
    
    return template;
};

CLKComplicationTemplateGraphicRectangularTextGauge *(^complicationTemplateGraphicRectangularTextGauge)(NSString *, NSString *, UIColor *, NSDate *, NSDate *) = ^(NSString *symbol, NSString *name, UIColor *tintColor, NSDate *startDate, NSDate *endDate)
{
    //printf("%s", __PRETTY_FUNCTION__);
    CLKComplicationTemplateGraphicRectangularTextGauge *template = [[CLKComplicationTemplateGraphicRectangularTextGauge alloc] init];
    template.tintColor             = tintColor;
    
    Planet leadingPlanet           = (Planet)([PlanetaryHourDataSource.data planetForPlanetSymbol](symbol) + 1) % NUMBER_OF_PLANETS;
    NSString *leadingPlanetSymbol  = [PlanetaryHourDataSource.data planetSymbolForPlanet](leadingPlanet);
    UIColor *leadingPlanetColor    = [PlanetaryHourDataSource.data colorForPlanetSymbol](leadingPlanetSymbol);
    
    Planet trailingPlanet          = (Planet)([PlanetaryHourDataSource.data planetForPlanetSymbol](symbol) + 6) % NUMBER_OF_PLANETS;
    NSString *trailingPlanetSymbol = [PlanetaryHourDataSource.data planetSymbolForPlanet](trailingPlanet);
    UIColor *trailingPlanetColor   = [PlanetaryHourDataSource.data colorForPlanetSymbol](trailingPlanetSymbol);
    
    //    [template setHeaderImageProvider:[CLKFullColorImageProvider providerWithFullColorImage:[PlanetaryHourDataSource.data imageFromText](symbol, tintColor, 48.0)]];
    [template setHeaderTextProvider:[CLKSimpleTextProvider textProviderWithText:[NSString stringWithFormat:@"%@ %@", symbol, name]]];
    [template.headerTextProvider setTintColor:tintColor];
    
    NSDateFormatter *startDateFormatter = [[NSDateFormatter alloc] init];
    startDateFormatter.timeStyle        = NSDateFormatterShortStyle;
    NSString *startDateString           = [startDateFormatter stringFromDate:startDate];
    
    NSDateFormatter *endDateFormatter   = [[NSDateFormatter alloc] init];
    endDateFormatter.timeStyle          = NSDateFormatterShortStyle;
    NSString *endDateString             = [endDateFormatter stringFromDate:endDate];
    [template setBody1TextProvider:[CLKSimpleTextProvider textProviderWithText:[NSString stringWithFormat:@"%@ - %@", startDateString, endDateString]]];
    [template setGaugeProvider:[CLKTimeIntervalGaugeProvider gaugeProviderWithStyle:CLKGaugeProviderStyleRing gaugeColors:@[trailingPlanetColor, tintColor, leadingPlanetColor] gaugeColorLocations:@[[NSNumber numberWithFloat:0.0], [NSNumber numberWithFloat:0.5], [NSNumber numberWithFloat:1.0]] startDate:startDate startFillFraction:0.0 endDate:endDate endFillFraction:1.0]];
    
    return template;
};

CLKComplicationTemplateGraphicCircularImage * (^complicationTemplateGraphicCircularImage)(NSString *, UIColor *) = ^(NSString *symbol, UIColor *tintColor)
{
    CLKComplicationTemplateGraphicCircularImage *template = [[CLKComplicationTemplateGraphicCircularImage alloc] init];
    template.imageProvider = [CLKFullColorImageProvider providerWithFullColorImage:[PlanetaryHourDataSource.data imageFromText](symbol, tintColor, 48.0)];
    
    return template;
};

CLKComplicationTemplateGraphicBezelCircularText *(^complicationTemplateGraphicBezelCircularText)(NSString *, NSString *, NSNumber *, UIColor *) = ^(NSString *symbol, NSString *name, NSNumber *hour, UIColor *tintColor)
{
    //printf("%s", __PRETTY_FUNCTION__);
    CLKComplicationTemplateGraphicBezelCircularText *template = [[CLKComplicationTemplateGraphicBezelCircularText alloc] init];
    NSString *text = [NSString stringWithFormat:@"%@ %@ Hour %@", symbol, name, [NSString stringWithFormat:@"%lu", ((unsigned long)hour.unsignedIntegerValue + 1)]];
    template.textProvider    = [CLKSimpleTextProvider textProviderWithText:text];
    
    template.circularTemplate = complicationTemplateGraphicCircularImage(symbol, tintColor);
    
    return template;
};

CLKComplicationTemplate *(^templateForComplication)(CLKComplicationFamily, NSDictionary *) = ^(CLKComplicationFamily family, NSDictionary *data) {
    //printf("%s", __PRETTY_FUNCTION__);
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
            
            template = complicationTemplateModularLargeTable([(NSAttributedString *)[data objectForKey:@(Symbol)] string], [data objectForKey:@(Name)], hourString, startDateString, endDateString, [data objectForKey:@(Color)]);
            //            template = complicationTemplateModularLargeTallBody([data objectForKey:@"symbol"], [data objectForKey:@"name"], [data objectForKey:@"color"]);
            break ;
        }
        case CLKComplicationFamilyModularSmall:
        {
            template = complicationTemplateModularSmallSimpleText([(NSAttributedString *)[data objectForKey:@(Symbol)] string], [data objectForKey:@(Color)]);
            //            template = [self complicationTemplateModularSmallRingText];
            break ;
        }
        case CLKComplicationFamilyUtilitarianLarge:
        {
            template = complicationTemplateUtilitarianLargeFlat([(NSAttributedString *)[data objectForKey:@(Symbol)] string], [data objectForKey:@(Color)]);
            break;
        }
        case CLKComplicationFamilyUtilitarianSmall:
        {
            template = complicationTemplateUtilitarianSmallFlat([(NSAttributedString *)[data objectForKey:@(Symbol)] string], [data objectForKey:@(Color)]);
            break;
        }
        case CLKComplicationFamilyExtraLarge:
        {
            //            template = complicationTemplateExtraLargeSimpleText([data objectForKey:@"symbol"], [data objectForKey:@"color"]);
            long hour = [(NSNumber *)[data objectForKey:@(Hour)] longValue] + 1;
            float dayExpiry = ((hour * 60) * 60) / SECONDS_PER_DAY;
            //            template = complicationTemplateExtraLargeRingImage([(NSAttributedString *)[data objectForKey:@(Symbol)] string], CLKComplicationRingStyleOpen, dayExpiry, (UIColor *)[data objectForKey:@(Color)]);
            template = complicationTemplateExtraLargeRingText([(NSAttributedString *)[data objectForKey:@(Symbol)] string], (UIColor *)[data objectForKey:@(Color)], CLKComplicationRingStyleOpen, dayExpiry);
            break;
        }
        case CLKComplicationFamilyCircularSmall:
        {
            template = complicationTemplateCircularSmallSimpleText([(NSAttributedString *)[data objectForKey:@(Symbol)] string], [data objectForKey:@(Color)]);
            //            template = [self complicationTemplateCircularSmallStackText];
            break;
        }
        case CLKComplicationFamilyGraphicCorner:
        {
            template = complicationTemplateGraphicCornerGaugeText([(NSAttributedString *)[data objectForKey:@(Symbol)] string], [data objectForKey:@(Color)], [data objectForKey:@(Hour)], [data objectForKey:@(StartDate)], [data objectForKey:@(EndDate)]);
            break;
        }
        case CLKComplicationFamilyGraphicBezel:
        {
            template = complicationTemplateGraphicBezelCircularText([(NSAttributedString *)[data objectForKey:@(Symbol)] string], (NSString *)[data objectForKey:@(Name)], (NSNumber *)[data objectForKey:@(Hour)], (UIColor *)[data objectForKey:@(Color)]);
            break;
        }
        case CLKComplicationFamilyGraphicCircular:
        {
            template = complicationTemplateGraphicCircularOpenGaugeRangeText([(NSAttributedString *)[data objectForKey:@(Symbol)] string], [data objectForKey:@(Color)], [data objectForKey:@(Hour)], [data objectForKey:@(StartDate)], [data objectForKey:@(EndDate)]);
            break;
        }
        case CLKComplicationFamilyGraphicRectangular:
        {
            template = complicationTemplateGraphicRectangularTextGauge([(NSAttributedString *)[data objectForKey:@(Symbol)] string], [data objectForKey:@(Name)], [data objectForKey:@(Color)], [data objectForKey:@(StartDate)], [data objectForKey:@(EndDate)]);
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
    handler(CLKComplicationTimeTravelDirectionForward);
}

- (void)getTimelineStartDateForComplication:(CLKComplication *)complication withHandler:(void(^)(NSDate * __nullable date))handler {
    handler([NSDate date]);
}

- (void)getTimelineEndDateForComplication:(CLKComplication *)complication withHandler:(void(^)(NSDate * __nullable date))handler {
    handler([NSDate distantFuture]);
}

- (void)getPrivacyBehaviorForComplication:(CLKComplication *)complication withHandler:(void(^)(CLKComplicationPrivacyBehavior privacyBehavior))handler {
    handler(CLKComplicationPrivacyBehaviorShowOnLockScreen);
}

#pragma mark - Timeline Population

- (void)getCurrentTimelineEntryForComplication:(CLKComplication *)complication withHandler:(void(^)(CLKComplicationTimelineEntry * __nullable))handler {
    __block CLKComplicationTemplate *template;
    __block CLKComplicationTimelineEntry *tle;
    
    NSIndexSet *daysIndices  = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, 1)];
    NSIndexSet *dataIndices  = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, 8)];
    NSIndexSet *hoursIndices = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, 24)];
    
    [PlanetaryHourDataSource.data solarCyclesForDays:daysIndices planetaryHourData:dataIndices planetaryHours:hoursIndices
                           solarCycleCompletionBlock:nil
                        planetaryHourCompletionBlock:nil
                       planetaryHoursCompletionBlock:^(NSArray<NSDictionary<NSNumber *,id> *> * _Nonnull planetaryHours) {
        [ExtensionDelegate log:@"ClockKit Complication" entry:[NSString stringWithFormat:@"Getting current timeline entry for complication: %@", complication.description] status:LogEntryTypeOperation];
        
        [planetaryHours enumerateObjectsUsingBlock:^(NSDictionary<NSNumber *,id> * _Nonnull planetaryHour, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDateInterval *dateInterval = [[NSDateInterval alloc] initWithStartDate:[planetaryHour objectForKey:@(StartDate)] endDate:[planetaryHour objectForKey:@(EndDate)]];
            NSLog(@"\nDate: %@ and %@ %@ %@\n", [planetaryHour objectForKey:@(StartDate)], [planetaryHour objectForKey:@(EndDate)], ([dateInterval containsDate:[NSDate date]]) ? @"contain" : @"do not contain", [NSDate date]);
            
            if ([dateInterval containsDate:[NSDate date]])
            {
                template = templateForComplication(complication.family, planetaryHour);
                tle = [CLKComplicationTimelineEntry entryWithDate:[planetaryHour objectForKey:@(StartDate)] complicationTemplate:template];
            } else if (idx == hoursIndices.lastIndex && template == nil) {
                NSLog(@"idx %d == hourIndices lastIndex %d (%d planetary hours)", idx, hoursIndices.lastIndex, planetaryHours.count);
                template = templateForComplication(complication.family, [PlanetaryHourDataSource.data placeholderPlanetaryHourData]);
                tle = [CLKComplicationTimelineEntry entryWithDate:[NSDate date] complicationTemplate:template];
            }
        }];
        
        handler(tle);
        
    } planetaryHourDataSourceCompletionBlock:^(NSError * _Nullable error) {
        if (error)
            [ExtensionDelegate log:@"JABPlanetaryHourWatchFramework" entry:[NSString stringWithFormat:@"Error calculating planetary hours: %@", error] status:LogEntryTypeError];
        else
            [ExtensionDelegate log:@"ClockKit Complication" entry:[NSString stringWithFormat:@"Retrieved current timeline entry for complication: %@", complication.description] status:LogEntryTypeSuccess];
    }];
    
    //    [PlanetaryHourDataSource.data
    //     solarCyclesForDays:daysIndices
    //     planetaryHourData:dataIndices
    //     planetaryHours:hoursIndices
    //     planetaryHourDataSourceStartCompletionBlock:nil
    //     solarCycleCompletionBlock:nil
    //     planetaryHourCompletionBlock:nil
    //     planetaryHoursCompletionBlock:^(NSArray<NSDictionary<NSNumber *,id> *> * _Nonnull planetaryHours) {
    //         [ExtensionDelegate log:@"ClockKit Complication" entry:[NSString stringWithFormat:@"Getting current timeline entry for complication: %@", complication.description] status:LogEntryTypeOperation];
    //
    //         [planetaryHours enumerateObjectsUsingBlock:^(NSDictionary<NSNumber *,id> * _Nonnull planetaryHour, NSUInteger idx, BOOL * _Nonnull stop) {
    //             NSDateInterval *dateInterval = [[NSDateInterval alloc] initWithStartDate:[planetaryHour objectForKey:@(StartDate)] endDate:[planetaryHour objectForKey:@(EndDate)]];
    //             NSLog(@"\nDate: %@ and %@ %@ %@\n", [planetaryHour objectForKey:@(StartDate)], [planetaryHour objectForKey:@(EndDate)], ([dateInterval containsDate:[NSDate date]]) ? @"contain" : @"do not contain", [NSDate date]);
    //
    //             if ([dateInterval containsDate:[NSDate date]])
    //             {
    //                 template = templateForComplication(complication.family, planetaryHour);
    //                 tle = [CLKComplicationTimelineEntry entryWithDate:[planetaryHour objectForKey:@(StartDate)] complicationTemplate:template];
    //             } else if (idx == hoursIndices.lastIndex && template == nil) {
    //                 NSLog(@"idx %d == hourIndices lastIndex %d (%d planetary hours)", idx, hoursIndices.lastIndex, planetaryHours.count);
    //                 template = templateForComplication(complication.family, [PlanetaryHourDataSource.data placeholderPlanetaryHourData]);
    //                 tle = [CLKComplicationTimelineEntry entryWithDate:[NSDate date] complicationTemplate:template];
    //             }
    //         }];
    //
    //        handler(tle);
    //     }
    //     planetaryHoursCalculationsCompletionBlock:nil
    //     planetaryHourDataSourceCompletionBlock:^(NSError * _Nullable error) {
    //         if (error)
    //             [ExtensionDelegate log:@"JABPlanetaryHourWatchFramework" entry:[NSString stringWithFormat:@"Error calculating planetary hours: %@", error] status:LogEntryTypeError];
    //         else
    //             [ExtensionDelegate log:@"ClockKit Complication" entry:[NSString stringWithFormat:@"Retrieved current timeline entry for complication: %@", complication.description] status:LogEntryTypeSuccess];
    //     }];
}

- (void)getTimelineEntriesForComplication:(CLKComplication *)complication beforeDate:(NSDate *)date limit:(NSUInteger)limit withHandler:(void(^)(NSArray<CLKComplicationTimelineEntry *> * __nullable entries))handler {
    handler(nil);
}

- (void)getTimelineEntriesForComplication:(CLKComplication *)complication afterDate:(NSDate *)date limit:(NSUInteger)limit withHandler:(void(^)(NSArray<CLKComplicationTimelineEntry *> * __nullable entries))handler {
    if (ExtensionDelegate.session.reachable)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [ExtensionDelegate log:@"WatchKit session (ClockKit Complication)" entry:@"Sending command to calendar timeline entries..." status:LogEntryTypeOperation];
            [ExtensionDelegate.session sendMessage:@{@"command" : @"calendar", @"numberOfHours" : @(limit)} replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
                [ExtensionDelegate log:@"WatchKit session (ClockKit Complication)" entry:[NSString stringWithFormat:@"Command to calendar planetary hours sent with reply: %@", [replyMessage objectForKey:@"reply"]] status:LogEntryTypeSuccess];
                NSLog(@"%@", [replyMessage objectForKey:@"reply"]);
            } errorHandler:^(NSError * _Nonnull error) {
                [ExtensionDelegate log:@"WatchKit session (ClockKit Complication)" entry:[NSString stringWithFormat:@"Error sending command to calendar planetary hours: %@", error.description] status:LogEntryTypeError];
                NSLog(@"Error sending message: %@", error.description);
            }];
        });
    }
    
    [ExtensionDelegate log:@"ClockKit Complication" entry:[NSString stringWithFormat:@"Requested %d timeline entries for %@", limit, date] status:LogEntryTypeEvent];
    __block NSMutableArray<CLKComplicationTimelineEntry *> *planetaryHourTimelineEntries = [[NSMutableArray alloc] initWithCapacity:limit];
    
    __block NSUInteger numberOfHours = 0;
    NSIndexSet *daysIndices  = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, (limit / 24) + 1)];
    NSMutableIndexSet *dataIndices  = [[NSMutableIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, 4)];
    [dataIndices addIndexesInRange:NSMakeRange(5, 2)];
    NSIndexSet *hoursIndices = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, 24)];
    
    
    [PlanetaryHourDataSource.data solarCyclesForDays:daysIndices planetaryHourData:dataIndices planetaryHours:hoursIndices
                           solarCycleCompletionBlock:nil
                        planetaryHourCompletionBlock:^(NSDictionary<NSNumber *,id> * _Nonnull planetaryHour) {
        if (numberOfHours < limit)
        {
            numberOfHours++;
            CLKComplicationTemplate *template = templateForComplication(complication.family, planetaryHour);
            CLKComplicationTimelineEntry *tle = [CLKComplicationTimelineEntry entryWithDate:[planetaryHour objectForKey:@(StartDate)] complicationTemplate:template];
            [planetaryHourTimelineEntries addObject:tle];
        }
    } planetaryHoursCompletionBlock:nil
              planetaryHourDataSourceCompletionBlock:^(NSError * _Nullable error) {
        handler((NSArray<CLKComplicationTimelineEntry *> *)planetaryHourTimelineEntries);
        if (error)
        {
            [ExtensionDelegate log:@"JABPlanetaryHourWatchFramework" entry:[NSString stringWithFormat:@"Error calculating planetary hours: %@", error] status:LogEntryTypeError];
        } else {
            [ExtensionDelegate log:@"ClockKit Complication" entry:[NSString stringWithFormat:@"Retrieved %d timeline entries for complication: %@", planetaryHourTimelineEntries.count, complication.description] status:LogEntryTypeSuccess];
        }
        
        [ExtensionDelegate setReloadingComplicationTimeline:[NSNumber numberWithBool:FALSE]];
    }];
    
    //    [PlanetaryHourDataSource.data
    //     solarCyclesForDays:daysIndices
    //     planetaryHourData:dataIndices
    //     planetaryHours:hoursIndices
    //     planetaryHourDataSourceStartCompletionBlock:^{
    //         [ExtensionDelegate setReloadingComplicationTimeline:[NSNumber numberWithBool:TRUE]];
    //     }
    //     solarCycleCompletionBlock:nil
    //     planetaryHourCompletionBlock:^(NSDictionary<NSNumber *,id> * _Nonnull planetaryHour) {
    //         if (numberOfHours < limit)
    //         {
    //             numberOfHours++;
    //             CLKComplicationTemplate *template = templateForComplication(complication.family, planetaryHour);
    //             CLKComplicationTimelineEntry *tle = [CLKComplicationTimelineEntry entryWithDate:[planetaryHour objectForKey:@(StartDate)] complicationTemplate:template];
    //             [planetaryHourTimelineEntries addObject:tle];
    //         }
    //     }
    //     planetaryHoursCompletionBlock:^(NSArray<NSDictionary<NSNumber *,id> *> * _Nonnull planetaryHours) {
    //        [ExtensionDelegate addNotificationsForPlanetaryHours:planetaryHours];
    //    }
    //     planetaryHoursCalculationsCompletionBlock:nil
    //     planetaryHourDataSourceCompletionBlock:^(NSError * _Nullable error) {
    //         handler((NSArray<CLKComplicationTimelineEntry *> *)planetaryHourTimelineEntries);
    //         if (error)
    //         {
    //             [ExtensionDelegate log:@"JABPlanetaryHourWatchFramework" entry:[NSString stringWithFormat:@"Error calculating planetary hours: %@", error] status:LogEntryTypeError];
    //         } else {
    //             [ExtensionDelegate log:@"ClockKit Complication" entry:[NSString stringWithFormat:@"Retrieved %d timeline entries for complication: %@", planetaryHourTimelineEntries.count, complication.description] status:LogEntryTypeSuccess];
    //         }
    //
    //         [ExtensionDelegate setReloadingComplicationTimeline:[NSNumber numberWithBool:FALSE]];
    //     }];
}

#pragma mark - Placeholder Templates

- (void)getPlaceholderTemplateForComplication:(CLKComplication *)complication withHandler:(void (^)(CLKComplicationTemplate * _Nullable))handler
{
    handler(templateForComplication(complication.family, [PlanetaryHourDataSource.data placeholderPlanetaryHourData]));
}

- (void)getLocalizableSampleTemplateForComplication:(CLKComplication *)complication withHandler:(void (^)(CLKComplicationTemplate * _Nullable))handler
{
    handler(templateForComplication(complication.family, [PlanetaryHourDataSource.data placeholderPlanetaryHourData]));
}

@end







