from read_dbf_data import *
from constant_values import *
from date_related import *
import numpy as np
from constant_values import x_number, y_number
from save_read_txt import *

# example
# [0, u'DISORDER', 0, u'DISTURBANCE - PRIORITY', datetime.date(2012, 3, 1), 7641076.0, 684831.0, 4900.0]

# get rows by crime category
# get date by month
# output one example
# [[2012, 3, 5, 10, 1.0], ... ]
def get_training_data_by_category(category):
    rows_category = get_rows_by_category(category)

    # 4-dim matrix year month x y
    cal_data = np.zeros([6, 13, x_number+1, y_number+1])
    # year month x_gird y_grid crime_number
    for row in rows_category:
        month, day, year, which_day = parse_date(row[4])
        x = row[5]
        y = row[6]
        #print year, month, x, y
        cal_data[year - 2012][month][x][y] += 1
    # to be continued
    train_datas = []
    for i in range(6):
        for j in range(13):
            for i_x in range(x_number+1):
                for i_y in range(y_number+1):
                    if cal_data[i][j][i_x][i_y] > 0:
                        train_data = []
                        train_data.append(2012 + i)
                        train_data.append(j)
                        train_data.append(i_x)
                        train_data.append(i_y)
                        train_data.append(cal_data[i][j][i_x][i_y])
                        train_datas.append(train_data)
                        print train_data
    # should append crime number == 0 areas to train_datas
    return train_datas

# output example:
# [0, u'PERSON CRIME', 11, u'THREAT - WITH WEAPON *H', datetime.date(2016, 9, 29), 10, 7, 1801.0]
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

    # update
    update_coord_by_grid(rows)


    return rows

# update x_coor, y_ coor with x_grid, y_grid
def update_coord_by_grid(rows):
    for i in range(len(rows)):
        x_grid,y_grid = xy_coor_to_xy_grid(rows[i][5], rows[i][6], x_number, y_number)
        rows[i][5] = x_grid
        rows[i][6] = y_grid


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
    # from x_grid, y_gird, we can't get accurate x_number, y_number
    # this function is useless
    x_precision = (x_coor_max - x_coor_min) / x_number
    y_precision = (y_coor_max - y_coor_min) / y_number
    x_number = x_precision*x_number + x_coor_min
    y_number = y_precision*y_number + y_coor_min
    return x_number,y_number

# test
if __name__ == '__main__':
    '''
    rows_street_crime = get_rows_by_category('STREET CRIMES')
    for row in rows_street_crime:
        print row

    # test date
    print parse_date(rows_street_crime[0][4])
    '''
    train_datas = get_training_data_by_category('STREET CRIMES')
    save_to_txt(train_datas)
