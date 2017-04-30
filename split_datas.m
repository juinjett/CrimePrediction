function [train_datas, test_datas] = split_datas(category)
% split datas to train datas and test datas

% 2016, 3, 4, ..., 12 belong to test datas

% split data
% total length
% if category == 'STREET CRIMES'
%     load 'STREET CRIMES.mat'
% elseif category == 'OTHER'
%     load 'OTHER.mat'
% elseif category == 'MOTOR VEHICLE THEFT'
%     load 'MOTOR VEHICLE THEFT.mat'
% elseif category == 'BURGLARY'
%     load 'BURGLARY.mat'
% end

if strcmp(category,'STREET CRIMES')
    load 'STREET CRIMES.mat'
elseif strcmp(category,'MOTOR VEHICLE THEFT')
    load 'MOTOR VEHICLE THEFT.mat'
elseif strcmp(category,'BURGLARY')
    load 'BURGLARY.mat'
elseif strcmp(category,'OTHER')
    load 'OTHER.mat'
end

length = size(A, 1);
% % test length 
% test_length = floor(2.5*length/10);
% train_length = length - test_length;
% test_row = zeros(test_length, 1);
% test_index = 1;
% train_row = zeros(train_length, 1);
% train_index = 1;
% for i = 1:1:length
%     if rem(i, 9) == 0 || rem(i, 10) == 0
%         test_row(test_index) = i;
%         test_index = test_index + 1;
%     elseif train_index > train_length
%         test_row(test_index) = i;
%         test_index = test_index + 1;
%     else
%         train_row(train_index) = i;
%         train_index = train_index + 1;
%     end
% end
% 
% % split datas
% train_datas = A(train_row,:);
% test_datas = A(test_row,:);
split_index = 0;
for i = 1:length
    if A(i, 1) == 2016 && A(i, 2) == 3
        split_index = i;
        break;
    end
end
train_datas = A(1 : (split_index-1), :);
test_datas = A( split_index:length, :);
end