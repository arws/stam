function [ result ] = shiftUp( data, N )
%将data上移N行
%   data matrix
%   N int 上移几行
result = nan(size(data,1), size(data,2));
if(N<size(data,1))
    result(1:end-N,:) = data(N+1:end, :);

end
