//
//  MicroControllerInterface.h
//  Molecular Printer
//
//  Created by Eric Lin on 11/22/13.
//  Copyright (c) 2013 Lorand Szakacs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhysicalUnits.h"
#import "Constant.h"

#ifndef MicroControllerInterface_h
#define MicroControllerInterface_h
@interface MicroControllerInterface : NSObject
-(NSInteger)verifyIdentity:(NSInteger)id;
-(NSString*)getID;
-(double)getSurfaceHeight;
-(double)getSurfaceWidth;
-(NSInteger)getNumberOfPrintableRows;
-(NSInteger)getNumberOfPrintableColumns;
-(NSInteger)setPitch:(Pitch*)pitch;
-(NSInteger)setDesiredTemperature:(Temperature*)temp;
-(NSInteger)setDesiredHumidity:(Humidity*)humid;
-(NSInteger)setSpotSize:(Spot*)spot;
-(NSInteger)pollStatus;
-(Temperature*)getTemperature;
-(Humidity*)getHumidity;
-(NSInteger)print:(NSInteger)x :(NSInteger)y;
@end

@interface MockInterface : MicroControllerInterface
@end
#endif