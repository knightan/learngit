function P = power_caculator(getCSV_OUT, T_num)
% 功能：读取示波器CSV文件
% 输入：[ X1,Y1,T_count, kx, ky，points_per_T ,Cm, f_source], T_num
% 输出：功率P
X1 = getCSV_OUT.X1;
Y1 = getCSV_OUT.Y1;
kx = getCSV_OUT.kx;
ky = getCSV_OUT.ky;
Cm = getCSV_OUT.Cm;
f_source = getCSV_OUT.f_source;
points_per_T = getCSV_OUT.points_per_T;


%     T_num: 周期编号，即第几个周期

point_start = T_num*points_per_T + 1;
point_end = (T_num + 1) * points_per_T;
X = floor(kx*X1(point_start : point_end));
Y = floor(ky*Y1(point_start : point_end));

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
% grid on;
% imshow(~M,[0 1])
% 沿X扫描，如果经过两点以上，统计前两点之间的空白的数量，边沿计算一遍。累加所有的空白点
SUM_M = sum(M, 2);
A = 0;
for i = 1:length(SUM_M)
    if SUM_M(i) == 1
        A = A + 1;%如果数量为1，面积直接加1
    else
        x = M(i,:);
        index = find(x == 1);%取坐标 index = find(x == 1)
        At = max(index) - min(index) + 1;%取最远的两点的坐标, At = Y_max - Y_min + 1, A = A + At
        A = A + At;
    end
end

A = A/kx/ky;
% 计算功率，X方向每格500mv = 0.5V, Y方向每格5V，频率f = 1KHz,Cm = 39nF
%     f = 1000;%电源频率
%     Cm = 2.19*10^(-9);%测量电容大小
P = A*f_source*1000*Cm*10^(-9);%功率
end