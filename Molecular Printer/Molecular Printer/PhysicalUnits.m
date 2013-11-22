//
//  PhysicalUnit.m
//  Molecular Printer
//
//  Created by Eric Lin on 11/22/13.
//  Copyright (c) 2013 Lorand Szakacs. All rights reserved.
//

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
