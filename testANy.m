clear;

codeA = "000816";
codeB = "000001";

start_date = 20170420;
end_date = 20170920;

tradingDay = getTradingDay(start_date, end_date);
closeA = getNormalByFirstPrice(codeA, start_date, end_date);
% closeA = getNormalByFirstIndex(codeA, start_date, end_date);
% closeB = getNormalByFirstPrice(codeB, start_date, end_date);
closeB = getNormalByFirstIndex(codeB, start_date, end_date);

%%
subplot(2,1,1)
plot(datetime(string(tradingDay),'InputFormat','yyyyMMdd'),closeA);
hold on
plot(datetime(string(tradingDay),'InputFormat','yyyyMMdd'),closeB)
legend(codeA,codeB)
grid on
%%

subplot(2,1,2)

plot(datetime(string(tradingDay),'InputFormat','yyyyMMdd'),closeA-closeB)
grid on 
%%
retA = tick2ret(closeA);
retB = tick2ret(closeB);
model = fitlm(retA,retB);
% ��Сһ��
T = length(retA);
cvx_begin
    variable x(2)
    minimize(norm(retB-[ones(T,1),retA]*x, 1));
cvx_end
x
x_lim = -0.1:0.01:0.1;
y_lim = x_lim * x(2) + x(1);
figure
subplot(2,1,1)
plot(x_lim', y_lim')
hold on
% ��С����
T = length(retA);
cvx_begin
    variable x(2)
    minimize(norm(retB-[ones(T,1),retA]*x, 2));
cvx_end
x

x_lim = -0.1:0.01:0.1;
y_lim = x_lim * x(2) + x(1);
plot(x_lim', y_lim')


plot(x_lim', x_lim')

scatter(retA,retB)
legend('��Сһ��', '��С����', '45����','ɢ��ͼ')
subplot(2,1,2)
scatter(retA, retB - retA * x(2) + x(1));
grid on
%%
d = retA-retB;
fprintf('45�������±���:%5.2f%%\n', 100* sum((retA-retB>0) / length(retA)))
fprintf('����ǿ�Ʊ���:%5.2f%%, ����:%6.5f%% \n',  100 *sum((d>0) & (retB>0)) / sum(retB>0), 100* mean(d(retB>0)))
fprintf('�µ�ǿ�Ʊ���:%5.2f%%, ����:%6.5f%% \n', 100 * sum((d>0) & (retB<0)) / sum(retB<0), 100* mean(d(retB<0)))
fprintf('B���Ǳ���:%5.2f%%\n', 100 * sum(retB>0) / length(retB))
fprintf('B��������:%d,�µ�����:%d,��%d��\n',sum(retB>0), sum(retB<0), length(retB))
%%
