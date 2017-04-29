function [result_PAI, result_PEI, overlap_cell_number] = judge_criteria(X, Y_real, Y_pred)

one_map = X(:,3:4);

% x_max = max(one_map(:,1));
% y_max = max(one_map(:,2));

% x_max = 1;
% y_max = 1;
% for i = 1:size(datas, 1)/50
%     x_max = max(x_max, datas(i, 3));
%     y_max = max(y_max, datas(i, 4));
% end

%calulate areas and cells
%total_area = (7757364-7547902)*(787753-602723); %from contant_values.py
%forcasted_area = 0.75*5280*5280; %from challenge website
%forcasted_total_ratio = forcasted_area/total_area;

forcasted_total_ratio = 0.01;

total_cells = size(one_map,1);
forcasted_cells = round(total_cells*forcasted_total_ratio);

% nonzero_index = find(Y_pred(:,1));
% nonzero = Y_pred(index,1);

%calculate number of forcasted crimes and total crimes
M = [X, Y_real, Y_pred];
M_pred_sorted = sortrows(Y, -6);
M_real_sorted = sortrows(Y, -5);

%calculate number of overlapping cells
overlap_cell = intersect(M_pred_sorted(1:forcasted_cells, 3:4), M_real_sorted(1:forcasted_cells, 3:4));
overlap_cell_number = size(overlap_cell,1);

forcasted_crimes = sum(M_pred_sorted(1:forcasted_cells, 5));
max_obtain_crimes = sum(M_real_sorted(1:forcasted_cells, 5));
total_crimes = sum(M(:,1));

%result PAI and PEI
result_PAI = (forcasted_crimes/total_crimes)/(forcasted_cells/total_cells);
result_PEI = forcasted_crimes/max_obtain_crimes;
end