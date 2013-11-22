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


@end
