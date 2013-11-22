//
//  PhysicalUnit.h
//  Molecular Printer
//
//  Created by Eric Lin on 11/22/13.
//  Copyright (c) 2013 Lorand Szakacs. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum TempUnit:NSInteger TempUnit;
enum TempUnit:NSInteger {
    CELSIUS,
    FAHRENHEIT,
    KELVIN
};

typedef enum LengthUnit:NSInteger LengthUnit;
enum LengthUnit:NSInteger {
    MICROMETER
};

@interface Temperature : NSObject
@property (getter = getValue, readonly)double value;
@property (getter = getUnit, readonly)TempUnit unit;
-(Temperature*)convert:(TempUnit)toUnit;
-(id)initTemperature:(double)value :(TempUnit)unit;
@end

@interface Humidity : NSObject
@property (getter = getValue, readonly)double value;
-(id)initHumidity:(double)value;
@end

@interface Spot : NSObject
@property (getter = getRadius, readonly)double value;
@property (getter = getUnit, readonly)LengthUnit unit;
-(Spot*)convert:(LengthUnit)toUnit;
-(id)initSpot:(double)value :(LengthUnit)unit;
@end

@interface Pitch : NSObject
@property (getter = getHeight, readonly)double height;
@property (getter = getWidth, readonly)double width;
@property (getter = getUnit, readonly)LengthUnit unit;
-(Pitch*)convert:(LengthUnit)toUnit;
-(id)initPitch:(double)width :(double)height :(LengthUnit)unit;
@end