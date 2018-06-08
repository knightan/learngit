classdef lissajour
    properties
        f_source        %��ԴƵ��
        Cm              %��������ֵ
        filename_csv    %�ļ���ַ
    end
    methods
        % function obj = lissajour(f_source, Cm,filename)                   %��ʼ����ֵ
        % function get_ch(n)                                                %���ĳ��ͨ��������
        % function show_ch(n)                                               %��ʾĳ��ͨ��������
        % function get_length                                               %������ݳ���
        % function show_length                                              %��ʾ���ݳ���
        % function get_delta_t                                              %��ò������
        % function show_delta_t                                             %��ʾ�������
        % function DAQtime = get_DAQtime()                                  %��ʾ���ݲɼ�ʱ��
        % function show_DAQtime()
        % function get_power                                                %��ù���
        % function show_power                                               %��ʾ����
        % function get_T_count                                              %��òɼ�������
        % function show_T_count
        % function get_powerT(n)                                            %���ĳ�����ڵĹ���
        % function show_powerT(n)
        % function get_points_per_T                                         %���ÿ�����ڵĲ�������
        % function show_points_per_T
        % function lissajour                                                %��ʾ����������ͼ
        % function lissajourT(n)                                            %��ʾĳ�����ڵ�������ͼ
        
        
        function obj = lissajour(f_source, Cm,filename_csv)                 %��ʼ����ֵ
            obj.f_source = f_source;
            obj.Cm = Cm;
            obj.filename_csv = filename_csv;
        end
        function data = get_ch(obj, n)                                      %���ĳ��ͨ��������
            M_origin = xlsread(obj.filename_csv);
            data = M_origin(:,n + 1);%CH1
        end
        function show_ch(obj, n)                                            %��ʾĳ��ͨ��������
            data = get_ch(obj, n);
            plot(data)
        end
        function L = get_length(obj)                                        %������ݳ���
            data = get_ch(obj, 0);
            L = length(data);
        end
        function delta_t = get_delta_t(obj)                                 %��ò������
            T = get_ch(obj, 0);
            delta_t = abs(T(1) - T(2));
        end
        function DAQtime = get_DAQtime(obj)                                 %���ݲɼ�ʱ��
            L = get_length(obj);
            delta_t = get_delta_t(obj);
            DAQtime = L * delta_t;
        end
        function points_per_T = get_points_per_T(obj)                       %���ÿ�����ڵĲ�������
            T_source = 1/ obj.f_source/ 1000;
            delta_t = get_delta_t(obj);
            points_per_T = floor( T_source/ delta_t ) + 1;
        end
        function T = T_count(obj)                                           %��òɼ�������
            L = get_length(obj);
            points_per_T = get_points_per_T(obj);
            T = floor( L/points_per_T ) - 1;
        end
        function k = kcons(obj, ch)
            %��X,Y��������ȫ��ȡ����kxΪȡ������������kx
            %�ж��Ƿ����С��
            %count = 0
            X1 = get_ch(obj, ch);
            countx = 0;
            R = rem(X1, 10^(-countx));
            while(norm(R,2) ~= 0)
                countx = countx + 1;
                R = rem(X1, 10^(-countx));
            end
            
            k = 10^countx;
        end                                      %����ͨ��ch��ȡ��ϵ��k
        function P = get_powerT(obj, T_num, ch1, ch2)                       %���ĳ�����ڵĹ���
            % ���ܣ���ȡʾ����CSV�ļ�
            % ���룺[ X1,Y1,T_count, kx, ky��points_per_T ,Cm, f_source], T_num
            % ���������P
            M = get_M(obj, T_num, ch1, ch2); %��þ���M            
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
            kx = kcons(obj, ch1);
            ky = kcons(obj, ch2);
            f = obj.f_source;
            C = obj.Cm;
            A = A/kx/ky;
            % ���㹦�ʣ�X����ÿ��500mv = 0.5V, Y����ÿ��5V��Ƶ��f = 1KHz,Cm = 39nF
            %     f = 1000;%��ԴƵ��
            %     Cm = 2.19*10^(-9);%�������ݴ�С
            P = A*f*1000*C*10^(-9);%����
        end
        function P = get_power(obj, ch1, ch2)                               %��ù���
            T = T_count(obj);
            for cnt = 1:T
                P(cnt) = get_powerT(obj, cnt, ch1, ch2);
            end
        end        
        function M = get_M(obj, T_num, ch1, ch2)                            %��þ���M
          
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
        end
        function show_lissajourT(obj,  ch1, ch2, T_num)                     %��ʾĳ�����ڵ�������ͼ
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
        function show_power(obj, ch1, ch2)                                  %��ʾ����
            T = T_count(obj);
            t = 1/obj.f_source: 1/obj.f_source: T/obj.f_source;
            P = get_power(obj, ch1, ch2);
            plot(t, P)
        end
        function show_lissajour(obj, ch1, ch2)                              %��ʾ����������ͼ
            X = get_ch(obj, ch1);
            Y = get_ch(obj, ch2);
            plot(X, Y)
        end
                
    end
end