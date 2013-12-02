//
//  MicroControllerInterface.m
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

#import "MicroControllerInterface.h"

@implementation MicroControllerInterface
@end
@implementation MockInterface : MicroControllerInterface
double surfaceWidth;
double surfaceHeight;
Pitch* pitch;
Temperature* temp;
Temperature* desiredTemp;
Humidity* humidity;
Humidity* desiredHumidity;
Spot* s;
NSTimer* tempTimer;
NSTimer* humidTimer;
int status;
-(id)init{
    self = [super init];
    pitch = [[Pitch alloc] initPitch:0 :0 :MICROMETER];
    temp = [[Temperature alloc] initTemperature:21.0 :CELSIUS];
    desiredTemp = [[Temperature alloc] initTemperature:21.0 :CELSIUS];
    humidity = [[Humidity alloc] initHumidity:60.0];
    desiredHumidity = [[Humidity alloc] initHumidity:60.0];
    s = [[Spot alloc] initSpot:15.0 :MICROMETER];
    status = STATUSIDLE;
    return self;
}

-(NSInteger)verifyIdentity:(NSInteger)id{
    return (NSInteger)[NSNumber numberWithInt:1];
}
-(NSString*)getID{
    return [[NSString alloc] initWithFormat:@"Device0"];
}
-(double)getSurfaceHeight{
    return surfaceHeight;
}
-(double)getSurfaceWidth{
    return surfaceWidth;
}
-(NSInteger)setPitch:(Pitch*)p{
    pitch = p;
    return (NSInteger)[NSNumber numberWithInt:1];
}
-(void)changeTemp{
    if([temp getValue]-[desiredTemp getValue]>0.1)
        temp = [[Temperature alloc] initTemperature:[temp getValue]-0.1 :CELSIUS];
    else if([temp getValue]-[desiredTemp getValue]<-0.1)
        temp = [[Temperature alloc] initTemperature:[temp getValue]+0.1 :CELSIUS];
    else{
        [tempTimer invalidate];
        tempTimer = nil;
    }
}
-(void)changeHumid{
    if([humidity getValue]-[desiredHumidity getValue]>0.1)
        humidity = [[Humidity alloc] initHumidity:[humidity getValue]-0.1];
    else if([humidity getValue]-[desiredHumidity getValue]<-0.1)
        humidity = [[Humidity alloc] initHumidity:[humidity getValue]+0.1];
    else{
        [humidTimer invalidate];
        humidTimer = nil;
    }
}
-(NSInteger)setDesiredTemperature:(Temperature*)temp{
    desiredTemp = temp;
    tempTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(changeTemp) userInfo:nil repeats:YES];
    return (NSInteger)[NSNumber numberWithInt:1];
}
-(NSInteger)setDesiredHumidity:(Humidity*)humid{
    desiredHumidity = humid;
    humidTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(changeHumid) userInfo:nil repeats:YES];
    return (NSInteger)[NSNumber numberWithInt:1];
}
-(NSInteger)setSpotSize:(Spot*)spot{
    s = spot;
    return (NSInteger)[NSNumber numberWithInt:1];
}
-(NSInteger)pollStatus{
    return status;//0 is idle for now
}
-(Temperature*)getTemperature{
    return temp;
}
-(Humidity*)getHumidity{
    return humidity;
}
-(NSInteger)print:(NSInteger)x :(NSInteger)y{    
//    status = STATUSPRINTING;
    NSLog(@"Printing at (%d, %d)\nPitch Width:%f\nPitch Height:%f\nSpot size:%f", x, y, pitch.getWidth, pitch.getHeight, s.getRadius);
    return 1;
}

-(NSInteger)getNumberOfPrintableColumns {
    //this should be computed as a function of spot-size, pitch and other things.
    return 10;
}

-(NSInteger)getNumberOfPrintableRows {
    //this should be computed as a function of spot-size, pitch and other things.
    return 10;
}
@end