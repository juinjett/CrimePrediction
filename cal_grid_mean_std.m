function [mean_data, std] = cal_grid_mean_std(datas)
% is value
x_max = 1;
y_max = 1;
for i = 1:size(datas, 1)/50
    x_max = max(x_max, datas(i, 3));
    y_max = max(y_max, datas(i, 4));
end
sums = zeros(x_max, y_max);
% how many months
times = zeros(x_max, y_max);
for i = 1:size(datas, 1)
    x = datas(i, 3);
    y = datas(i, 4);
    times(x, y) = times(x, y) + 1;
    sums(x, y) = sums(x, y) + datas(i, 5);
end
mean_data = zeros(x_max, y_max);
for i = 1:x_max
    for j = 1:y_max
        if times(i, j) >= 1
            mean_data(i, j) = sums(i, j)/times(i, j);
        end
    end
end
x_minus_mean_square = zeros(x_max, y_max);
for i = 1:size(datas, 1)
    x = datas(i, 3);
    y = datas(i, 4);
    x_minus_mean_square(x, y) = x_minus_mean_square(x, y) + (datas(i, 5) - mean_data(x, y))^2;
end
std = zeros(x_max, y_max);
for i = 1:x_max
    for j = 1:y_max
        if times(i, j) >= 1
            std(i, j) = sqrt(x_minus_mean_square(i, j) / times(i, j));
        end
    end
end