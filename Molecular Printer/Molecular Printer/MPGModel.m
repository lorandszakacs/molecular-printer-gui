//
//  MPGModel.m
//  Molecular Printer
//
//  Created by Eric Lin on 11/22/13.
//  Copyright (c) 2013 Lorand Szakacs. All rights reserved.
//

#import "MPGModel.h"
#import "Constant.h"
#import "MicroControllerInterface.h"

@implementation MPGModel
-(id)init{
    self = [super init];
    [self setHumidity:[[Humidity alloc] initHumidity:INITIALHUMIDITY]];
    [self setTemperature:[[Temperature alloc] initTemperature:INITIALTEMP :CELSIUS]];
    [self setSpot:[[Spot alloc] initSpot:INITIALSPOTRADIUS :MICROMETER]];
    [self setPitch:[[Pitch alloc] initPitch:INITIALWIDTH :INITIALHEIGHT :MICROMETER]];
    [self setGridMatrix:[[GridMatrix alloc]initGridMatrix:INITIALROWS :INITIALCOLUMNS]];
    [self setState:0];
    return self;
}

-(void)updateMatrix:(NSInteger)newRows :(NSInteger)newColumns{

}
@end
