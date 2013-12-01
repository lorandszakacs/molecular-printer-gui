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
@synthesize deviceTempLabel;
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
@synthesize humidImageView;
NSTimer* tempTimer;
NSTimer* humidTimer;
@synthesize ConfigSaveButton;
@synthesize ConfigLoadButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //initialization
    model = [[MPGModel alloc] init];
    humidSlider.value = INITIALHUMIDITY;
    humidLabel.text = [[NSString alloc] initWithFormat:@"%1.1f%%", INITIALHUMIDITY];
    tempSlider.value = INITIALTEMP;
    tempLabel.text = [[NSString alloc] initWithFormat:@"%1.1f", INITIALTEMP];
    widthSlider.value = widthSlider.value = INITIALWIDTH;
    widthLabel.text = [[NSString alloc] initWithFormat:@"%1.1fµm", INITIALWIDTH];
    heightSlider.value = heightSlider.value = INITIALHEIGHT;
    heightLabel.text = [[NSString alloc] initWithFormat:@"%1.1fµm", INITIALHEIGHT];
    spotSlider.value = spotStepper.value = INITIALSPOTRADIUS;
    spotLabel.text = [[NSString alloc] initWithFormat:@"%1.1fµm", INITIALSPOTRADIUS];
    
    //update from device
    tempTimer = [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(updateTemp) userInfo:nil repeats:YES];
    humidTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateHumidity) userInfo:nil repeats:YES];
}
-(void)updateTemp{
    deviceTempLabel.text = [[NSString alloc] initWithFormat:@"%1.1f", [model.device.getTemperature getValue]];
}

-(void)updateHumidity{
    humidImageView.image = [UIImage imageNamed:[[NSString alloc] initWithFormat:@"humidity%d.png",(int)model.device.getHumidity.getValue]];
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
    [model.device setDesiredTemperature:model.getTemperature];
}
- (IBAction)humidSliderChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    [model setHumidity:[[Humidity alloc] initHumidity:slider.value]];
    NSString *newText = [[NSString alloc] initWithFormat:@"%1.1f%%",
                         [[model getHumidity] getValue]];
    humidLabel.text = newText;
    [model.device setDesiredHumidity:model.getHumidity];
}

- (IBAction)columnSliderChanged:(id)sender {
    [self changeValueSlider:columnSlider :columnLabel :columnStepper];
}

- (IBAction) columnStepperChanged:(id)sender {
    [self changeValueStepper:columnSlider :columnLabel :columnStepper];
}


- (IBAction)rowSliderChanged:(id)sender {
        [self changeValueSlider:rowSlider :rowLabel :rowStepper];
}

- (IBAction) rowStepperChanged:(id)sender {
    [self changeValueStepper:rowSlider :rowLabel :rowStepper];
}

- (IBAction)widthSliderChanged:(id)sender {
    [self changeValueSlider:widthSlider :widthLabel :widthStepper];
    [model setPitch:[[Pitch alloc] initPitch:widthSlider.value :[model.getPitch getHeight] :[model.getPitch getUnit]]];
    NSString *newText = [NSString stringWithFormat: @"%1.1fµm", [model.getPitch getWidth]];
    widthLabel.text = newText;
}

- (IBAction) widthStepperChanged:(id)sender {
    [self changeValueStepper:widthSlider :widthLabel :widthStepper];
    [model setPitch:[[Pitch alloc] initPitch:widthStepper.value :[model.getPitch getHeight] :[model.getPitch getUnit]]];
    NSString *newText = [NSString stringWithFormat: @"%1.1fµm",[model.getPitch getWidth]];
    widthLabel.text = newText;
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
}

