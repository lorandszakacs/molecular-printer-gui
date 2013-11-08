//
//  edu_iastateViewController.m
//  Molecular Printer
//
//  Created by Lorand Szakacs on 10/11/13.
//  Copyright (c) 2013 Lorand Szakacs. All rights reserved.
//

#import "edu_iastateViewController.h"

@interface edu_iastateViewController ()

@end

@implementation edu_iastateViewController
@synthesize tempLabel;
@synthesize humidLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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

@end
