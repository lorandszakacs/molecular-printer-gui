//
//  ImageSaverViewController.m
//  Molecular Printer
//
//  Created by ITS Student Laptop on 12/1/13.
//  Copyright (c) 2013 Lorand Szakacs. All rights reserved.
//

#import "ImageSaverViewController.h"

@interface ImageSaverViewController ()

@end



@implementation ImageSaverViewController
@synthesize inputTextField;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (id)init{
    self = [super init];
    if(self != nil){
        inputTextField.delegate = self;
        inputTextField.returnKeyType = UIReturnKeyDone;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)inputEnd:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)saveButtonPushed:(id)sender {
    if(_delegate !=nil)
        [_delegate imageSaveSelected];
}

@end
