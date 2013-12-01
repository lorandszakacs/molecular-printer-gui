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
#define kPitchKey   @"Pitch"
#define kSpotKey    @"Spot"

@implementation Configuration

-(void) encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:_title forKey:kTitleKey];
    [encoder encodeObject:_temp forKey:kTempKey];
    [encoder encodeObject:_humid forKey:kHumidKey];
    [encoder encodeObject:_pitch forKey:kPitchKey];
    [encoder encodeObject:_spot forKey:kSpotKey];
}

-(id)initWithCoder:(NSCoder *)decoder{
    NSString *title = [decoder decodeObjectForKey:kTitleKey];
    Temperature *temp = [decoder decodeObjectForKey:kTempKey];
    Humidity *humid = [decoder decodeObjectForKey:kHumidKey];
    Pitch *pitch = [decoder decodeObjectForKey:kPitchKey];
    Spot *spot = [decoder decodeObjectForKey:kSpotKey];
    return [self initConfig:title :temp :humid :pitch :spot];
}

-(id)initConfig:(NSString *)title :(Temperature *)temp :(Humidity *)humid :(Pitch *)pitch :(Spot *)spot{
    self = [super init];
    self.title = title;
    self.temp = temp;
    self.humid = humid;
    self.pitch = pitch;
    self.spot = spot;
    return self;
}

@end



