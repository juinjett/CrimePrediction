clear;
clc;

[train_datas, test_datas] = split_datas('STREET CRIMES');
% train data
x_train = train_datas(:, 1:4);
crime_number_train = train_datas(:, 5);
[mean_train, std_train] = cal_grid_mean_std(train_datas);
mean_train
std_train
% % get y_train
% y_train = zeros(crime_number_train);
% 
% %
% 
% % test data
% x_test = test_datas(:, 1:4);
% crime_number_test = test_datas(:, 5);
% 
% 
% gprMdl = fitrgp(x_train, y_train, 'KernelFunction','squaredexponential');
% y_predict = predict(gprMdl, x_test);
% 
% %>>>>>>> master
% crime_number_predict = ;
% for i = 1:size(y_test, 1) 
%     fprintf('real = %f, predict = %f\n',crime_number_test(i), crime_number_predict(i));
% end
% 
% function y_test = get_y_test(x_train, crime_number_train, mean_train)
%     
%     
% end
% 
% function crime_number_predict = get_crime_number_predict(x_test, y_predict, mean_train)
%     
%     
% end