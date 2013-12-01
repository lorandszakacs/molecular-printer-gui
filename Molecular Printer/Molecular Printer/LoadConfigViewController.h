//
//  LoadConfigViewController.h
//  Molecular Printer
//
//  Created by Eric Lin on 12/1/13.
//  Copyright (c) 2013 Lorand Szakacs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Configuration.h"

@protocol ConfigSelected <NSObject>
-(void)selectedConfigurations:(Configuration*) config;
@end


@interface LoadConfigViewController : UITableViewController<UITableViewDelegate>
@property (strong) NSMutableArray* configs;
@property (weak) id<ConfigSelected> delegate;
@end
