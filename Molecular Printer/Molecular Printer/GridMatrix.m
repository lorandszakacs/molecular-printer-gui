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
    NSMutableArray *matrix = [[NSMutableArray alloc] init];
//    NSInteger matrix[width*height];
    for(NSInteger i=0;i<width*height;i++){
        [matrix setObject:[NSNumber numberWithInt:0] atIndexedSubscript:i];
    }
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
//    NSLog(@"%dsaydasyd",_matrix[y*_width+x]);
    if([[_matrix objectAtIndex:(y*_width+x)]integerValue]==1)
        return YES;
    return NO;
}

//return YES if value of cell is changed.
-(BOOL)mark:(NSInteger)x :(NSInteger)y{
    if([self checkXY:x :y] == NO)
        [NSException raise:@"Invalid value for GridMatrix::mark" format:@"Position (%d, %d) is invalid", x, y];
    if([[_matrix objectAtIndex:(y*_width+x)]integerValue]==1)
        return NO;
    [_matrix setObject:[NSNumber numberWithInt:1] atIndexedSubscript:y*_width+x];
    return YES;
}

-(BOOL)unmark:(NSInteger)x :(NSInteger)y{
    if([self checkXY:x :y] == NO)
        [NSException raise:@"Invalid value for GridMatrix::mark" format:@"Position (%d, %d) is invalid", x, y];
    if([[_matrix objectAtIndex:(y*_width+x)]integerValue]==0)
        return NO;
    [_matrix setObject:[NSNumber numberWithInt:0] atIndexedSubscript:y*_width+x];
    return YES;
}

-(BOOL)flip:(NSInteger)x :(NSInteger)y{
    if([self checkXY:x :y] == NO)
        [NSException raise:@"Invalid value for GridMatrix::mark" format:@"Position (%d, %d) is invalid", x, y];
    if([[_matrix objectAtIndex:(y*_width+x)]integerValue] ==0){
        [_matrix setObject:[NSNumber numberWithInt:1] atIndexedSubscript:y*_width+x];
    }else
        [_matrix setObject:[NSNumber numberWithInt:0] atIndexedSubscript:y*_width+x];
    return YES;
}

-(GridMatrix *)newMatrix:(NSInteger)newHeight :(NSInteger)newWidth{
    //TODO:implement this
    return self;
}

@end
