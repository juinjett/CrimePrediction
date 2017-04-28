clear;
clc;

rows = 69; 
cols = 82;
load('STREET CRIMES.mat');
size_all_data = size(A,1)
each_month = size_all_data/58;

index = find(A(:, 5));
size_index = size(index,1 )
%index(1:10)

%zero_column = zeros(size_all_data,1);
new_mat = [A(:,3:4) zeros(size_all_data,1)];


for i=1:size_index
    tmp = index(i);
    x_cord = A(index(i),3);
    y_cord = A(index(i),4);
    new_mat(x_cord*rows+y_cord+1, 3) = new_mat(x_cord*136+y_cord+1, 3) +1;
end

figure();

first_month = new_mat(1:each_month,3);
first_month_img = reshape(first_month,rows,cols);
imshow(first_month_img, [])
    