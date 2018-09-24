function [ tradingDay ] = getTradingDay( start_date, end_date )
%UNTITLED5 此处显示有关此函数的摘要
%   此处显示详细说明

file = "E:\data\static\stock\tradingday.csv";
tradingDay = readtable(file,'ReadVariableNames', true);
tradingDay = tradingDay.date(find(tradingDay.date>=start_date):find(tradingDay.date<=end_date,1,'last'));
end

