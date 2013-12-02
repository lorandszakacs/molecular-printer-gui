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
@end