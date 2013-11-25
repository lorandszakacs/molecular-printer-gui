//
//  edu_iastateViewController.m
//  Molecular Printer
//
//  Created by Lorand Szakacs on 10/11/13.
//  Copyright (c) 2013 Lorand Szakacs. All rights reserved.
//

#import "edu_iastateViewController.h"

#import "MPGModel.h"
#import "PhysicalUnits.h"
#import "Constant.h"


@interface edu_iastateViewController ()
-(void) changeValueSlider:(UISlider*)slider :(UILabel*)label :(UIStepper*)stepper;
@end

@implementation edu_iastateViewController
@synthesize tempLabel;
@synthesize tempSlider;
@synthesize humidSlider;
@synthesize humidLabel;
@synthesize columnLabel;
@synthesize columnSlider;
@synthesize columnStepper;
@synthesize rowLabel;
@synthesize rowSlider;
@synthesize rowStepper;
@synthesize widthLabel;
@synthesize widthSlider;
@synthesize widthStepper;
@synthesize heightSlider;
@synthesize heightLabel;
@synthesize heightStepper;
@synthesize spotSlider;
@synthesize spotLabel;
@synthesize spotStepper;
@synthesize model;
@synthesize deviceConnectedLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //initialization
    model = [[MPGModel alloc] init];
    humidSlider.value = INITIALHUMIDITY;
    humidLabel.text = [[NSString alloc] initWithFormat:@"%1.1f", INITIALHUMIDITY];
    tempSlider.value = INITIALTEMP;
    humidLabel.text = [[NSString alloc] initWithFormat:@"%1.1f%%", INITIALTEMP];
    widthSlider.value = widthSlider.value = INITIALWIDTH;
    widthLabel.text = [[NSString alloc] initWithFormat:@"%1.1fµm", INITIALWIDTH];
    heightSlider.value = heightSlider.value = INITIALHEIGHT;
    heightLabel.text = [[NSString alloc] initWithFormat:@"%1.1fµm", INITIALHEIGHT];
    spotSlider.value = spotStepper.value = INITIALSPOTRADIUS;
    spotLabel.text = [[NSString alloc] initWithFormat:@"%1.1fµm", INITIALSPOTRADIUS];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tempSliderChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    [model setTemperature:[[Temperature alloc] initTemperature:slider.value :CELSIUS]];
    NSString *newText = [[NSString alloc] initWithFormat:@"%1.1f",
                         [[model getTemperature] getValue]];
    tempLabel.text = newText;
}
- (IBAction)humidSliderChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    [model setHumidity:[[Humidity alloc] initHumidity:slider.value]];
    NSString *newText = [[NSString alloc] initWithFormat:@"%1.1f%%",
                         [[model getHumidity] getValue]];
    humidLabel.text = newText;
}

- (IBAction)columnSliderChanged:(id)sender {
    [self changeValueSlider:columnSlider :columnLabel :columnStepper];
    [self updateWidth:columnSlider.value];
}

- (IBAction) columnStepperChanged:(id)sender {
    [self changeValueStepper:columnSlider :columnLabel :columnStepper];
    [self updateWidth:columnSlider.value];
}


- (IBAction)rowSliderChanged:(id)sender {
        [self changeValueSlider:rowSlider :rowLabel :rowStepper];
        [self updateHeight:rowSlider.value];
}

- (IBAction) rowStepperChanged:(id)sender {
    [self changeValueStepper:rowSlider :rowLabel :rowStepper];
    [self updateHeight:rowSlider.value];
}

- (IBAction)widthSliderChanged:(id)sender {
    [self changeValueSlider:widthSlider :widthLabel :widthStepper];
    [model setPitch:[[Pitch alloc] initPitch:widthSlider.value :[model.getPitch getHeight] :[model.getPitch getUnit]]];
    NSString *newText = [NSString stringWithFormat: @"%1.1fµm", [model.getPitch getWidth]];
    widthLabel.text = newText;
    [self updateSpotSize:widthSlider.value];
}

- (IBAction) widthStepperChanged:(id)sender {
    [self changeValueStepper:widthSlider :widthLabel :widthStepper];
    [model setPitch:[[Pitch alloc] initPitch:widthStepper.value :[model.getPitch getHeight] :[model.getPitch getUnit]]];
    NSString *newText = [NSString stringWithFormat: @"%1.1fµm",[model.getPitch getWidth]];
    widthLabel.text = newText;
    [self updateSpotSize:widthSlider.value];
}

- (IBAction)heightSyncButtonPressed:(id)sender {
    [model setPitch:[[Pitch alloc] initPitch:[model.getPitch getHeight] :[model.getPitch getHeight] :[model.getPitch getUnit]]];
    float width = [model.getPitch getWidth];
    widthSlider.value = width;
    widthStepper.value = width;
    NSString *newText = [[NSString alloc] initWithFormat:@"%1.1fµm",
                         width];
    widthLabel.text = newText;
}

