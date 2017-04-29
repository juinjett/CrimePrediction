clear;
clc;

[train_datas, test_datas] = split_datas('STREET CRIMES');

index = find(train_datas(:,5));
new = train_datas(index,5);
sorted = sort(new, 'descend');

Y1 = [1 2 3 4]';
Y2 = [4 3 2 1]';
Y3 = [9 7 8 6]';

Y = [Y1 Y2 Y3];

Y2_sorted = sortrows(Y,-1)