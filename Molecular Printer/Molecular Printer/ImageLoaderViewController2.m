//
//  ImageLoaderViewController2.m
//  Molecular Printer
//
//  Created by ITS Student Laptop on 12/1/13.
//  Copyright (c) 2013 Lorand Szakacs. All rights reserved.
//

#import "ImageLoaderViewController2.h"

@interface ImageLoaderViewController2 ()

@end
@implementation ImageLoaderViewController2

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
    _imageButton3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    _imageButton3.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    [_scrollView setFrame:CGRectMake(0, 0, 360, 400)];
    [_scrollView setContentSize:CGSizeMake(360, 900)];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)imageButtonPushed:(id)sender {
    if(_delegate !=nil)
        [_delegate ImageLoaderButtonPushed2];
}
@end