- (IBAction)heightSliderChanged:(id)sender {
    [self changeValueSlider:heightSlider :heightLabel :heightStepper];
    [model setPitch:[[Pitch alloc] initPitch:[model.getPitch getWidth] :heightSlider.value :[model.getPitch getUnit]]];
    NSString *newText = [NSString stringWithFormat: @"%1.1fµm",[model.getPitch getHeight]];
    heightLabel.text = newText;
    [self updateSpotSize:heightSlider.value];
}

- (IBAction) heightStepperChanged:(id)sender {
    [self changeValueStepper:heightSlider :heightLabel :heightStepper];
    [model setPitch:[[Pitch alloc] initPitch:[model.getPitch getWidth] :heightStepper.value :[model.getPitch getUnit]]];
    NSString *newText = [NSString stringWithFormat: @"%1.1fµm",[model.getPitch getHeight]];
    heightLabel.text = newText;
    [self updateSpotSize:heightSlider.value];
}

//sync height with width
- (IBAction)widthSyncButtonPressed:(id)sender {
    [model setPitch:[[Pitch alloc] initPitch:[model.getPitch getWidth] :[model.getPitch getWidth] :[model.getPitch getUnit]]];
    float height = [model.getPitch getHeight];
    heightSlider.value = height;
    heightStepper.value = height;
    NSString *newText = [[NSString alloc] initWithFormat:@"%1.1fµm",
                         height];
    heightLabel.text = newText;
}

- (IBAction)spotSliderChanged:(id)sender {
    [self changeValueSlider:spotSlider :spotLabel :spotStepper];
    [model setSpot:[[Spot alloc] initSpot:spotSlider.value :[model.spot getUnit]]];
    NSString *newText = [NSString stringWithFormat: @"%1.1fµm",[model.getSpot getRadius]];
    spotLabel.text = newText;
    
}

- (IBAction) spotStepperChanged:(id)sender {
    [self changeValueStepper:spotSlider :spotLabel :spotStepper];
    [model setSpot:[[Spot alloc] initSpot:spotStepper.value :[model.spot getUnit]]];
    NSString *newText = [NSString stringWithFormat: @"%1.1fµm",[model.getSpot getRadius]];
    spotLabel.text = newText;
}

-(void) changeValueSlider:(UISlider*)slider :(UILabel*)label :(UIStepper*)stepper{
    NSString *newText = [[NSString alloc] initWithFormat:@"%d",
                         (int)slider.value];
    label.text = newText;
    stepper.value = slider.value;
}

-(void) changeValueStepper:(UISlider*)slider :(UILabel*)label :(UIStepper*)stepper{
    NSString *newText = [[NSString alloc] initWithFormat:@"%d",
                         (int)stepper.value];
    label.text = newText;
    slider.value = stepper.value;
}

-(void) updateWidth:(float)value{
//    if(MAXIMAGEWIDTH/value<[model.getPitch getWidth]){
//        [model setPitch:[[Pitch alloc] initPitch:[] :<#(double)#> :<#(LengthUnit)#>
//        widthSlider.value = IMAGEWIDTH/value;
//        widthStepper.value = MAXIMAGEWIDTH/value;
//        NSString *newText = [NSString stringWithFormat: @"%1.1fµm",widthSlider.value];
//        widthLabel.text =newText;
//    }
//    widthSlider.maximumValue = IMAGEWIDTH/value;
//    widthStepper.maximumValue = IMAGEWIDTH/value;
}

-(void) updateHeight:(float)value{
//    if(IMAGEHEIGHT/value<heightSlider.value){
//        heightSlider.value = IMAGEHEIGHT/value;
//        heightStepper.value = IMAGEHEIGHT/value;
//        NSString *newText = [NSString stringWithFormat: @"%1.1fµm",heightSlider.value];
//        heightLabel.text =newText;
//    }
//    heightSlider.maximumValue = IMAGEHEIGHT/value;
//    heightStepper.maximumValue = IMAGEHEIGHT/value;
}

-(void) updateSpotSize:(float)value{
    //TODO:adjust spot size accordingly to changes to pitches
}
- (IBAction)deviceButton:(id)sender {
    if(_deviceSelection == nil){
        _deviceSelection = [[DeviceSelectionViewController alloc] initWithStyle:UITableViewStylePlain];
        _deviceSelection.delegate = self;
    }
    
    if(_deviceSelectionPopover ==nil){
        _deviceSelectionPopover = [[UIPopoverController alloc] initWithContentViewController:_deviceSelection];
        [_deviceSelectionPopover presentPopoverFromRect:CGRectMake(565, 914, 54, 30) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    }else{
        [_deviceSelectionPopover dismissPopoverAnimated:YES];
        _deviceSelectionPopover = nil;
    }
    
}

-(void)selectedDevice:(MicroControllerInterface *)device{
    deviceConnectedLabel.text = [device getID];
    [model setDevice:device];
    
    if(_deviceSelectionPopover!=nil){
        [_deviceSelectionPopover dismissPopoverAnimated:YES];
        _deviceSelectionPopover = nil;
    }
}
@end
