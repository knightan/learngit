% x = [100,100,10,90];
% y = [17,17,107,27];
x = X;
y = Y;
i=1;
while i<length(x)
    if x(i)==x(i+1)
        x(i+1) = [];
        y(i+1) = [];
    else
        i = i + 1;
    end
end

Xeo = [];
Yeo = [];

for i = 1:length(x) - 1
    
    if(x(i) == x(i+1))
    else
        k = (y(i) - y(i+1))/(x(i) - x(i+1));
        b = y(i) - k*x(i);
        if x(i) < x(i+1)
            xt = x(i):1:x(i+1)-1;
            yt = floor(k*xt + b);
            Xeo = [Xeo , xt];
            Yeo = [Yeo , yt];
        else
            xt = x(i+1)+1:1:x(i);
            yt = floor(k*xt + b);
            xt = fliplr(xt);
            yt = fliplr(yt);
            Xeo = [Xeo , xt];
            Yeo = [Yeo , yt];
        end
    end

end
Xeo = [Xeo , x(length(x))];
Yeo = [Yeo , y(length(y))];
% 将let the Xeo and Yeo be positive 得到全正数数列
MIN_Xeo = min(Xeo);
MIN_Yeo = min(Yeo);
if MIN_Xeo <= 0
    Xeo = Xeo + abs(MIN_Xeo) + 1;
end
if MIN_Yeo <= 0
    Yeo = Yeo + abs(MIN_Yeo) + 1;
end
% 矩阵的长度为MAX_Xeo – MIN_Xeo + 1,MAX_Yeo – MIN_Yeo + 1
length_M = max(Xeo) - min(Xeo) + 1;
width_M = max(Yeo) - min(Yeo) + 1;
M = zeros(length_M,width_M);
% Xeo数列和Yeo数列作为坐标点绘制矩阵图
for i = 1:length(Xeo)
    M(Xeo(i),Yeo(i)) = 1;
end
imshow(M,[0 1])
% 沿X扫描，如果经过两点以上，统计前两点之间的空白的数量，边沿计算一遍。累加所有的空白点
SUM_M = sum(M, 1);
A = 0;
for i = 1:length_M
    if SUM_M(i) == 1
        A = A + 1;%如果数量为1，面积直接加1
    else
        
    end
end