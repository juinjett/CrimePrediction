import xlrd
import openpyxl as px
import numpy as np

def read_xlsx_file(fname):
    wb = xlrd.open_workbook(fname)
    sh = wb.sheet_by_index(0)
    for rownum in range(sh.nrows):
        print sh.row_values(rownum)

def read_xlsx(fname):
    '''
    samples:
    path = "Data/2012/NIJ2012_MAR01_DEC31.xlsx"
    rows = read_xlsx(path)
    rows[0] = {'A': 'CATEGORY', 'C': 'final_case_type', 'B': 'CALL GROUPS', 'E': 'occ_date', 'D': 'CASE DESC', 'G': 'y_coordinate', 'F': 'x_coordinate', 'H': 'census_tract'}
    rows[1] = {'A': 'STREET CRIMES', 'C': 'DISTP ', 'B': 'DISORDER', 'E': '40969', 'D': 'DISTURBANCE - PRIORITY                            ', 'G': '684831', 'F': '7641076', 'H': '4900'}
    rows[2] = {'A': 'STREET CRIMES', 'C': 'DISTP ', 'B': 'DISORDER', 'E': '40969', 'D': 'DISTURBANCE - PRIORITY                            ', 'G': '683167', 'F': '7642640', 'H': '10600'}
    '''
    import zipfile
    from xml.etree.ElementTree import iterparse
    z = zipfile.ZipFile(fname)
    strings = [el.text for e, el in iterparse(z.open('xl/sharedStrings.xml'))  if el.tag.endswith('}t') ]
    rows = []
    row = {}
    value = ''
    for e, el in iterparse(z.open('xl/worksheets/sheet1.xml')):
        if el.tag.endswith('}v'): # <v>84</v>
            value = el.text
            print value
        if el.tag.endswith('}c'): # <c r="A3" t="s"><v>84</v></c>
            if el.attrib.get('t') == 's':
                value = strings[int(value)]
            letter = el.attrib['r'] # AZ22
            while letter[-1].isdigit():
                letter = letter[:-1]
            row[letter] = value
            value = ''
        if el.tag.endswith('}row'):
            rows.append(row)
            row = {}
    return rows

print read_xlsx('data/NIJ2017_FEB28.xlsx')

'''
path = "Data/2012/NIJ2012_MAR01_DEC31_test.xlsx"
rows = read_xlsx(path)


print len(rows)
print rows[0]
print rows[1]
'''

'''
total_rows = []
title = []
is_title = True

for row in rows:
    if is_title:
        title.append(row['A'])
        title.append(row['B'])
        title.append(row['C'])
        title.append(row['D'])
        title.append(row['E'])
        title.append(row['F'])
        title.append(row['G'])
    #    title.append(row['H'])
        is_title = False
        continue
    single_row = []
    single_row.append(row['A'])
    single_row.append(row['B'])
    single_row.append(row['C'])
    single_row.append(row['D'])
    single_row.append(row['E'])
    single_row.append(row['F'])
    single_row.append(row['G'])
#   single_row.append(row['H'])
    total_rows.append(single_row)

print title
print total_rows[0]
print total_rows[1]
print total_rows[2]
'''
