classdef lissajour
    properties
        f_source        %电源频率
        Cm              %测量电容值
        filename_csv    %文件地址
    end
    methods
        % function obj = lissajour(f_source, Cm,filename)                   %初始化赋值
        % function get_ch(n)                                                %获得某个通道的数据
        % function show_ch(n)                                               %显示某个通道的数据
        % function get_length                                               %获得数据长度
        % function show_length                                              %显示数据长度
        % function get_delta_t                                              %获得采样间隔
        % function show_delta_t                                             %显示采样间隔
        % function DAQtime = get_DAQtime()                                  %显示数据采集时间
        % function show_DAQtime()
        % function get_power                                                %获得功率
        % function show_power                                               %显示功率
        % function get_T_count                                              %获得采集周期数
        % function show_T_count
        % function get_powerT(n)                                            %获得某个周期的功率
        % function show_powerT(n)
        % function get_points_per_T                                         %获得每个周期的采样点数
        % function show_points_per_T
        % function lissajour                                                %显示总体李萨如图
        % function lissajourT(n)                                            %显示某个周期的李萨如图
        
        
        function obj = lissajour(f_source, Cm,filename_csv)                 %初始化赋值
            obj.f_source = f_source;
            obj.Cm = Cm;
            obj.filename_csv = filename_csv;
        end
        function data = get_ch(obj, n)                                      %获得某个通道的数据
            M_origin = xlsread(obj.filename_csv);
            data = M_origin(:,n + 1);%CH1
        end
        function show_ch(obj, n)                                            %显示某个通道的数据
            data = get_ch(obj, n);
            plot(data)
        end
        function L = get_length(obj)                                        %获得数据长度
            data = get_ch(obj, 0);
            L = length(data);
        end
        function delta_t = get_delta_t(obj)                                 %获得采样间隔
            T = get_ch(obj, 0);
            delta_t = abs(T(1) - T(2));
        end
        function DAQtime = get_DAQtime(obj)                                 %数据采集时间
            L = get_length(obj);
            delta_t = get_delta_t(obj);
            DAQtime = L * delta_t;
        end
        function points_per_T = get_points_per_T(obj)                       %获得每个周期的采样点数
            T_source = 1/ obj.f_source/ 1000;
            delta_t = get_delta_t(obj);
            points_per_T = floor( T_source/ delta_t ) + 1;
        end
        function T = T_count(obj)                                           %获得采集周期数
            L = get_length(obj);
            points_per_T = get_points_per_T(obj);
            T = floor( L/points_per_T ) - 1;
        end
        function k = kcons(obj, ch)
            %将X,Y两列坐标全部取整，kx为取整倍数，计算kx
            %判断是否存在小数
            %count = 0
            X1 = get_ch(obj, ch);
            countx = 0;
            R = rem(X1, 10^(-countx));
            while(norm(R,2) ~= 0)
                countx = countx + 1;
                R = rem(X1, 10^(-countx));
            end
            
            k = 10^countx;
        end                                      %计算通道ch的取整系数k
        function P = get_powerT(obj, T_num, ch1, ch2)                       %获得某个周期的功率
            % 功能：读取示波器CSV文件
            % 输入：[ X1,Y1,T_count, kx, ky，points_per_T ,Cm, f_source], T_num
            % 输出：功率P
            M = get_M(obj, T_num, ch1, ch2); %获得矩阵M            
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
            kx = kcons(obj, ch1);
            ky = kcons(obj, ch2);
            f = obj.f_source;
            C = obj.Cm;
            A = A/kx/ky;
            % 计算功率，X方向每格500mv = 0.5V, Y方向每格5V，频率f = 1KHz,Cm = 39nF
            %     f = 1000;%电源频率
            %     Cm = 2.19*10^(-9);%测量电容大小
            P = A*f*1000*C*10^(-9);%功率
        end
        function P = get_power(obj, ch1, ch2)                               %获得功率
            T = T_count(obj);
            for cnt = 1:T
                P(cnt) = get_powerT(obj, cnt, ch1, ch2);
            end
        end        
        function M = get_M(obj, T_num, ch1, ch2)                            %获得矩阵M
          
            points_per_T = get_points_per_T(obj);
            kx = kcons(obj, ch1);
            ky = kcons(obj, ch2);
            X1 = get_ch(obj, ch1);
            Y1 = get_ch(obj, ch2);
            
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
        end
        function show_lissajourT(obj,  ch1, ch2, T_num)                     %显示某个周期的李萨如图
            points_per_T = get_points_per_T(obj);
            kx = kcons(obj, ch1);
            ky = kcons(obj, ch2);
            X1 = get_ch(obj, ch1);
            Y1 = get_ch(obj, ch2);
            
            point_start = T_num*points_per_T + 1;
            point_end = (T_num + 1) * points_per_T;
            X = floor(kx*X1(point_start : point_end));
            Y = floor(ky*Y1(point_start : point_end));
            plot(X, Y)
        end         
        function show_power(obj, ch1, ch2)                                  %显示功率
            T = T_count(obj);
            t = 1/obj.f_source: 1/obj.f_source: T/obj.f_source;
            P = get_power(obj, ch1, ch2);
            plot(t, P)
        end
        function show_lissajour(obj, ch1, ch2)                              %显示总体李萨如图
            X = get_ch(obj, ch1);
            Y = get_ch(obj, ch2);
            plot(X, Y)
        end
                
    end
end