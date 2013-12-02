//
//  ImageLoaderViewController.m
//  Molecular Printer
//
//  Created by ITS Student Laptop on 12/1/13.
//  Copyright (c) 2013 Lorand Szakacs. All rights reserved.
//

#import "ImageLoaderViewController.h"

@interface ImageLoaderViewController ()

@end
@implementation ImageLoaderViewController

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
    _imageButton1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    _imageButton1.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    _imageButton2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    _imageButton2.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)imageButton1Pushed:(id)sender {
}
@end
