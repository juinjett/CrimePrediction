clear;
clc;

[train_datas, test_datas] = split_datas('STREET CRIMES');
train_datas_parsed = [];
%%%%%%%%%%%%% used for debug, in order to save time
%train_datas = train_datas(1:10000, :);
%test_datas = test_datas(1:2000, :);
%%%%%%%%%%%%%
for i = 1: 55*46 : size(train_datas, 1)
    train_datas_month = parse_data_to_binary(train_datas(i:(i+55*46-1), :));
    train_datas_parsed = [train_datas_parsed; train_datas_month];
    i = i+55*46;
    %fprintf('i = %d\n', i);
end
train_datas = train_datas_parsed;

%save train_datas_logistci.mat train_datas;
%save test_datas_logistic.mat test_datas;


% train data
x_train = train_datas(:, 1:4);
x_train = [x_train(:, 1)-2011, x_train(:, 2:4)];
y_train = train_datas(:, 5);

% test data
x_test = test_datas(:, 1:4);
x_test = [x_test(:, 1)-2011, x_test(:, 2:4)];
y_test = test_datas(:, 5);

%disp 'mnrfit';
% Multinomial logistic regression, the code has problem
% train
B = mnrfit(x_train, y_train);
% B = glmfit(x_train, [y_train 100*ones(size(y_train, 1), 1)], 'binomial', 'link', 'probit');
% 
% %%%%%%%%%%%%%%%% save B
% save 'Mul_logistic_regression.mat' B
% %%%%%%%%%%%%%%%%
% 
% %%%%%%%%%%%%% load B
% % load 'Mul_logistic_regression.mat'
% %%%%%%%%%%%%%
% 
% % predict
y_predict = mnrval(B, x_test);
% y_predict = glmval(B, x_test, 'logit');
for i = 1:size(y_test, 1) 
    %fprintf('real = %f, predict = %f\n',y_test(i), y_predict(i));
end

for i = 3:3
    for index = 1:size(test_datas, 1)
         if test_datas(index, 1) == 2016 && test_datas(index, 2) == i
             break;
         end
     end
    % get i month data
     x_month = test_datas(index:(index + 55*46 -1), 1:4);
     y_month = test_datas(index:(index + 55*46 -1), 5);
    % predict
     y_predict = mnrval(B, x_month);
    % print judege criteria
    fprintf('at month %d:\n', i);
    for ii = 1:size(y_predict, 1) 
         %fprintf('real = %f, predict = %f\n', y_month(ii), y_predict(ii));
    end
    forcasted_total_ratio = 0.005;
    [result_PAI, result_PEI, overlap_cell_number, overlap_cell_number_ratio] = judge_criteria(x_month, y_month, y_predict(:, 1), forcasted_total_ratio)
    % heat map
    show_single_heatmap([x_month, y_month]);
    show_single_heatmap([x_month, y_predict]);
end

function train_datas_sort = parse_data_to_binary(train_datas_month)
    length = size(train_datas_month, 1);
    train_datas_sort = sortrows(train_datas_month, -5);
    for i = 1 : floor(0.1*length)
        train_datas_sort(i, 5) = 2;
    end
    for i = floor(0.05*length)+1 : length
        train_datas_sort(i, 5) = 1;
    end
end