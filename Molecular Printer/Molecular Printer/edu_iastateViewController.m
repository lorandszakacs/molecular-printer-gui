//
//  edu_iastateViewController.m
//  Molecular Printer
//
//  Created by Lorand Szakacs on 10/11/13.
//  Copyright (c) 2013 Lorand Szakacs. All rights reserved.
//

#import "edu_iastateViewController.h"

@interface edu_iastateViewController ()
-(void) changeValueSlider:(UISlider*)slider :(UILabel*)label :(UIStepper*)stepper;
@end

@implementation edu_iastateViewController
@synthesize tempLabel;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    int IMAGEWIDTH = 400;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tempSliderChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    NSString *newText = [[NSString alloc] initWithFormat:@"%1.1f",
                         slider.value];
    tempLabel.text = newText;
}
- (IBAction)humidSliderChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    NSString *newText = [[NSString alloc] initWithFormat:@"%1.1f%%",
                         slider.value];
    humidLabel.text = newText;
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
    NSString *newText = [NSString stringWithFormat: @"%1.1fµm",widthSlider.value];
    widthLabel.text = newText;
    [self updateSpotSize:widthSlider.value];
}

- (IBAction) widthStepperChanged:(id)sender {
    [self changeValueStepper:widthSlider :widthLabel :widthStepper];
    NSString *newText = [NSString stringWithFormat: @"%1.1fµm",widthSlider.value];
    widthLabel.text = newText;
    [self updateSpotSize:widthSlider.value];
}

- (IBAction)heightSyncButtonPressed:(id)sender {
    widthSlider.value = heightSlider.value;
    widthStepper.value = heightSlider.value;
    NSString *newText = [[NSString alloc] initWithFormat:@"%1.1fµm",
                         heightSlider.value];
    widthLabel.text = newText;
}

- (IBAction)heightSliderChanged:(id)sender {
    [self changeValueSlider:heightSlider :heightLabel :heightStepper];
    NSString *newText = [NSString stringWithFormat: @"%1.1fµm",heightSlider.value];
    heightLabel.text = newText;
    [self updateSpotSize:heightSlider.value];
}

- (IBAction) heightStepperChanged:(id)sender {
    [self changeValueStepper:heightSlider :heightLabel :heightStepper];
    NSString *newText = [NSString stringWithFormat: @"%1.1fµm",heightSlider.value];
    heightLabel.text = newText;
    [self updateSpotSize:heightSlider.value];
}

- (IBAction)widthSyncButtonPressed:(id)sender {
    heightSlider.value = widthSlider.value;
    heightStepper.value = widthSlider.value;
    NSString *newText = [[NSString alloc] initWithFormat:@"%1.1fµm",
                         widthSlider.value];
    heightLabel.text = newText;
}

- (IBAction)spotSliderChanged:(id)sender {
    [self changeValueSlider:spotSlider :spotLabel :spotStepper];
    NSString *newText = [NSString stringWithFormat: @"%1.1fµm",spotSlider.value];
    spotLabel.text = newText;
    [self updatePitchSize:spotSlider.value];
}

- (IBAction) spotStepperChanged:(id)sender {
    [self changeValueStepper:spotSlider :spotLabel :spotStepper];
    NSString *newText = [NSString stringWithFormat: @"%1.1fµm",spotSlider.value];
    spotLabel.text = newText;
    [self updatePitchSize:spotSlider.value];
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

-(void) updateSpotSize:(float)value{
    if(spotSlider.value>value*2){
        spotSlider.value = value*2;
        spotStepper.value = value*2;
        NSString *newText = [NSString stringWithFormat: @"%1.1fµm",spotSlider.value];
        spotLabel.text =newText;
    }
    spotSlider.maximumValue = value*2;
    spotStepper.maximumValue = value*2;
}

-(void) updatePitchSize:(float)value{
//    if(widthSlider.value*2>value){
//        widthSlider.value = value/2;
//        widthStepper.value = value/2;
//        NSString *newText = [NSString stringWithFormat: @"%1.1fµm",widthSlider.value];
//        widthLabel.text =newText;
//    }
//    if(heightSlider.value*2>value){
//        heightSlider.value = value/2;
//        heightStepper.value = value/2;
//        NSString *newText = [NSString stringWithFormat: @"%1.1fµm",heightSlider.value];
//        heightLabel.text =newText;
//    }
}
@end
