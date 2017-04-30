from read_dbf_data import *
from constant_values import *
from date_related import *
import numpy as np
from constant_values import x_number, y_number
from save_read_txt import *
from getGridID import getGridID
from save_mat import *

# example
# [0, u'DISORDER', 0, u'DISTURBANCE - PRIORITY', datetime.date(2012, 3, 1), 7641076.0, 684831.0, 4900.0]

# get rows by crime category
# get date by month
# output one example
# [[2012, 3, 5, 10, 1.0], ... ]
def get_training_data_by_category(category):
    rows_category = get_rows_by_category(category)

    # 4-dim matrix year month x y
    cal_data = np.zeros([5, 13, x_number, y_number])
    # year month x_gird y_grid crime_number
    for row in rows_category:
        month, day, year, which_day = parse_date(row[4])
        x_grid = row[5]
        y_grid = row[6]
        #print year, month, x_grid, y_grid
        if x_grid >= x_number or y_grid >= y_number:
            continue
        cal_data[year - 2012][month][x_grid][y_grid] += 1
    # to be continued
    train_datas = []
    for i in range(5):
        for j in range(1, 13):
            for i_x in range(1, x_number):
                for i_y in range(1, y_number):
                    #if cal_data[i][j][i_x][i_y] > 0:

                    # all the data start from 2012 3
                    if i == 0 and j <= 2:
                        continue

                    train_data = []
                    train_data.append(2012 + i)
                    train_data.append(j)
                    train_data.append(i_x)
                    train_data.append(i_y)
                    train_data.append(cal_data[i][j][i_x][i_y])
                    train_datas.append(train_data)
                    #print train_data
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
    global x_grid_min
    global x_grid_max
    global y_grid_min
    global y_grid_max
    for i in range(len(rows)):
        x_grid, y_grid = getGridID(rows[i][5], rows[i][6])
        #print grid
        if x_grid == -1 or y_grid == -1:
            continue
        rows[i][5] = x_grid
        #x_grid_min = min(x_grid_min, rows[i][5])
        #x_grid_max = max(x_grid_max, rows[i][5])
        rows[i][6] = y_grid
        #y_grid_min = min(y_grid_min, rows[i][6])
        #y_grid_max = max(y_grid_max, rows[i][6])

# test
if __name__ == '__main__':
    category = 'BURGLARY'
    '''
    rows_street_crime = get_rows_by_category(category)
    for row in rows_street_crime:
        print row

    # test date
    print parse_date(rows_street_crime[0][4])
    '''
    train_datas = get_training_data_by_category(category)
    #save_to_txt(train_datas, category)
    save_to_mat(train_datas, category)
