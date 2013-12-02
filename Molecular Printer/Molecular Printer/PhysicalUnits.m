//
//  PhysicalUnit.m
//  Molecular Printer
//
//  Created by Eric Lin on 11/22/13.

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

#import "PhysicalUnits.h"


@implementation Temperature
-(id)initTemperature:(double)value :(TempUnit)unit{
    self = [super init];
    _value = value;
    _unit = unit;
    return self;
}

-(Temperature*)convert:(TempUnit)toUnit{
    //TODO: write actual conversion.
    Temperature *newTemp = [[Temperature alloc] initTemperature:_value :toUnit];
    return newTemp;
}
@end //end Temperature


@implementation Humidity
-(id)initHumidity:(double)value {
    self = [super init];
    //TODO: compare within a delta.
    if(value < 0 || value > 100){
        [NSException raise:@"Invalid value for humidity" format:@"Value of %f is invalid", value];
    }
    _value = value;
    return self;
}
@end //Humidity

@implementation Spot
-(id)initSpot:(double)value :(LengthUnit)unit {
    self = [super init];
    _value = value;
    _unit = unit;
    return self;
}

-(Spot*)convert:(LengthUnit)toUnit {
    //TODO: actually make conversion.
    Spot *newSpot = [[Spot alloc] initSpot:_value :_unit];
    return newSpot;
}
@end // Spot

@implementation Pitch
-(id)initPitch:(double)width :(double)height :(LengthUnit)unit {
    self = [super init];
    _width = width;
    _height = height;
    _unit = unit;
    return self;
}

-(Pitch*)convert:(LengthUnit)toUnit {
    //TODO: do actual conversions.
    Pitch *newPicth = [[Pitch alloc] initPitch:_width :_height :_unit ];
    return newPicth;
}
@end
