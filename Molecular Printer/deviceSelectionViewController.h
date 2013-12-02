//
//  deviceSelectionViewController.h
//  Molecular Printer
//
//  Created by Eric Lin on 11/24/13.
//  Copyright (c) 2013 Lorand Szakacs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MicroControllerInterface.h"

@protocol DeviceSelected <NSObject>
-(void)selectedDevice:(MicroControllerInterface*) device;
@end

@interface DeviceSelectionViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource>
@property (strong) NSMutableArray* devices;
@property (weak) id<DeviceSelected> delegate;
@end
