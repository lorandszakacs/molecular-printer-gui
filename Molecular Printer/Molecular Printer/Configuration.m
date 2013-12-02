//
//  Configuration.m
//  Molecular Printer
//
//  Created by Eric Lin on 12/1/13.

//  The MIT License (MIT)
//
//  Copyright (c) 2013 Eric Lin, Brian Nakayama, Loránd Szakács, Jinu Susan-Varghese,
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

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



