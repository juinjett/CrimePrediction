import shapefile
import numpy as np
from grid import *
import Tkinter
from constant_values import x_coor_min,x_coor_max,y_coor_min,y_coor_max

cellUnit = 600
myshp = open("Data/portland-police-districts/Portland_Police_Districts.shp","rb")
mydbf = open("Data/portland-police-districts/Portland_Police_Districts.dbf","rb")
r = shapefile.Reader(shp=myshp, dbf=mydbf)

shape = r.shapes()
bbox = r.bbox
#print bbox      #upper and lower bound of the X and Y coordinate
xMin = bbox[0]
xMax = bbox[2]
yMin = bbox[1]
yMax = bbox[3]

def getGrid():
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
    #print len(gridList)
    # for item in gridList:
    #       print item
    return gridList

def getGridID(x, y):
    if x < xMin or x > xMax or y < yMin or y > yMax:
        return -1, -1
    x_grid = int((x - xMin)/cellUnit)
    y_grid = int((y - yMin)/cellUnit)
    return x_grid, y_grid

# print getGridID(7641076, 684831)[1]
