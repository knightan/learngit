function P = power_caculator(getCSV_OUT, T_num)
% ���ܣ���ȡʾ����CSV�ļ�
% ���룺[ X1,Y1,T_count, kx, ky��points_per_T ,Cm, f_source], T_num
% ���������P
X1 = getCSV_OUT.X1;
Y1 = getCSV_OUT.Y1;
kx = getCSV_OUT.kx;
ky = getCSV_OUT.ky;
Cm = getCSV_OUT.Cm;
f_source = getCSV_OUT.f_source;
points_per_T = getCSV_OUT.points_per_T;


%     T_num: ���ڱ�ţ����ڼ�������

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
% ��let the Xeo and Yeo be positive �õ�ȫ��������
MIN_Xeo = min(Xeo);
MIN_Yeo = min(Yeo);
if MIN_Xeo <= 0
    Xeo = Xeo + abs(MIN_Xeo) + 1;
end
if MIN_Yeo <= 0
    Yeo = Yeo + abs(MIN_Yeo) + 1;
end
% ����ĳ���ΪMAX_Xeo �C MIN_Xeo + 1,MAX_Yeo �C MIN_Yeo + 1
length_M = max(Xeo) - min(Xeo) + 1;
width_M = max(Yeo) - min(Yeo) + 1;
M = zeros(length_M,width_M);
% Xeo���к�Yeo������Ϊ�������ƾ���ͼ
for i = 1:length(Xeo)
    M(Xeo(i),Yeo(i)) = 1;
end
% grid on;
% imshow(~M,[0 1])
% ��Xɨ�裬��������������ϣ�ͳ��ǰ����֮��Ŀհ׵����������ؼ���һ�顣�ۼ����еĿհ׵�
SUM_M = sum(M, 2);
A = 0;
for i = 1:length(SUM_M)
    if SUM_M(i) == 1
        A = A + 1;%�������Ϊ1�����ֱ�Ӽ�1
    else
        x = M(i,:);
        index = find(x == 1);%ȡ���� index = find(x == 1)
        At = max(index) - min(index) + 1;%ȡ��Զ�����������, At = Y_max - Y_min + 1, A = A + At
        A = A + At;
    end
end

A = A/kx/ky;
% ���㹦�ʣ�X����ÿ��500mv = 0.5V, Y����ÿ��5V��Ƶ��f = 1KHz,Cm = 39nF
%     f = 1000;%��ԴƵ��
%     Cm = 2.19*10^(-9);%�������ݴ�С
P = A*f_source*1000*Cm*10^(-9);%����
end