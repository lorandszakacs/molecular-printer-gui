//
//  PrintWaitViewController.h
//  Molecular Printer
//
//  Created by Eric Lin on 12/1/13.
//  Copyright (c) 2013 Lorand Szakacs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridMatrix.h"

@protocol PrintWait <NSObject>
-(void)sendMatrix:(NSMutableArray*)matrix;
@end
@interface PrintWaitViewController : UIViewController
-(id) initPrint:(GridMatrix*) matrix;
-(void) print;
@property (retain)GridMatrix* matrix;

@end

