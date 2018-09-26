clear;
folder = dir('D:\data\h5data\stock\dayBar\byStock\');
start_date = 20180101;
end_date = 20180920;
window = 120;
tradingDay = getTradingDay(20100101, end_date);
tradingDay = tradingDay(find(tradingDay>=start_date)-window+1:end);

key = {};
min_winrate = [];
max_winrate = [];
k = 1;
win_rate = zeros(length(tradingDay)-window+1,length(folder));
win_earn = zeros(length(tradingDay)-window+1,length(folder));
lost_earn = zeros(length(tradingDay)-window+1,length(folder));
earn = zeros(length(tradingDay)-window+1,length(folder));
for j=1:length(folder)
    code =  folder(j).name;
    if length(code) ~= 10
        continue
    end
    code = string(code(1:6));
%     code = "300296";
    control = "000001";

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
    
    for i = window:length(tradingDay)
        tmpA = closeA(i-window+1:i);
        tmpB = closeB(i-window+1:i);
        retA = tick2ret(tmpA);
        retB = tick2ret(tmpB);
        d = retA-retB;
        
        win_rate(i-window+1, k) = 100* sum((retA-retB>0)) / length(retA);
        earn(i-window+1,k) = mean(d);
        win_earn(i-window+1,k) = mean(d(d>0));
        lost_earn(i-window+1,k) = mean(d(d<0));
    end
    key{k} = code;
    min_winrate(k) = min(win_rate(:, j));
    max_winrate(k) = max(win_rate(:, j));
    fprintf('%s 计算完毕\n', code);
    k=k+1;
end
%%

for i =1 :size(win_rate,1)
    histogram(win_rate(i,:), [30:0.5:65]);
    pause(0.5)
end

%%
win_rate = win_rate(:,1:k-1);
earn = earn(:,1:k-1);
win_earn = win_earn(:,1:k-1);
lost_earn = lost_earn(:,1:k-1);
%%
sorted = zeros(size(win_rate,1), size(win_rate,2));

for i=1:size(win_rate,1)
    [B,I] = sort(earn(i,:));
    sorted(i,:) = I;
end
%%
inter = sorted(1,2000:end);
for i=2:size(sorted,1)
     inter = intersect(sorted(i,2000:end), inter);
end