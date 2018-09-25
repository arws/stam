function [ close ] = getNormalByFirstIndex( code, start_date, end_date )
%	code string "000001"
%   start_date int 20150101
%   end_date int 20150101
%   此处显示详细说明


url = "D:\data\h5data\index\daybar\byIndex\";
stock = readtable(url+code+".csv" , 'ReadVariableNames', true);

region = find(stock.Date>=start_date):find(stock.Date<=end_date,1,'last');
close = NormalizeByFirst(stock.Close(region));

end

