clear;
folder = dir('E:\data\h5data\stock\dayBar\byStock\');

key = {};
min_winrate = [];
max_winrate = [];
k = 1;
for j=1:length(folder)
    code =  folder(j).name;
    if length(code) ~= 10
        continue
    end
    code = string(code(1:6));
%     code = "300296";
    control = "000001";

    start_date = 20180101;
    end_date = 20180921;

    window = 120;
    tradingDay = getTradingDay(20100101, end_date);
    tradingDay = tradingDay(find(tradingDay>=start_date)-window:end);
    %%
    closeA = getNormalByFirstPrice(code,tradingDay(1), end_date);
    if isempty(closeA)
        continue
    end
    closeB = getNormalByFirstIndex(control, tradingDay(1), end_date);
    %%
    if length(closeA) ~= length(closeB)
        fprintf('%s 数据长度有问题\n', code);
        continue
    end
    win_rate = zeros(length(closeA)-window+1,1);
    for i = window:length(tradingDay)
        tmpA = closeA(i-window+1:i);
        tmpB = closeB(i-window+1:i);
        retA = tick2ret(tmpA);
        retB = tick2ret(tmpB);

        win_rate(i-window+1) = 100* sum((retA-retB>0) / length(retA));
        

    end
    key{k} = code;
    min_winrate(k) = min(win_rate);
    max_winrate(k) = max(win_rate);
    fprintf('%s 计算完毕\n', code);
    k=k+1;
end
