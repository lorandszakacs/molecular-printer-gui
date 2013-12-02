//
//  MicroControllerInterface.h
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