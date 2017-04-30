clc;
clear;
load ('STREET CRIMES');
x=A(:,5);
x=sort(x);
d=diff([x;max(x)+1]);
count = diff(find([1;d])) ;
y =[x(find(d)) count];
 y(1,:)=[];
%  yy=[1,2,3,4,5,6,7]
 figure;
 bar(y(:,1),y(:,2));
poissfit(y(:,2))
% count = 0;
% sum = 0 ;
% for i=1:size(y,1)
%     count =  count+y(i,2);
%     sum = sum+y(i,1)*y(i,2);
%     
% end
% 
% mean = sum/count;
% 
 for i=1:size(x,1)
     x(i)=(x(i)-325)/sqrt(325);
 end
 x=sort(x);
 d=diff([x;max(x)+1]);
 count = diff(find([1;d])) ;
 y =[x(find(d)) count];
 figure;
 bar(y(:,1),y(:,2));
%  hist(y(:,2)')

