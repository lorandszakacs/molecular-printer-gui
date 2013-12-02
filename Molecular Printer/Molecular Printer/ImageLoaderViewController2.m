//
//  ImageLoaderViewController2.m
//  Molecular Printer
//
//  Created by Eric Lin on 12/1/13.

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
