//
//  SaveConfigViewController.m
//  Molecular Printer
//
//  Created by Eric Lin on 12/1/13.
//  Copyright (c) 2013 Lorand Szakacs. All rights reserved.
//

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
    [self saveData:saveFilePath];
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
