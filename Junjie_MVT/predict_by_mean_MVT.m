clear;
clc;

[train_datas, test_datas] = split_datas('MOTOR VEHICLE THEFT');
[mean_train, std_train] = cal_grid_mean_std(train_datas);


% train data
x_train = train_datas(:, 1:4);
y_train = train_datas(:, 5);

% test data
x_test = test_datas(:, 1:4);
y_test = test_datas(:, 5);

% predict
summary = [];
for i = 3:12
    for index = 1:size(test_datas, 1)
        if test_datas(index, 1) == 2016 && test_datas(index, 2) == i
            break;
        end
    end
    % get i month data
    x_month = test_datas(index:(index + 55*46 -1), 1:4);
    y_month = test_datas(index:(index + 55*46 -1), 5);
    % predict
    y_predict = zeros(size(y_month, 1), 1);
    for index = 1:size(x_month, 1)
        y_predict(index) = mean_train(x_month(index, 3), x_month(index, 4));
    end
    % print judege criteria
    fprintf('at month %d:\n', i);
    for ii = 1:size(y_predict, 1) 
         %fprintf('real = %f, predict = %f\n',y_month(ii), y_predict(ii));
    end
    forcasted_total_ratio = 0.005;
    [result_PAI, result_PEI, overlap_cell_number, overlap_cell_number_ratio] = judge_criteria(x_month, y_month, y_predict, forcasted_total_ratio)
    summary = [summary;[result_PAI, result_PEI, overlap_cell_number, overlap_cell_number_ratio]];
    % heat map
%     show_single_heatmap([x_month, y_month]);
%     show_single_heatmap([x_month, y_predict]);
end
Monthes = {'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'}
PAI = summary(:,1);
PEI = summary(:,2);
overlap_cell_number = summary(:,3);
overlap_cell_number_ratio = summary(:,4);
T = table(PAI, PEI, overlap_cell_number, overlap_cell_number_ratio, 'RowNames', Monthes)
save results_by_mean_MVT T

