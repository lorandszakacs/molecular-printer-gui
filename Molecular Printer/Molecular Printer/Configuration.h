//
//  Configuration.h
//  Molecular Printer
//
//  Created by Eric Lin on 12/1/13.
//  Copyright (c) 2013 Lorand Szakacs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhysicalUnits.h"

#ifndef Configuration_h
#define Configuration_h
@interface Configuration : NSObject<NSCoding>

@property (strong, getter = getTitle) NSString *title;//title of configuration save
@property (assign) float temp;
@property (assign) float humid;
@property (assign) float width;
@property (assign) float height;
@property (assign) float spot;

-(id)initConfig:(NSString*)title :(float) temp :(float) humid :(float)width :(float)height :(float)spot;
@end

#endif
