function Gaussian_process()

[train_datas, test_datas] = split_datas('MOTOR VEHICLE THEFT');
[mean_train, std_train] = cal_grid_mean_std(train_datas);

%%%%%%%%%%%%% used for debug, in order to save time
%train_datas = train_datas(1:40000, :);
%test_datas = test_datas(1:10000, :);
%%%%%%%%%%%%%

% train data
x_train = train_datas(:, 1:4);
crime_number_train = train_datas(:, 5);
% get y_train
y_train = get_y_train(x_train, crime_number_train, mean_train, std_train); 

% test data
x_test = test_datas(:, 1:4);
crime_number_test = test_datas(:, 5);

%%%%%%%%%%%%%%%%%% get gprMdl
% gprMdl = fitrgp(x_train, y_train, 'KernelFunction','squaredexponential');
% save gprMdl_GP_Anscombe_transform_MOTOR_VEHICLE_THEFT.mat gprMdl
%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%% load gprMdl
load('gprMdl_GP_Anscombe_transform_MOTOR_VEHICLE_THEFT.mat');
%%%%%%%%%%%%%%%%%%


%%%%%%%% for all the test datas
% y_predict = predict(gprMdl, x_test);
%crime_number_predict = get_crime_number_predict(x_test, y_predict, mean_train, std_train);
%for i = 1:size(y_predict, 1) 
    %fprintf('real = %f, predict = %f\n',crime_number_test(i), crime_number_predict(i));
%end
%[result_PAI, result_PEI] = judge_criteria(x_test, crime_number_test, crime_number_predict)
%%%%%%%%

% get test data by month, 3 4 5 6 7 8 9 10 11 12 / 2016, predict
% i is month, year is 2016
summary = [];
for i = 3:12
    for index = 1:size(test_datas, 1)
        if test_datas(index, 1) == 2016 && test_datas(index, 2) == i
            break;
        end
    end
    % get i month data
    x_month = test_datas(index:(index + 55*46 -1), 1:4);
    crime_number_real = test_datas(index:(index + 55*46 -1), 5);
    % predict
    y_predict = predict(gprMdl, x_month);
    crime_number_predict = get_crime_number_predict(x_month, y_predict, mean_train, std_train);
    % print judege criteria
    fprintf('at month %d:\n', i);
    for ii = 1:size(y_predict, 1) 
         %fprintf('real = %f, predict = %f\n',crime_number_real(ii), crime_number_predict(ii));
    end
    forcasted_total_ratio = 0.005;
    [result_PAI, result_PEI, overlap_cell_number, overlap_cell_number_ratio] = judge_criteria(x_month, crime_number_real, crime_number_predict, forcasted_total_ratio)
    summary = [summary;[result_PAI, result_PEI, overlap_cell_number, overlap_cell_number_ratio]];
    % heat map
%     show_single_heatmap([x_month, crime_number_real]);
%     show_single_heatmap([x_month, crime_number_predict]);
end

Monthes = {'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'}
PAI = summary(:,1);
PEI = summary(:,2);
overlap_cell_number = summary(:,3);
overlap_cell_number_ratio = summary(:,4);
T = table(PAI, PEI, overlap_cell_number, overlap_cell_number_ratio, 'RowNames', Monthes)
save results_GP_MVT T

end

function y_train = get_y_train(x_train, crime_number_train, mean_train, std_train)
    %%%%%%
    %y_train = zeros(size(crime_number_train, 1), 1);
    %for i = 1:size(x_train, 1)
    %    x = x_train(i, 3);
    %    y = x_train(i, 4);
    %    y_train(i) = log(crime_number_train(i) / (mean_train(x, y)));
    %end
    %%%%%%
    
    %%%%%%%%%%
    %%%%%%%%%% it is ok
%     y_train = zeros(size(crime_number_train, 1), 1);
%     for i = 1:size(x_train, 1)
%         x = x_train(i, 3);
%         y = x_train(i, 4);
%         y_train(i) = (crime_number_train(i) - mean_train(x, y))/std_train(x, y);
%     end
    %%%%%%%%%%
    %%%%%%%%%%
    
    %%%%%%%%%% Anscombe transform x -> 2sqrt(x), ok but not that good
%     y_train = zeros(size(crime_number_train, 1), 1);
%     for i = 1:size(x_train, 1)
%         y_train(i) = 2*sqrt(crime_number_train(i));
%     end
    %%%%%%%%%%
    
    %%%%%%%%%% Anscombe transform x -> sqrt(x) + sqrt(x+1), works ok
     y_train = zeros(size(crime_number_train, 1), 1);
     for i = 1:size(x_train, 1)
         y_train(i) = sqrt(crime_number_train(i)) + sqrt(crime_number_train(i)+1);
     end
    %%%%%%%%%%
    
end

function crime_number_predict = get_crime_number_predict(x_test, y_predict, mean_train, std_train)
    %%%%%%
    %crime_number_predict = zeros(size(y_predict, 1), 1);
    %for i = 1:size(y_predict, 1)
    %    x = x_test(i, 3);
    %    y = x_test(i, 4);
    %    crime_number_predict(i) = mean(x, y)*(exp(y_predict(i)));
    %end
    %%%%%%
    
    %%%%%%%%%%
    %%%%%%%%%% it is ok
%     crime_number_predict = zeros(size(y_predict, 1), 1);
%     for i = 1:size(y_predict, 1)
%         x = x_test(i, 3);
%         y = x_test(i, 4);
%         crime_number_predict(i) = y_predict(i)*std_train(x, y) + mean_train(x, y);
%     end
    %%%%%%%%%%
    %%%%%%%%%%
    
    %%%%%%%%%% Anscombe transform, ok but not that good
%     crime_number_predict = zeros(size(y_predict, 1), 1);
%     for i = 1:size(y_predict, 1)
%         crime_number_predict(i) = (y_predict(i)/2)^2;
%     end
    %%%%%%%%%%
    
    %%%%%%%%%% Anscombe transform, x -> sqrt(x) + sqrt(x+1), work sok
     crime_number_predict = zeros(size(y_predict, 1), 1);
     for i = 1:size(y_predict, 1)
         crime_number_predict(i) = get_Anscombe_transform_x(y_predict(i));
     end
    %%%%%%%%%%
end