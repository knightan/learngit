%程序名称：lsr_1
%程序：两列正弦波合成李萨如图形（1：n型）
t=[0:0.001:10];	%设置运行时间与步长
Ax=1;	%x方向上振幅
Ay=1;	%y方向上振幅
wx=1;	%x方向上圆频率
wy=1;	%y方向上圆频率
phix=0;	%x方向上初相位
k=0;	%k为计数作用，在subplot作图时用于确定作图顺序
x=Ax*sin(wx*t+phix);	%x方向上的振动方程
for i=1:5	%第一层for循环，y方向上圆频率从1到5递增，步长为1
    for j=1:5	%第二层for循环，y的初相从0到2π递增，步长为π/4
        y=Ay*sin(wy*i*t+(j-1)*pi/4);	%y方向上的振动方程
        k=k+1;	%每经过一次循环，k值加1，k初始值为0
        subplot(5,5,k)	%分区作图，在第k个分区作图
        plot(x,y)	%作图
        hold on	%保留图形作图
        plot(x(1),y(1),'g+',x(101),y(101),'r*')	%图形第1个点用绿色“+”标记，第101个点用红色“*”标记，可以看出图形走向
        axis([-1 1 -1 1])	%坐标轴范围设置
        axis equal	%坐标轴等长
    end	%内层for循环结束
end	%外层for循环结束
