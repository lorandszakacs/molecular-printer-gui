//
//  ImageLoaderViewController.h
//  Molecular Printer
//
//  Created by ITS Student Laptop on 12/1/13.
//  Copyright (c) 2013 Lorand Szakacs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageLoad <NSObject>

-(void)ImageLoaderButtonPushed;

@end

@interface ImageLoaderViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *imageButton1;
@property (weak, nonatomic) IBOutlet UIButton *imageButton2;
- (IBAction)imageButton1Pushed:(id)sender;
@property (weak) id<ImageLoad> delegate;



@end
