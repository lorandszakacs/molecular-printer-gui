//
//  MicroControllerInterface.m
//  Molecular Printer
//
//  Created by Eric Lin on 11/22/13.
//  Copyright (c) 2013 Lorand Szakacs. All rights reserved.
//

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
-(id)init{
    self = [super init];
    pitch = [[Pitch alloc] initPitch:0 :0 :MICROMETER];
    temp = [[Temperature alloc] initTemperature:21.0 :CELSIUS];
    desiredTemp = [[Temperature alloc] initTemperature:21.0 :CELSIUS];
    humidity = [[Humidity alloc] initHumidity:60.0];
    desiredHumidity = [[Humidity alloc] initHumidity:60.0];
    s = [[Spot alloc] initSpot:15.0 :MICROMETER];
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
    return 0;//0 is idle for now
}
-(Temperature*)getTemperature{
    return temp;
}
-(Humidity*)getHumidity{
    return humidity;
}
-(NSInteger)print:(NSInteger)x :(NSInteger)y{
    //change status, let this consume time
    return 0;
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