//
//  PrintWaitViewController.m
//  Molecular Printer
//
//  Created by Eric Lin on 12/1/13.
//  Copyright (c) 2013 Lorand Szakacs. All rights reserved.
//

#import "PrintWaitViewController.h"

@interface PrintWaitViewController ()

@end

@implementation PrintWaitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)print{
    NSInteger* grid = [NSInteger al]
    NSInteger* grid[_matrix.getWidth*_matrix.getHeight];
    for(int i=0;i<_matrix.getWidth*_matrix.getHeight;i++){
        grid[i] = &_matrix.matrix[i];
    }
}

-(id)initPrint:(GridMatrix*) matrix{
    self = [super init];
    _matrix = matrix;
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

@end
