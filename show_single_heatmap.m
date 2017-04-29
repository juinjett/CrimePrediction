function show_single_heatmap(data)
% data is [X, Y]
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