M = xlsread('liisajour7k.csv');
X1 = M(:,2);
Y1 = M(:,3);
X = floor(1000*X1(201:300));
Y = floor(100*Y1(201:300));

% Yneo = [];
% Xneo = [];
% Yneo = [Y(1),Y(2)];
% Xneo = [X(1),X(2)];
% xq = X(2):1:X(1);
% vq1 = interp1(Xneo,Yneo,xq);

% for i = 1:99
%     xq = X(i):1:X(i+1);
%     Xneo = [Xneo, xq];
% 
%     vq1 = interp1(X,Y,xq);%X, Y长度改为X(1),Y(1);X(2),Y(2)
%     Yneo = [Yneo, vq1];
% end

h = plot(X,Y);
x = get(h,'XData');
y = get(h,'YData');