clear;
clc;

load('STREET CRIMES.mat');
size_all_data = size(A,1)

index = find(A(:, 5));
size_index = size(index,1 )
%index(1:10)

zero_column = zeros(size_all_data,1);
new_mat = [A(:,3:4) zero_column];


for i=1:size_index
    tmp = index(i);
    x_cord = A(index(i),3);
    y_cord = A(index(i),4);
    new_mat(x_cord*136+y_cord+1, 3) = new_mat(x_cord*136+y_cord+1, 3) +1;
end

figure();
eachMonth = size(new_mat,1)/58;
firstMonth = new_mat(1:eachMonth,3);
rows = 136; cols = 160;
firstMonth_img = reshape(firstMonth,rows,cols);
hitmap(firstMonth_img, [])
    