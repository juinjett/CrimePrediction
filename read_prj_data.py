import pycrs
from pyproj import Proj, transform
from read_dbf_data import get_rows

inProj = Proj(init='epsg:2913', preserve_units=True)
outProj = Proj(init='epsg:4326')
rows = get_rows()
for r in rows:
    lon, lat = transform(inProj, outProj, r[5], r[6])
    print lat, lon
