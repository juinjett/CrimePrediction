import shapefile
import numpy as np
from grid import *
import Tkinter

cellUnit = 600
def getGrid():
    myshp = open("Data/portland-police-districts/Portland_Police_Districts.shp","rb")
    mydbf = open("Data/portland-police-districts/Portland_Police_Districts.dbf","rb")
    r = shapefile.Reader(shp=myshp, dbf=mydbf)

    shape = r.shapes()
    bbox = r.bbox
    print bbox      #upper and lower bound of the X and Y coordinate
    xMin = bbox[0]
    xMax = bbox[2]
    yMin = bbox[1]
    yMax = bbox[3]

    gridList = []
    gridId = [0, 0]
    xCurrent = xMin
    yCurrent = yMin

    while (xCurrent < xMax + cellUnit):
        gridId[1] = 0
        while (yCurrent < yMax + cellUnit):
            tmp_grid = [0,0]
            tmp_grid[0] = gridId[0]
            tmp_grid[1] = gridId[1]
            gridList.append([xCurrent, yCurrent, tmp_grid])
            yCurrent += cellUnit
            gridId[1] += 1
            # print gridId
        xCurrent += cellUnit
        yCurrent = yMin
        gridId[0] += 1
    print len(gridList)
    # for item in gridList:
    #       print item
    return gridList

gridlist = getGrid()

def getGridID(x, y):
    for item in gridlist:
        if (item[0] <= x and item[0]+cellUnit > x and item[1] <= y and item[1]+cellUnit  > y):
            print item
            getid = item[2]
            return getid
    return None

getGridID(7701431, 733815)



