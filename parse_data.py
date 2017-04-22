from read_dbf_data import *
from constant_values import *

# example
# [0, u'DISORDER', 0, u'DISTURBANCE - PRIORITY', datetime.date(2012, 3, 1), 7641076.0, 684831.0, 4900.0]

# get rows by crime category
def get_rows_by_category(category):
    # input category is string
    rows = get_parsed_rows()
    rows_category = []
    category_number = category_to_number[category]
    for row in rows:
        if row[0] == category_number:
            rows_category.append(row)
    return rows_category

# get parse rows
def get_parsed_rows():
    rows = get_rows()
    x_number = 100
    y_number = 100

    # update x_coor, y_ coor with x_grid, y_grid
    for i in range(len(rows)):
        x_grid,y_grid = xy_coor_to_xy_grid(rows[i][5], rows[i][6], x_number, y_number)
        rows[i][5] = x_grid
        rows[i][6] = y_grid
    return rows

# split map into small squares
def xy_coor_to_xy_grid(x_coor, y_coor, x_number, y_number):
    x_precision = (x_coor_max - x_coor_min) / x_number
    y_precision = (y_coor_max - y_coor_min) / y_number
    x_grid = (x_coor - x_coor_min) / x_precision
    y_grid = (y_coor - y_coor_min) / y_precision
    x_grid = int(x_grid)
    y_grid = int(y_grid)
    return x_grid,y_grid

def xy_grid_to_xy_coor(x_grid, y_grid, x_number, y_number):
    # from x_grid, y_gird, we cann't get accurate x_number, y_number
    # this function is useless
    x_precision = (x_coor_max - x_coor_min) / x_number
    y_precision = (y_coor_max - y_coor_min) / y_number
    x_number = x_precision*x_number + x_coor_min
    y_number = y_precision*y_number + y_coor_min
    return x_number,y_number

'''
# parse date
def date_to_number(date):
    list = date.split('/')
    # initial number is 1/1/2012
    number = 1001
    month = int(list[0])
    day = int(list[1])
    year = int(list[2])

    return month,day,year

def number_to_date(number):
    return '3/1/2012'
'''

# test
if __name__ == '__main__':
    rows_street_crime = get_rows_by_category('STREET CRIMES')
    for row in rows_street_crime:
        print row
