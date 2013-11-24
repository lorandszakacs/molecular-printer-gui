//
//  edu_iastateViewController.h
//  Molecular Printer
//
//  Created by Lorand Szakacs on 10/11/13.
//  Copyright (c) 2013 Lorand Szakacs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPGModel.h"

@interface edu_iastateViewController : UIViewController<UITextFieldDelegate>{
    UILabel     *tempLabel;
    UILabel     *humidLabel;
    UILabel     *columnLabel;
    UISlider        *columnSlider;
    UIStepper       *columnStepper;
    UILabel         *rowLabel;
    UISlider        *rowSlider;
    UIStepper       *rowStepper;
    UILabel         *widthLabel;
    UISlider        *widthSlider;
    UIStepper       *widthStepper;
    UISlider        *heightSlider;
    UILabel         *heightLabel;
    UIStepper       *heightStepper;
    UISlider        *spotSlider;
    UILabel         *spotLabel;
    UIStepper       *spotStepper;
    MPGModel        *model;
}
@property(retain)MPGModel* model;

//Desired temperature slider
@property (retain, nonatomic) IBOutlet UISlider *tempSlider;
@property (retain, nonatomic) IBOutlet UILabel *tempLabel;
- (IBAction)tempSliderChanged:(id)sender;

//Desired humidity slider
@property (weak, nonatomic) IBOutlet UISlider *humidSlider;
@property (retain, nonatomic) IBOutlet UILabel *humidLabel;
- (IBAction)humidSliderChanged:(id)sender;

//Columns setter
- (IBAction)columnSliderChanged:(id)sender;
- (IBAction)columnStepperChanged:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *columnLabel;
@property (retain, nonatomic) IBOutlet UISlider *columnSlider;
@property (retain, nonatomic) IBOutlet UIStepper *columnStepper;

//Rows setter
- (IBAction)rowSliderChanged:(id)sender;
- (IBAction)rowStepperChanged:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *rowLabel;
@property (retain, nonatomic) IBOutlet UISlider *rowSlider;
@property (retain, nonatomic) IBOutlet UIStepper *rowStepper;

//Pitch width setter
- (IBAction)widthSliderChanged:(id)sender;
- (IBAction)widthStepperChanged:(id)sender;
- (IBAction)heightSyncButtonPressed:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *widthLabel;
@property (retain, nonatomic) IBOutlet UISlider *widthSlider;
@property (retain, nonatomic) IBOutlet UIStepper *widthStepper;

//Pitch Height setter
@property (retain, nonatomic) IBOutlet UISlider *heightSlider;
- (IBAction)heightSliderChanged:(id)sender;
- (IBAction)heightStepperChanged:(id)sender;
- (IBAction)widthSyncButtonPressed:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *heightLabel;
@property (retain, nonatomic) IBOutlet UIStepper *heightStepper;

//Spot size setter
- (IBAction)spotSliderChanged:(id)sender;
- (IBAction)spotStepperChanged:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *spotLabel;
@property (retain, nonatomic) IBOutlet UISlider *spotSlider;
@property (retain, nonatomic) IBOutlet UIStepper *spotStepper;
@end
