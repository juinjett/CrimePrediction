import numpy as np
import geohash
print 'Geohash for 42.7, -5.6:', geohash.encode(42.601, -5.6,precision=5)
print 'Geohash for 42.6, -5.6:', geohash.encode(42.602, -5.6,precision=5)
print 'Geohash for 45.6, -5.6:', geohash.encode(45.601, -5.6,precision=5)
print 'Geohash for 47.6, -5.6:', geohash.encode(47.602, -5.6,precision=5)
print 'Geohash for 57.6, -5.6:', geohash.encode(57.603, -5.6,precision=5)

print 'Coordinate for Geohash ezs42:', geohash.decode('ezs42')
# print 'Geohash for 42.6, -5.6:', Geohash.encode(42.6, -5.6)