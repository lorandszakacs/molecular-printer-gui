//
//  Configuration.m
//  Molecular Printer
//
//  Created by Eric Lin on 12/1/13.
//  Copyright (c) 2013 Lorand Szakacs. All rights reserved.
//

#import "Configuration.h"

#pragma mark NSCoding

#define kTitleKey   @"Title"
#define kTempKey    @"Temperature"
#define kHumidKey   @"Humidity"
#define kWidthKey   @"Width"
#define kHeightKey   @"Height"
#define kSpotKey    @"Spot"

@implementation Configuration

-(void) encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:_title forKey:kTitleKey];
    [encoder encodeFloat:_temp forKey:kTempKey];
    [encoder encodeFloat:_humid forKey:kHumidKey];
    [encoder encodeFloat:_width forKey:kWidthKey];
    [encoder encodeFloat:_height forKey:kHeightKey];
    [encoder encodeFloat:_spot forKey:kSpotKey];
}

-(id)initWithCoder:(NSCoder *)decoder{
    NSString *title = [decoder decodeObjectForKey:kTitleKey];
    float temp = [decoder decodeFloatForKey:kTempKey];
    float humid = [decoder decodeFloatForKey:kHumidKey];
    float width = [decoder decodeFloatForKey:kWidthKey];
    float height = [decoder decodeFloatForKey:kHeightKey];
    float spot = [decoder decodeFloatForKey:kSpotKey];
    return [self initConfig:title :temp :humid :width :height :spot];
}

-(id)initConfig:(NSString*)title :(float) temp :(float) humid :(float)width :(float)height :(float)spot{
    self = [super init];
    self.title = title;
    self.temp = temp;
    self.humid = humid;
    self.width = width;
    self.height = height;
    self.spot = spot;
    return self;
}

@end



