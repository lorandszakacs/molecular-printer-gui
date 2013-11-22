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
-(NSInteger)isMarked:(NSInteger)x :(NSInteger)y;

@end

/**
class GridMatrix{
public:
    int isMarked(int x, int y);
    int mark(int x, int y);
    int unMark(int x, int y);
    int flip(int x, int y);
    int getWidth();
    int getHeight();
    GridMatrix(int width, int height);
    
private:
    int* matrix;
    int width;
    int height;
    
};**/