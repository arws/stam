function [ result ] = NormalizeByFirst( array )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
if array(1) ~= 0
    result = array / array(1);
else
    msg = 'divide by zero!';
    error(msg);
    result = array;
end

