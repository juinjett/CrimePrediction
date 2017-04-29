function x = get_Anscombe_transform_x(y)
% used only for Anscombe transform, y = sqrt(x) + sqrt(x+1)
% sqrt(x) + sqrt(x+1) = y, know y, get x
    if y <= 1
        x = 0;
        return;
    end
    x_min = 0;
    x_max = 1;
    for i = 0 : 100
       if sqrt(i)+sqrt(i+1) > y
           x_min = i-1;
           x_max = i;
           break;
       end
    end
    for i = x_min:0.01:x_max
        if sqrt(i) + sqrt(i+1) > y
            x = i;
            return;
        end
    end
end