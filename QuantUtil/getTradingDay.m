function [ tradingDay ] = getTradingDay( start_date, end_date )
%UNTITLED5 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

file = "E:\data\static\stock\tradingday.csv";
tradingDay = readtable(file,'ReadVariableNames', true);
tradingDay = tradingDay.date(find(tradingDay.date>=start_date):find(tradingDay.date<=end_date,1,'last'));
end

