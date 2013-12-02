//
//  SaveConfigViewController.h
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
