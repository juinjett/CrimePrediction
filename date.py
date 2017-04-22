import datetime
import time

def toDate(str):
    t = str.split('/')
    date = datetime.datetime(int(t[0]),int(t[1]),int(t[2])).strftime("%w")
    return date

