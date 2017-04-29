clear;
clc;
info = shapeinfo('Data/201701/NIJ2017_JAN01_JAN31.shp');
%from 201203-201701: totaly 59 months

% string = 'STREET CRIMES'
% 
ppd = shaperead('Data/Portland_Police_Districts/Portland_Police_Districts.shp');
% S201701 = shaperead('Data/201701/NIJ2017_JAN01_JAN31.shp', 'selector', {@(v1) (strcmp(v1,string)), 'CATEGORY'});
% S201612 = shaperead('Data/201612/NIJ2016_DEC01_DEC31.shp', 'selector', {@(v1) (strcmp(v1,string)), 'CATEGORY'});
% S201611 = shaperead('Data/201611/NIJ2016_NOV01_NOV30.shp', 'selector', {@(v1) (strcmp(v1,string)), 'CATEGORY'});
% S201610 = shaperead('Data/201610/NIJ2016_OCT01_OCT31.shp', 'selector', {@(v1) (strcmp(v1,string)), 'CATEGORY'});
% S201609 = shaperead('Data/201609/NIJ2016_SEP01_SEP30.shp', 'selector', {@(v1) (strcmp(v1,string)), 'CATEGORY'});
% S201608 = shaperead('Data/201608/NIJ2016_AUG01_AUG31.shp', 'selector', {@(v1) (strcmp(v1,string)), 'CATEGORY'});
% S201601 = shaperead('Data/201601/NIJ2016_JAN01_JUL31.shp', 'selector', {@(v1) (strcmp(v1,string)), 'CATEGORY'});
% 
% S2016 = [S201601; S201608; S201609; S201610; S201611; S201612]
% 
% S2015 = shaperead('Data/2015/NIJ2015_JAN01_DEC31.shp', 'selector', {@(v1) (strcmp(v1,string)), 'CATEGORY'});
% S2014 = shaperead('Data/2014/NIJ2014_JAN01_DEC31.shp', 'selector', {@(v1) (strcmp(v1,string)), 'CATEGORY'});
% S2013 = shaperead('Data/2013/NIJ2013_JAN01_DEC31.shp', 'selector', {@(v1) (strcmp(v1,string)), 'CATEGORY'});
% S2012 = shaperead('Data/2012/NIJ2012_MAR01_DEC31.shp', 'selector', {@(v1) (strcmp(v1,string)), 'CATEGORY'});
% 
% save('street_crime_all_data', 'S2012','S2013', 'S2014', 'S2015', 'S2016','S201701', 'ppd')

