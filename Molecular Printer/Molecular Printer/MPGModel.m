//
//  MPGModel.m
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
