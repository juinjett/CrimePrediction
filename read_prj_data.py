import matplotlib.pyplot as plt
import pycrs
from pyproj import Proj, transform
from read_dbf_data import get_rows

#inProj = Proj(init='epsg:2913', preserve_units=True)
#outProj = Proj(init='epsg:4326')

fromcrs = pycrs.loader.from_file('Data/2012/NIJ2012_MAR01_DEC31.prj')
p = Proj(fromcrs.to_proj4())

def get_lon_lat_from_xy(x_coor, y_coor):
    lon, lat = p(x_coor, y_coor, inverse = True)
    return lon, lat

if __name__ == '__main__':
    rows = get_rows()
    for r in rows:
        print r[5], r[6]
        lon, lat = p(r[5], r[6], inverse = True)
        print lon, lat

    lon, lat = get_lon_lat_from_xy(7654753.0, 692448.0)
    print lon, lat
