//
//  PhysicalUnit.h
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
#import <Foundation/Foundation.h>
#ifndef Data_PhysicalUnits_h
#define Data_PhysicalUnits_h
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
#endif

