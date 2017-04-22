import sys
from constant_values import *
from dbfread import DBF

def date_to_number(date):
    list = date.split('/')
    # initial number is 1/1/2012
    number = 1001
    month = int(list[0])
    day = int(list[1])
    year = int(list[2])

    return number

def number_to_date(number):
    return '3/1/2012'

def read_one_dbf_file(rows, path):
    table = DBF(path, load=True)
    times = 0

    for record in table.records:
        if times > 10:
            break
        row = []
        # change category type to number
        row.append(category_to_number[record['CATEGORY']])
       # print category_number[record['CATEGORY']]
        row.append(record['CALL_GROUP'])

        if not final_case_type_to_number.has_key(record['final_case']):
            print 'missed final_case type:'
            print record['final_case']
        row.append(final_case_type_to_number[record['final_case']])

        row.append(record['CASE_DESC'])
        row.append(record['occ_date'])
        row.append(record['x_coordina'])
        row.append(record['y_coordina'])

        row.append(record['census_tra'])
        #times = times + 1
        #print row
        rows.append(row)
    return rows

def get_rows():
    paths = []
    # paths.append('Data/2012/NIJ2012_MAR01_DEC31.dbf')
    #paths.append('Data/2013/NIJ2013_JAN01_DEC31.dbf')
    #paths.append('Data/2014/NIJ2014_JAN01_DEC31.dbf')
    #paths.append('Data/2015/NIJ2015_JAN01_DEC31.dbf')
    paths.append('Data/201609/NIJ2016_SEP01_SEP30.dbf')

    rows = []
    for path in paths:
        read_one_dbf_file(rows, path)
    return rows

if __name__ == '__main__':
    print get_rows()[0]
