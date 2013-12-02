//
//  ImageLoaderViewController2.h
//  Molecular Printer
//
//  Created by ITS Student Laptop on 12/1/13.
//  Copyright (c) 2013 Lorand Szakacs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageLoad2 <NSObject>

-(void)ImageLoaderButtonPushed2;

@end

@interface ImageLoaderViewController2 : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *imageButton1;
@property (weak, nonatomic) IBOutlet UIButton *imageButton2;
@property (weak, nonatomic) IBOutlet UIButton *imageButton3;
- (IBAction)imageButtonPushed:(id)sender;
@property (weak) id<ImageLoad2> delegate;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;



@end
