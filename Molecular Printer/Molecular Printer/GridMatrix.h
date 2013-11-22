//
//  GridMatrix.h
//  Molecular Printer
//
//  Created by Eric Lin on 11/22/13.
//  Copyright (c) 2013 Lorand Szakacs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GridMatrix : NSObject
@property ()NSInteger* matrix;
@property (getter = getWidth, readonly)NSInteger width;
@property (getter = getHeight, readonly)NSInteger height;
-(BOOL)isMarked:(NSInteger)x :(NSInteger)y;
-(BOOL)mark:(NSInteger)x :(NSInteger)y;
-(BOOL)unmark:(NSInteger)x :(NSInteger)y;
-(BOOL)flip:(NSInteger)x :(NSInteger)y;
-(BOOL)initGridMatrix:(NSInteger)width :(NSInteger)height;
@end
