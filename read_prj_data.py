import pycrs
from pyproj import Proj
from read_dbf_data import get_rows

fromcrs = pycrs.loader.from_file('Data/2012/NIJ2012_MAR01_DEC31.prj')
p = Proj(fromcrs.to_proj4())
p
rows = get_rows()
for r in rows:
    print r[5], r[6]
    lon, lat = p(r[5], r[6], inverse=True);
    print lon, lat
