function [ result ] = NormalizeByFirst( array )
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
if array(1) ~= 0
    result = array / array(1);
else
    msg = 'divide by zero!';
    error(msg);
    result = array;
end

