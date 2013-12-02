//
//  SaveConfigViewController.m
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

#import "SaveConfigViewController.h"

//Path to save configs
#define dataDirectory @"config"
#define dataFile @"config.plist"

@interface SaveConfigViewController ()
@end

@implementation SaveConfigViewController
@synthesize InputTextField;
@synthesize saveFilePath;

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)init{
    self = [super init];
    if(self != nil){
        InputTextField.delegate = self;
        InputTextField.returnKeyType = UIReturnKeyDone;
    }
    return self;
}

-(id) initWithData:(Temperature*)temp :(Humidity*)humid :(Pitch*)pitch :(Spot*)spot{
    self = [super init];
    if(self != nil){
        InputTextField.delegate = self;
        InputTextField.returnKeyType = UIReturnKeyDone;
        self.temp = temp;
        self.humid = humid;
        self.pitch = pitch;
        self.spot = spot;
    }
    return self;
}

- (IBAction)inputEnd:(id)sender {
    UITextField* textField = (UITextField*)sender;
    saveFilePath = [textField.text copy];
    [sender resignFirstResponder];
}

- (IBAction)saveButtonPushed:(id)sender {
    if(InputTextField.text.length!=0)
        [self saveData:saveFilePath];
    if(_delegate !=nil)
        [_delegate configSaveSelected];
}

//encode and create Configuration object
-(void)saveData:(NSString*)title{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"config"];
    
    
    NSError *error;
    [[NSFileManager defaultManager]createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:&error];

    NSString* dataPath = [documentsDirectory stringByAppendingPathComponent:title];
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver* archiver =[[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    Configuration *config = [[Configuration alloc] initConfig:title :_temp.value :_humid.value :_pitch.getWidth :_pitch.getHeight :_spot.getRadius];
    [archiver encodeObject:config forKey:title];
    [archiver finishEncoding];
    [data writeToFile:dataPath atomically:YES];
}
@end
