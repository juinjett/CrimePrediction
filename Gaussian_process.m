function Gaussian_process()
clear;
clc;

[train_datas, test_datas] = split_datas('STREET CRIMES');
% train data
x_train = train_datas(:, 1:4);
crime_number_train = train_datas(:, 5);
[mean_train, std_train] = cal_grid_mean_std(train_datas);
% get y_train
y_train = get_y_train(x_train, crime_number_train, mean_train, std_train); 
%

% test data
x_test = test_datas(:, 1:4);
crime_number_test = test_datas(:, 5);


gprMdl = fitrgp(x_train, y_train, 'KernelFunction','squaredexponential');
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
        y_train(i) = log(crime_number_train(i) / (mean_train(x, y)));
    end
end

function crime_number_predict = get_crime_number_predict(x_test, y_predict, mean_train, std_train)
    crime_number_predict = zeros(size(y_predict, 1), 1);
    for i = 1:size(y_predict, 1)
        x = x_test(i, 3);
        y = x_test(i, 4);
        crime_number_predict(i) = mean(x, y)*(exp(y_predict(i)));
    end
end