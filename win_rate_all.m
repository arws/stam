clear;
folder = dir('D:\data\h5data\stock\dayBar\byStock\');
start_date = 20170420;
end_date = 20170906;
window = 100;
tradingDay = getTradingDay(20100101, end_date);
tradingDay = tradingDay(find(tradingDay>=start_date)-window+1:end);

key = {};
min_winrate = [];
max_winrate = [];
k = 1;
win_rate = zeros(length(tradingDay)-window+1,length(folder));
win_earn = zeros(length(tradingDay)-window+1,length(folder));
win_up = zeros(length(tradingDay)-window+1,length(folder));
win_down = zeros(length(tradingDay)-window+1,length(folder));
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
        win_up(i-window+1, k) = 100* sum((d>0) & (retB>0)) / sum(retB>0);
        win_down(i-window+1, k) = 100 * sum((d>0) & retB<0) / sum(retB<0);
        
        earn(i-window+1,k) = mean(d);
        win_earn(i-window+1,k) = mean(d(retB>0));
        lost_earn(i-window+1,k) = mean(d(retB<0));
    end
    key{k} = code;
    min_winrate(k) = min(win_rate(:, k));
    max_winrate(k) = max(win_rate(:, k));
    fprintf('%s 计算完毕\n', code);
    k=k+1;
end
%%

% for i =1 :size(win_rate,1)
%     histogram(win_rate(i,:), [30:0.5:65]);
%     pause(0.5)
% end

%%
key = cell2table(key','VariableNames',{'Symbol'});

earn = earn(:,1:k-1);
win_earn = win_earn(:,1:k-1);
lost_earn = lost_earn(:,1:k-1);

win_rate = win_rate(:,1:k-1);
win_down = win_down(:,1:k-1);
win_up = win_up(:,1:k-1);
%%

%%
sorted = zeros(size(win_rate,1), size(win_rate,2));

for i=1:size(win_rate,1)
    [B,I] = sort(earn(i,:),'ascend');
%     [C,D] = sort(lost_earn(i,:));
%     [E,F] = sort(I+D);
    sorted(i,:) = I;
end
%%
inter = sorted(1,2100:end);
for i=2:size(sorted,1)
     inter = intersect(sorted(i,2100:end), inter);
end