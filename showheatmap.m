clc;
clear;
load gprMdl_GP_zengjie.mat;
showhotspot(2016,2,'STREET CRIMES.mat');
predicths(2016,2,gprMdl);
function hm = shotheatmap(year,month,data)
    load(data)
    index=find(A(:,1)==year);
    A2016 = A(index,:);
    index = find(A2016(:,2)==month);
    A201612 = A2016(index,:);
    showhm(A201612);
     hm = A201612;
end

function hp = showhotspot(year,month,data)
    A=shotheatmap(year,month,data);
    
    b = sort(A(:,5), 'descend');
    l00th=b(100);
%     l00th
    idx=(A(:,5)>=l00th);
%     idx
    hs=A(idx,:);
%     size(hs,1)
    
    hs(:,5)=1;
%     hs
showhm(hs);
%     x=hs(:,3);
%     y=hs(:,4);
%     xmax=55;
%     ymax=46;
% %     hs
%     res=zeros(xmax,ymax);
%     for i=1:size(x,1)
%         res(x(i),y(i))=hs(i,5);
%     end
%     figure;
%     heatmap(res); 
end

function shm = showhm(data)
x=data(:,3);
    y=data(:,4);
%     xmax=max(x);
    xmax=55;
%     ymax=max(y);
    ymax=46;
    res=zeros(xmax,ymax);
    for i=1:size(x,1)
        res(x(i),y(i))=data(i,5);
    end
    figure;
    heatmap(res); 
    
end

function pd = predicthm(year,month,model)
load mean ; 
    xmax=55;
    ymax=46;
    input=[];
    for i=1:xmax
        for j=1:ymax
            input=[input;[year month i j]];
        end
    end
    fprintf('here');
    output=[];
    y_predict = predict(model, input);
    for i=1:size(y_predict,1)
        x=input(i,3);
        y=input(i,4);
        output=[output (mean_train(x, y) + 0.001) * (exp(y_predict(i))) - 0.001;];
    end
    output=ceil(output);
    data=[input output'];
    pd=data;
    showhm(data);
    
end

function pd = predicths(year,month,model)
    A=predicthm(year,month,model);
        b = sort(A(:,5), 'descend');
    l00th=b(100);
    idx=(A(:,5)>=l00th);
    hs=A(idx,:);    
    hs(:,5)=1;

    showhm(hs);
end