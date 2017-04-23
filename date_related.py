from datetime import datetime,date

# parse date
def parse_date(date):
    # input type is date
    year = date.year;
    month = date.month;
    day = date.day;
    # Monday, Tuesday, Thursday, ...
    which_day = int(date.strftime("%w"));
    return month, day, year, which_day

def is_leap_year(year):
    if year == 2012 or year == 2016:
        return True
    return False

def how_many_dates_in_this_year(year):
    if is_leap_year(year):
        return 366;
    return 355;

def how_many_dates_in_this_month(year, month):
    print month == 12
    if month == 2:
        if is_leap_year(year):
            return 29;
        return 28;
    elif month == 1 or month == 3 or month == 5 or month == 7 or month == 8 or month == 10 or month == 12:
        return 31;
    else:
        return 30;

if __name__ == '__main__':
    print 'test date_related ... '
    print how_many_dates_in_this_month(2013, 2)

