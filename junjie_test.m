clear;
clc;

% [train_datas, test_datas] = split_datas('STREET CRIMES');
% 
% index = find(train_datas(:,5));
% new = train_datas(index,5);
% sorted = sort(new, 'descend');
% 
% Y1 = [1 2 3 4]';
% Y2 = [4 3 2 1]';
% Y3 = [9 7 8 6]';
% 
% Y = [Y1 Y2 Y3];
% tbl = table(Y1, Y2, Y3);
% Y2_sorted = sortrows(Y,-1);
% 
% %figure();
% % h = heatmap(tbl,'aaa','bbb');
% 
% syms x
% S = solve(sqrt(x)+sqrt(x+1)== 5.197156, x)
% vpa(S,5)

% summary = {'result_PAI', 'result_PEI', 'overlap_cell_number', 'overlap_cell_number_ratio'}
% T = table(Y, 'rownames', summary)

load ('../STREET CRIMES.mat');
%Y = [18 3; 1 11; 8 10; 18 3; 9 14; 6 1; 18 3; 15 21];
I = size(A,1)/58;
i =0;
count = [];
while i*I < size(A,1)
    new_A = A(i+1:i*I,:);
    count_unit = sum(new_A(:,5));
    count = [count; count_unit];
end
% new_A = A(I,5);
% num_max = max(new_A);
% num_min = min(new_A);
% 
% count = (num_min:num_max)';
% count1 = [count  zeros(size(count,1),1)];
% for i=1:size(new_A,1)
%     tmp = new_A(i);
%     for j=1:size(count1,1)
%         tmp1 = count1(j,1);
%         if tmp == tmp1
%             count1(j,2) = count1(j,2)+1;
%         end
%     end
% end
% idx= find(count1(:,2));
% count2 = count1(idx,:);
% 
% figure;
% plot(count2(:,1),count2(:,2),'k*')
