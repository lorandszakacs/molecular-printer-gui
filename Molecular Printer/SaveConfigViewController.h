//
//  SaveConfigViewController.h
//  Molecular Printer
//
//  Created by Eric Lin on 12/1/13.
//  Copyright (c) 2013 Lorand Szakacs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Configuration.h"


@protocol ConfigSaveSelected <NSObject>
-(void)configSaveSelected;
@end
@interface SaveConfigViewController : UIViewController<UITextFieldDelegate>{

}
@property (strong, nonatomic) IBOutlet UITextField *InputTextField;
@property (strong)NSString* saveFilePath;
@property (strong) Temperature *temp;
@property (strong) Humidity *humid;
@property (strong) Pitch *pitch;
@property (strong) Spot *spot;
- (IBAction)inputEnd:(id)sender;
- (IBAction)saveButtonPushed:(id)sender;
-(id) initWithData:(Temperature*)temp :(Humidity*)humid :(Pitch*)pitch :(Spot*)spot;
@property (weak) id<ConfigSaveSelected> delegate;

@end
