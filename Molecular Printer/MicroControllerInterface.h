//
//  MicroControllerInterface.h
//  Molecular Printer
//
//  Created by Eric Lin on 11/22/13.
//  Copyright (c) 2013 Lorand Szakacs. All rights reserved.
//

#ifndef __Molecular_Printer__MicroControllerInterface__
#define __Molecular_Printer__MicroControllerInterface__
#include "PhysicalUnits.h"

class MicroControllerInterface{
public:
    virtual int verifyIdentity(int id) = 0;
    virtual double getSurfaceHeight() = 0;
    virtual double getSurfaceWidth() = 0;
    virtual int setPitch(Pitch width) = 0;
    virtual int setDesiredTemperature(Temperature temp) = 0;
    virtual int setDesiredHumidity(Humidity humid) = 0;
    virtual int setSpotSize(Spot spot) = 0;
    virtual int pollStatus() = 0;
    virtual Temperature getTemperature() = 0;
    virtual Humidity getHumidity() = 0;
    virtual ~MicroControllerInterface() = 0;
};
#endif /* defined(__Molecular_Printer__MicroControllerInterface__) */
