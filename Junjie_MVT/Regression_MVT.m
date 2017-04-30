clear;
clc;

[train_datas, test_datas] = split_datas('MOTOR VEHICLE THEFT');

%%%%%%%%%%%%% used for debug, in order to save time
%train_datas = train_datas(1:100000, :);
%test_datas = test_datas(1:4000, :);
%%%%%%%%%%%%%

% % sum is year, month, how many cimres
% sum = zeros(5, 12);
% for i = 1:size(train_datas, 1)
%     year = train_datas(i, 1);
%     month = train_datas(i, 2);
%     sum(year-2011, month) = sum(year-2011,month) + train_datas(i,5); 
% end
% for i = 1:size(test_datas, 1)
%     year = test_datas(i, 1);
%     month = test_datas(i, 2);
%     sum(year-2011, month) = sum(year-2011,month) + test_datas(i,5); 
% end
% sum

% %regression model, result is bad
% % train
% x_train = train_datas(:, 1:4);
% y_train = train_datas(:, 5);
% mdl = fitlm(x_train,y_train,'interactions');
% % predict
% x_test = test_datas(:, 1:4);
% y_test = test_datas(:, 5);
%=======
% train data
x_train = train_datas(:, 1:4);
y_train = train_datas(:, 5);
% test data
x_test = test_datas(:, 1:4);
y_test = test_datas(:, 5);

% %linear regression model, result is bad
% % train
mdl = fitlm(x_train,y_train,'interactions');
% % predict
%>>>>>>> master
y_predict = feval(mdl, x_test);
% for i = 1:size(y_test, 1) 
%     fprintf('real = %f, predict = %f\n',y_test(i), y_predict(i));
% end
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
    y_predict = feval(mdl, x_month);
    % print judege criteria
    fprintf('at month %d:\n', i);
    for ii = 1:size(y_predict, 1) 
         %fprintf('real = %f, predict = %f\n', y_month(ii), y_predict(ii));
    end
    forcasted_total_ratio = 0.1;
    [result_PAI, result_PEI, overlap_cell_number, overlap_cell_number_ratio] = judge_criteria(x_month, y_month, y_predict, forcasted_total_ratio)
    % heat map
    show_single_heatmap([x_month, y_month]);
    show_single_heatmap([x_month, y_predict]);
end

% Multinomial logistic regression, the code has problem
% train
% y_train = y_train + 1;
% % B = mnrfit(x_train, y_train);
% B = glmfit(x_train, y_train, 'binomial', 'link', 'logit');
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
% % y_predict = mnrval(B, x_test) - 1;
% y_predict = glmval(B, x_test, 'logit') - 1;
% for i = 1:size(y_test, 1) 
%     fprintf('real = %f, predict = %f\n',y_test(i), y_predict(i));
% end