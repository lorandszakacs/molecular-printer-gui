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
@property (retain)NSMutableArray* matrix;
@property (getter = getColumns, readonly)NSInteger columns;
@property (getter = getRows, readonly)NSInteger rows;
-(BOOL)isMarked:(NSInteger)row :(NSInteger)column;
-(BOOL)mark:(NSInteger)row :(NSInteger)column;
-(BOOL)unmark:(NSInteger)row :(NSInteger)column;
-(BOOL)flip:(NSInteger)row :(NSInteger)column;
-(id)initGridMatrix:(NSInteger)rows :(NSInteger)columns;

//methods that use linear index
-(BOOL)isMarked:(NSInteger)x;
-(BOOL)mark:(NSInteger)x;
-(BOOL)unmark:(NSInteger)x;
-(BOOL)flip:(NSInteger)x;

-(GridMatrix*)newMatrix: (NSInteger)newHeight :(NSInteger)newWidth;
@end
#endif