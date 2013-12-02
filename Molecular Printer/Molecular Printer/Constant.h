//
//  Constant.h
//  Molecular Printer
//
//  Created by Eric Lin on 11/18/13.

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

#ifndef Molecular_Printer_Constant_h
#define Molecular_Printer_Constant_h
extern double const MAXIMAGEWIDTH;
extern double const MAXIMAGEHEIGHT;
extern double const INITIALTEMP;
extern const double INITIALHUMIDITY;
extern const int INITIALCOLUMNS;
extern const int INITIALROWS;
extern const double INITIALWIDTH;
extern const double INITIALHEIGHT;
extern const double INITIALSPOTRADIUS;

extern const int GRID_DISPLAY_HEIGHT;
extern const int GRID_DISPLAY_WIDTH;
extern int const GRID_DISPLAY_SPACE;

extern const int STATUSIDLE;
extern const int STATUSPRINTING;
extern const int STATUSPAUSED;
extern const int STATUSERROR;

#endif
