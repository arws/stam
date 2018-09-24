function [ close ] = getNormalByFirstPrice( code , start_date, end_date)
%UNTITLED4 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
url = "E:\data\h5data\stock\dayBar\byStock\";
dividendFile =  'E:\data\static\stock\TushareDividend.csv';
stock = readtable(url+code+".csv" , 'ReadVariableNames', true);
dividend =readtable(dividendFile, 'ReadVariableNames', true);
if code.startsWith('6')
    symbol = code+".sh";
else
    symbol = code+".sz";
end
dividend =  dividend(dividend.Symbol==symbol,:);
RatioAdjustingFactor = dividend.RatioAdjustingFactor(find(dividend.ExdiviDate>=start_date):find(dividend.ExdiviDate<=end_date,1,'last'));

region = find(stock.Date>=start_date):find(stock.Date<=end_date,1,'last');
if isempty(region)
    close =[];
else if length(region) ~= length(RatioAdjustingFactor)
    fprintf('%s close��adjustingfactor���Ȳ�һ��\n',code);
    close = [];
else
    close = NormalizeByFirst(stock.Close(region) .* RatioAdjustingFactor);
end
end
