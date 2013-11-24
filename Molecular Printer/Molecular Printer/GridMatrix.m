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
@end