- (IBAction) heightStepperChanged:(id)sender {
    [self changeValueStepper:heightSlider :heightLabel :heightStepper];
    [model setPitch:[[Pitch alloc] initPitch:[model.getPitch getWidth] :heightStepper.value :[model.getPitch getUnit]]];
    NSString *newText = [NSString stringWithFormat: @"%1.1fµm",[model.getPitch getHeight]];
    heightLabel.text = newText;
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

//Printing actions
- (IBAction)PrintButtonPushed:(id)sender {
//    for(int i=0;i<_model.getGridMatrix.getWidth)
////    PrintWaitViewController* pView = [[PrintWaitViewController alloc] init];
////    [self presentViewController:pView animated:YES completion:NO];
////    [pView print];
}

//Device selection
- (IBAction)deviceButton:(id)sender {
    if(_deviceSelection == nil){
        _deviceSelection = [[DeviceSelectionViewController alloc] initWithStyle:UITableViewStylePlain];
        _deviceSelection.delegate = self;
    }
    
    if(_deviceSelectionPopover ==nil){
        _deviceSelectionPopover = [[UIPopoverController alloc] initWithContentViewController:_deviceSelection];
        [_deviceSelectionPopover presentPopoverFromRect:_deviceSelectButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
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

//Config S/L
- (IBAction)configSaveButtonPushed:(id)sender {
    if(_saveConfigController == nil){
        _saveConfigController = [[SaveConfigViewController alloc] initWithData:[model getTemperature] :[model getHumidity] :[model getPitch] :[model getSpot]];
        _saveConfigController.contentSizeForViewInPopover = CGSizeMake(187, 196);//hard coded:calculated from position of views.
        _saveConfigController.delegate = self;
    }
    
    if(_saveConfigPopover ==nil){
        _saveConfigPopover = [[UIPopoverController alloc] initWithContentViewController:_saveConfigController];
        [_saveConfigPopover presentPopoverFromRect:ConfigSaveButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    }else{
        [_saveConfigPopover dismissPopoverAnimated:YES];
        _saveConfigPopover = nil;
    }
}
- (IBAction)configLoadButtonPushed:(id)sender {
    if(_loadConfigController == nil){
        _loadConfigController = [[LoadConfigViewController alloc] init];
//        _loadConfigController.contentSizeForViewInPopover = CGSizeMake(187, 196);//hard coded:calculated from position of views.
        _loadConfigController.delegate = self;
    }
    
    if(_loadConfigPopover ==nil){
        _loadConfigPopover = [[UIPopoverController alloc] initWithContentViewController:_loadConfigController];
        [_loadConfigPopover presentPopoverFromRect:ConfigLoadButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    }else{
        [_loadConfigPopover dismissPopoverAnimated:YES];
        _loadConfigPopover = nil;
        _loadConfigController = nil;
    }

}

//delegate methods
-(void)selectedConfigurations:(Configuration *)config{
    [self loadTemp:config];
    [self loadHumid:config];
    [self loadPitch:config];
    [self loadSpot:config];
    
    if(_loadConfigPopover!=nil){
        [_loadConfigPopover dismissPopoverAnimated:YES];
        _loadConfigPopover = nil;
        _loadConfigController = nil;
    }
}
-(void)configSaveSelected{
    if(_saveConfigPopover != nil){
        [_saveConfigPopover dismissPopoverAnimated:YES];
        _saveConfigPopover = nil;
        _saveConfigController =nil;
    }
}

-(void)loadTemp:(Configuration*) config{
    [model setTemperature:[[Temperature alloc]initTemperature:config.temp :CELSIUS]];
    tempSlider.value = config.temp;
    NSString *newText = [[NSString alloc] initWithFormat:@"%1.1f",
                         [[model getTemperature] getValue]];
    tempLabel.text = newText;
}
-(void)loadHumid:(Configuration*) config{
    [model setHumidity:[[Humidity alloc]initHumidity:config.humid]];
    humidSlider.value = config.humid;
    NSString *newText = [[NSString alloc] initWithFormat:@"%1.1f%%",
                         [[model getHumidity] getValue]];
    humidLabel.text = newText;
}
-(void)loadPitch:(Configuration*) config{
    [model setPitch:[[Pitch alloc]initPitch :config.width :config.height :MICROMETER]];
    widthSlider.value = widthStepper.value = config.width;
    NSString *newText = [NSString stringWithFormat: @"%1.1fµm", [model.getPitch getWidth]];
    widthLabel.text = newText;
    heightSlider.value = heightStepper.value = config.height;
    newText = [NSString stringWithFormat: @"%1.1fµm", [model.getPitch getHeight]];
    heightLabel.text = newText;
}
-(void)loadSpot:(Configuration*) config{
    [model setSpot:[[Spot alloc]initSpot:config.spot :MICROMETER]];
    spotSlider.value = spotStepper.value = config.spot;
    NSString *newText = [NSString stringWithFormat: @"%1.1fµm", [model.getSpot getRadius]];
    spotLabel.text = newText;
}

@end
