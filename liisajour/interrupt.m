% x = [100,100,10,90];
% y = [17,17,107,27];
clc
clear
% ����ѡ���ļ��Ի��򣬻��csv�ļ�������ַ
[filename1, pathname1] = uigetfile({'*.csv',  'csv Files (*.csv)'},'Pick a csv file');
% ����ѡ���ļ��Ի��򣬻��txt�ļ�������ַ
[filename2, pathname2] = uigetfile({'*.txt',  'para Files (*.txt)'},'Pick a para file');
%�ж��Ƿ�ѡ���ļ�
if isequal(filename1,0)
    disp('User selected Cancel')
elseif isequal(filename2,0)
    disp('User selected Cancel')
else
    filename_csv = fullfile(pathname1, filename1);
    filename_para = fullfile(pathname2, filename2);
    disp(['User selected', filename_csv])
    disp(['User selected', filename_para])
    % ��ȡCSV�ļ��е�X,Y��������
    M = xlsread(filename_csv);
    X1 = M(:,2);
    Y1 = M(:,3);
    kx = 1000;
    ky = 100;
    X = floor(kx*X1(301:400));
    Y = floor(ky*Y1(301:400));
    plot(X,Y);
    % grid on;
    grid minor
    
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
    f = 1000;
    Cm = 0.000000039;
    W = A*f*Cm;%4.7089mW
end

