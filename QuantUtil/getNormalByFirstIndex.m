function [ close ] = getNormalByFirstIndex( code, start_date, end_date )
%UNTITLED7 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��


url = "E:\data\h5data\index\daybar\byIndex\";
stock = readtable(url+code+".csv" , 'ReadVariableNames', true);

region = find(stock.Date>=start_date):find(stock.Date<=end_date,1,'last');
close = NormalizeByFirst(stock.Close(region));

end

