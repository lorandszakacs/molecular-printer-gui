//
//  GridMatrix.m
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

#import "GridMatrix.h"

@implementation GridMatrix
-(id)initGridMatrix:(NSInteger)rows :(NSInteger)columns{
    self = [super init];
    _rows = rows;
    _columns = columns;
    NSMutableArray *matrix = [[NSMutableArray alloc] init];
//    NSInteger matrix[width*height];
    for(NSInteger i = 0; i < rows * columns; i++){
        [matrix setObject:[NSNumber numberWithInt:0] atIndexedSubscript:i];
    }
    _matrix = matrix;
    return self;
}

-(BOOL)checkXY:(NSInteger)row :(NSInteger)column{
    if(row < 0 || column <0 || row >= _rows || column >=_columns)
        return NO;
    return YES;
}

-(BOOL)isMarked:(NSInteger)row :(NSInteger)column{
    if([self checkXY:row :column] == NO)
        [NSException raise:@"Invalid value for GridMatrix::isMarked" format:@"Position (%d, %d) is invalid", row, column];
    NSInteger lIndex = [self linearIndex: row:column];
    if([[_matrix objectAtIndex: lIndex]integerValue] == 1)
        return YES;
    return NO;
}

//return YES if value of cell is changed.
-(BOOL)mark:(NSInteger)row :(NSInteger)column{
    NSInteger lIndex = [self linearIndex: row:column];
    if([self checkXY:row :column] == NO)
        [NSException raise:@"Invalid value for GridMatrix::mark" format:@"Position (%d, %d) is invalid", row, column];
    if([[_matrix objectAtIndex:(lIndex)]integerValue] == 1)
        return NO;
    [_matrix setObject:[NSNumber numberWithInt:1] atIndexedSubscript:lIndex];
    return YES;
}

-(BOOL)unmark:(NSInteger)row :(NSInteger)column{
    NSInteger lIndex = [self linearIndex: row:column];
    if([self checkXY:row :column] == NO)
        [NSException raise:@"Invalid value for GridMatrix::mark" format:@"Position (%d, %d) is invalid", row, column];
    if([[_matrix objectAtIndex:(lIndex)]integerValue]==0)
        return NO;
    [_matrix setObject:[NSNumber numberWithInt:0] atIndexedSubscript:lIndex];
    return YES;
}

-(BOOL)flip:(NSInteger)row :(NSInteger)column{
    NSInteger lIndex = [self linearIndex: row:column];
    if([self checkXY:row :column] == NO)
        [NSException raise:@"Invalid value for GridMatrix::mark" format:@"Position (%d, %d) is invalid", row, column];
    if([[_matrix objectAtIndex:(lIndex)]integerValue] ==0){
        [_matrix setObject:[NSNumber numberWithInt:1] atIndexedSubscript:lIndex];
    }else
        [_matrix setObject:[NSNumber numberWithInt:0] atIndexedSubscript:lIndex];
    return YES;
}

-(BOOL)isMarked:(NSInteger)x {
    int row = [self row:x];
    int column = [self column:x];
    return [self isMarked: row: column];
}

-(BOOL)mark:(NSInteger)x {
    int row = [self row:x];
    int column = [self column:x];
    return [self mark: row: column];
}

-(BOOL)unmark:(NSInteger)x {
    int row = [self row:x];
    int column = [self column:x];
    return [self unmark: row: column];
}

-(BOOL)flip:(NSInteger)x {
    int row = [self row:x];
    int column = [self column:x];
    return [self flip: row: column];
}

-(GridMatrix *)newMatrix:(NSInteger)newHeight :(NSInteger)newWidth {
    GridMatrix *temp = [[GridMatrix alloc]initGridMatrix:newHeight :newWidth];
    NSInteger heightLimit;
    NSInteger widthLimit;
    
    if(newHeight < _rows ) heightLimit = newHeight; else heightLimit = _rows;
    if(newWidth < _columns) widthLimit = newWidth; else widthLimit = _columns;
    
    for (NSInteger row=0; row < heightLimit ;row++) {
        for (NSInteger col=0; col < widthLimit ;col++) {
            BOOL oldVal = [self isMarked:row :col];
            if (oldVal == YES) {
                [temp mark:row:col];
        }
        }
    }
    return temp;
}

-(NSInteger) linearIndex: (NSInteger)row :(NSInteger)column{
    return row * _columns + column;
}

-(NSInteger) column: (NSInteger)linIndex {
    return linIndex % _columns;
}

-(NSInteger) row: (NSInteger)linIndex {
    return floor(linIndex / _columns);
}


@end
