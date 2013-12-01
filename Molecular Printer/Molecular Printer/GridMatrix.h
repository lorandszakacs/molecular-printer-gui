//
//  GridMatrix.h
//  Molecular Printer
//
//  Created by Eric Lin on 11/22/13.
//  Copyright (c) 2013 Lorand Szakacs. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef Data_GridMatrix_h
#define Data_GridMatrix_h
@interface GridMatrix : NSObject
@property ()NSInteger* matrix;
@property (getter = getWidth, readonly)NSInteger width;
@property (getter = getHeight, readonly)NSInteger height;
-(BOOL)isMarked:(NSInteger)x :(NSInteger)y;
-(BOOL)mark:(NSInteger)x :(NSInteger)y;
-(BOOL)unmark:(NSInteger)x :(NSInteger)y;
-(BOOL)flip:(NSInteger)x :(NSInteger)y;
-(id)initGridMatrix:(NSInteger)width :(NSInteger)height;

-(GridMatrix*)newMatrix: (NSInteger)newHeight :(NSInteger)newWidth;
@end
#endif