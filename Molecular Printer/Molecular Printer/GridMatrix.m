//
//  GridMatrix.m
//  Molecular Printer
//
//  Created by Eric Lin on 11/22/13.
//  Copyright (c) 2013 Lorand Szakacs. All rights reserved.
//

#import "GridMatrix.h"

@implementation GridMatrix
-(id)initGridMatrix:(NSInteger)width :(NSInteger)height{
    self = [super init];
    _width = width;
    _height = height;
    NSInteger matrix[width*height];
    for(NSInteger i=0;i<width*height;i++)
        matrix[i]=0;
    _matrix = matrix;
    return self;
}

-(BOOL)checkXY:(NSInteger)x :(NSInteger)y{
    if(x<0||y<0||x>=_width||y>=_height)
        return NO;
    return YES;
}

-(BOOL)isMarked:(NSInteger)x :(NSInteger)y{
    if([self checkXY:x :y] == NO)
    [NSException raise:@"Invalid value for GridMatrix::isMarked" format:@"Position (%d, %d) is invalid", x, y];
    return _matrix[y*_width+x]==1;
}

//return YES if value of cell is changed.
-(BOOL)mark:(NSInteger)x :(NSInteger)y{
    if([self checkXY:x :y] == NO)
        [NSException raise:@"Invalid value for GridMatrix::mark" format:@"Position (%d, %d) is invalid", x, y];
    if(_matrix[y*_width+x]==1)
        return NO;
    _matrix[y*_width+x] = 1;
    return YES;
}

-(BOOL)unmark:(NSInteger)x :(NSInteger)y{
    if([self checkXY:x :y] == NO)
        [NSException raise:@"Invalid value for GridMatrix::mark" format:@"Position (%d, %d) is invalid", x, y];
    if(_matrix[y*_width+x]==0)
        return NO;
    _matrix[y*_width+x] = 0;
    return YES;
}

-(BOOL)flip:(NSInteger)x :(NSInteger)y{
    if([self checkXY:x :y] == NO)
        [NSException raise:@"Invalid value for GridMatrix::mark" format:@"Position (%d, %d) is invalid", x, y];
    if(_matrix[y*_width+x]==0){
        _matrix[y*_width+x] = 1;
    }else
        _matrix[y*_width+x] = 0;
    return YES;
}

@end
