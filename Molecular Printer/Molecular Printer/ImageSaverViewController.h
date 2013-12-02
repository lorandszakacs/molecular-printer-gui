//
//  ImageSaverViewController.h
//  Molecular Printer
//
//  Created by ITS Student Laptop on 12/1/13.
//  Copyright (c) 2013 Lorand Szakacs. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ImageSaveSelected <NSObject>
-(void)imageSaveSelected;
@end
@interface ImageSaverViewController :UIViewController<UITextFieldDelegate>{
    
}
@property (strong, nonatomic) IBOutlet UITextField *inputTextField;
- (IBAction)inputEnd:(id)sender;
- (IBAction)saveButtonPushed:(id)sender;
@property (weak) id<ImageSaveSelected> delegate;

@end