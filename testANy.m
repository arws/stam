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
% 最小一乘
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
% 最小二乘
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
legend('最小一乘', '最小二乘', '45度线','散点图')
subplot(2,1,2)
scatter(retA, retB - retA * x(2) + x(1));
grid on
%%
d = retA-retB;
fprintf('45度线以下比例:%5.2f%%\n', 100* sum((retA-retB>0) / length(retA)))
fprintf('上涨强势比例:%5.2f%%, 超额:%6.5f%% \n',  100 *sum((d>0) & (retB>0)) / sum(retB>0), 100* mean(d(retB>0)))
fprintf('下跌强势比例:%5.2f%%, 超额:%6.5f%% \n', 100 * sum((d>0) & (retB<0)) / sum(retB<0), 100* mean(d(retB<0)))
fprintf('B上涨比例:%5.2f%%\n', 100 * sum(retB>0) / length(retB))
fprintf('B上涨天数:%d,下跌天数:%d,共%d天\n',sum(retB>0), sum(retB<0), length(retB))
%%
