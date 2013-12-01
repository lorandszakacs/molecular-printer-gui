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

@property (strong) NSString *title;//title of configuration save
@property (strong) Temperature *temp;
@property (strong) Humidity *humid;
@property (strong) Pitch *pitch;
@property (strong) Spot *spot;

-(id)initConfig:(NSString*)title :(Temperature*) temp :(Humidity*) humid :(Pitch*)pitch :(Spot*)spot;
@end

#endif
