//
//  edu_iastateViewController.h
//  Molecular Printer
//
//  Created by Lorand Szakacs on 10/11/13.
//  Copyright (c) 2013 Lorand Szakacs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface edu_iastateViewController : UIViewController{
    UITextField     *tempLabel;
    UITextField     *humidLabel;
}
//Desired Temperature slider
@property (retain, nonatomic) IBOutlet UITextField *tempLabel;
- (IBAction)tempSliderChanged:(id)sender;

//Desired humidity slider
@property (retain, nonatomic) IBOutlet UITextField *humidLabel;
- (IBAction)humidSliderChanged:(id)sender;

@end
