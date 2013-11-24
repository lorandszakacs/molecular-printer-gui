//
//  MPGModel.h
//  Molecular Printer
//
//  Created by Eric Lin on 11/22/13.
//  Copyright (c) 2013 Lorand Szakacs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhysicalUnits.h"
#import "GridMatrix.h"
#import "MicroControllerInterface.h"

#ifndef MPGModel_h
#define MPGModel_h

@interface MPGModel : NSObject
@property (retain, getter = getGridMatrix, setter = setGridMatrix:)GridMatrix* gridMatrix;
@property (retain, getter = getTemperature)Temperature* temperature;
@property (retain, getter = getHumidity)Humidity* humidity;
@property (retain, getter = getSpot)Spot* spot;
@property (retain, getter = getPitch)Pitch* pitch;
@property (getter = getState)NSInteger state;
@property ()MicroControllerInterface* device;
@end

#endif