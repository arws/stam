clear;

code = "300296";
control = "000001";

start_date = 20180101;
end_date = 20180921;

window = 120;
tradingDay = getTradingDay(20100101, end_date);
tradingDay = tradingDay(find(tradingDay>=start_date)-window:end);
%%
closeA = getNormalByFirstPrice(code,tradingDay(1), end_date);
closeB = getNormalByFirstIndex(control, tradingDay(1), end_date);
%%
win_rate = zeros(length(closeA)-window+1,1);
for i = window:length(tradingDay)
    tmpA = closeA(i-window+1:i);
    tmpB = closeB(i-window+1:i);
    retA = tick2ret(tmpA);
    retB = tick2ret(tmpB);
   
    win_rate(i-window+1) = 100* sum((retA-retB>0) / length(retA));
    fprintf('%d º∆À„ÕÍ±œ\n', tradingDay(i));
    
end
%%
plot(datetime(string(tradingDay(window:length(tradingDay))),'InputFormat','yyyyMMdd'),win_rate) 
grid on