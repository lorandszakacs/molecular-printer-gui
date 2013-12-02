//
//  GridMatrix.h
//  Molecular Printer
//
//  Created by Eric Lin on 11/22/13.

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