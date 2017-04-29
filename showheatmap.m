clc;
clear;
showheatmap(2016,2);
function hm = showheatmap(year,month)
    load('STREET CRIMES.mat')
    index=find(A(:,1)==year);
    A2016 = A(index,:);
    index = find(A2016(:,2)==month);
    A201612 = A2016(index,:);
    x=A201612(:,3);
    y=A201612(:,4);
    xmax=max(x);
    ymax=max(y);
    res=zeros(xmax,ymax);
    for i=1:size(x,1)
        res(x(i),y(i))=A201612(i,5);
    end
    heatmap(res); 
end


    