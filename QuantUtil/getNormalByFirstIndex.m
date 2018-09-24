function [ close ] = getNormalByFirstIndex( code, start_date, end_date )
%UNTITLED7 此处显示有关此函数的摘要
%   此处显示详细说明


url = "E:\data\h5data\index\daybar\byIndex\";
stock = readtable(url+code+".csv" , 'ReadVariableNames', true);

region = find(stock.Date>=start_date):find(stock.Date<=end_date,1,'last');
close = NormalizeByFirst(stock.Close(region));

end

