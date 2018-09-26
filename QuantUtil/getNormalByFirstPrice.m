function [ close ] = getNormalByFirstPrice( code , start_date, end_date)
%	code string "600000"
%   start_date int 20150101
%   end_date int 20150101
%   此处显示详细说明
url = "D:\data\h5data\stock\dayBar\byStock\";
dividendFile =  "D:\data\static\stock\Tusharedividend\";
stock = readtable(url+code+".csv" , 'ReadVariableNames', true);
if ~exist(dividendFile+code+".csv")
    close = [];
    fprintf('%s dividend file does not exsits\n', code);
    return
end
dividend =readtable(dividendFile+code+".csv", 'ReadVariableNames', true);
if code.startsWith('6')
    symbol = code+".sh";
else
    symbol = code+".sz";
end
dividend =  dividend(dividend.Symbol==symbol,:);
RatioAdjustingFactor = dividend.RatioAdjustingFactor(find(dividend.ExdiviDate>=start_date):find(dividend.ExdiviDate<=end_date,1,'last'));

region = find(stock.Date>=start_date):find(stock.Date<=end_date,1,'last');
if sum(stock.Open(region)==0) > 10
    fprintf('%s %d-%d期间停牌超过十天\n',code, start_date, end_date);
    close = [];
    return
end
if isempty(region)
    close =[];
else if length(region) ~= length(RatioAdjustingFactor)
    fprintf('%s close与adjustingfactor长度不一致\n',code);
    close = [];
else
    close = NormalizeByFirst(stock.Close(region) .* RatioAdjustingFactor);
end
end

