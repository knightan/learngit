f_source = 1;
Cm = 44;
% T_num = 6;

getCSV_OUT = getCSV(f_source, Cm);
for cnt = 1:T_count
    P(cnt) = power_caculator(getCSV_OUT, cnt);
end
plot(P)