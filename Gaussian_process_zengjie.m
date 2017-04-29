function Gaussian_process_zengjie()
% ??????? ???
clear;
clc;

[train_datas, test_datas] = split_datas('STREET CRIMES');
[mean_train, std_train] = cal_grid_mean_std(train_datas);

%%%%%%%%%%%%% used for debug, in order to save time
train_datas = train_datas(1:40000, :);
test_datas = test_datas(1:10000, :);
%%%%%%%%%%%%%

% train data
x_train = train_datas(:, 1:4);
crime_number_train = train_datas(:, 5);
% get y_train
y_train = get_y_train(x_train, crime_number_train, mean_train, std_train); 
%

% test data
x_test = test_datas(:, 1:4);
crime_number_test = test_datas(:, 5);


%%% change Kernel
kfcn = @(XN,XM,theta) (exp(theta(2))^2)*exp(-(pdist2(XN,XM).^2)/(2*exp(theta(1))^2)) + theta(3);
% theta0 = [1.8804, -0.2144, -0.027];
theta0 = [1.5, 0.2, 0.1];
gprMdl = fitrgp( x_train, y_train, 'KernelFunction' , kfcn, 'KernelParameters', theta0);
%%%

% original Kernel 
% gprMdl = fitrgp(x_train, y_train, 'KernelFunction','squaredexponential');

% save gprMdl
% save gprMdl_GP_zengjie.mat gprMdl

y_predict = predict(gprMdl, x_test);

%>>>>>>> master
crime_number_predict = get_crime_number_predict(x_test, y_predict, mean_train, std_train);
for i = 1:size(y_predict, 1) 
    fprintf('real = %f, predict = %f\n',crime_number_test(i), crime_number_predict(i));
end
end

function y_train = get_y_train(x_train, crime_number_train, mean_train, std_train)
   y_train = zeros(size(crime_number_train, 1), 1);
   for i = 1:size(x_train, 1)
       x = x_train(i, 3);
       y = x_train(i, 4);
       y_train(i) = log((crime_number_train(i) + 0.0001) / ((mean_train(x, y)) + 0.0001));
   end
end

function crime_number_predict = get_crime_number_predict(x_test, y_predict, mean_train, std_train)
    crime_number_predict = zeros(size(y_predict, 1), 1);
    for i = 1:size(y_predict, 1)
        x = x_test(i, 3);
        y = x_test(i, 4);
        crime_number_predict(i) = max(0, (mean_train(x, y) + 0.0001) * (exp(y_predict(i))) - 0.0001);
    end
end