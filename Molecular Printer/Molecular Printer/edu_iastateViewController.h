//
//  edu_iastateViewController.h
//  Molecular Printer
//
//  Created by Lorand Szakacs on 10/11/13.

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

#import <UIKit/UIKit.h>
#import "MPGModel.h"
#import "deviceSelectionViewController.h"
#import "SaveConfigViewController.h"
#import "LoadConfigViewController.h"
#import "PrintWaitViewController.h"
#import "ImageLoaderViewController.h"
#import "ImageLoaderViewController2.h"
#import "ImageSaverViewController.h"

@interface edu_iastateViewController : UIViewController<UITextFieldDelegate, DeviceSelected,ConfigSelected, ConfigSaveSelected, ImageLoad, ImageSaveSelected, ImageLoad2, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>{
    UILabel         *tempLabel;
    UILabel         *deviceTempLabel;
    UILabel         *humidLabel;
    UIImageView     *humidImageView;
    UILabel         *columnLabel;
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
    UILabel         *deviceConnectedLabel;
}
@property(retain)MPGModel* model;

//Desired temperature slider
@property (retain, nonatomic) IBOutlet UISlider *tempSlider;
@property (retain, nonatomic) IBOutlet UILabel *tempLabel;
@property (strong, nonatomic) IBOutlet UILabel *deviceTempLabel;
- (IBAction)tempSliderChanged:(id)sender;

//Desired humidity slider
@property (weak, nonatomic) IBOutlet UISlider *humidSlider;
@property (retain, nonatomic) IBOutlet UILabel *humidLabel;
@property (strong, nonatomic) IBOutlet UIImageView *humidImageView;
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

//device selection button
@property (retain, nonatomic) IBOutlet UILabel *deviceConnectedLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ConnectedDeviceImage;
@property (strong) DeviceSelectionViewController* deviceSelection;
@property (strong, nonatomic) IBOutlet UIButton *deviceSelectButton;
@property (strong) UIPopoverController* deviceSelectionPopover;
- (IBAction)deviceButton:(id)sender;

//printing actions
- (IBAction)PrintButtonPushed:(id)sender;


//Image save/load
@property (strong)ImageLoaderViewController* imageLoaderViewController;
@property (strong)ImageLoaderViewController2* imageLoaderViewController2;
@property (strong) UIPopoverController* imageLoaderPopover;
@property (strong)ImageSaverViewController* imageSaverViewController;
@property (strong) UIPopoverController* imageSaverPopover;
- (IBAction)LoadImageButtonPushed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *loadImageButton;
- (IBAction)SaveImageButtonPushed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *saveImageButton;
@property BOOL saved;

//Config save/load
- (IBAction)configSaveButtonPushed:(id)sender;
- (IBAction)configLoadButtonPushed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *ConfigSaveButton;
@property (strong, nonatomic) IBOutlet UIButton *ConfigLoadButton;
@property (strong) SaveConfigViewController* saveConfigController;
@property (strong) UIPopoverController* saveConfigPopover;


@property (strong) LoadConfigViewController* loadConfigController;
@property (strong) UIPopoverController* loadConfigPopover;
@end
