clear;
clc;

[train_datas, test_datas] = split_datas('STREET CRIMES');

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
% y_predict = feval(mdl, x_test);
% for i = 1:size(y_test, 1) 
%     fprintf('real = %f, predict = %f\n',y_test(i), y_predict(i));
% end


% Multinomial logistic regression
% train
x_train = train_datas(:, 1:4);
y_train = train_datas(:, 5);
B = mnrfit(x_train, y_train);
% predict
x_test = test_datas(:, 1:4);
y_test = test_datas(:, 5);
y_predict = mnrval(B, x_test);
for i = 1:size(y_test, 1) 
    fprintf('real = %f, predict = %f\n',y_test(i), y_predict(i));
end