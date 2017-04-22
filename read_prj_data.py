import matplotlib.pyplot as plt
from pyproj import Proj, transform
from read_dbf_data import get_rows

inProj = Proj(init='epsg:2913', preserve_units=True)
outProj = Proj(init='epsg:4326')
rows = get_rows()
lon_orig = []
lon_conv= []
lat_orig = []
lat_conv = []
for r in rows:
    lon_orig.append(r[5])
    lat_orig.append(r[6])
    lon, lat = transform(inProj, outProj, r[5], r[6])
    lat_conv.append(lat)
    lon_conv.append(lon)
    print lat, lon

'''
plt.subplot(2, 2, 1)
plt.plot(lon_orig, lon_conv, 'o')
plt.title('longitude')

plt.subplot(2, 2, 2)
plt.plot(lat_orig, lat_conv, 'ro')
plt.title('lattitude')
plt.show()
'''
