function [ result ] = shiftDown( data, N )
%将data下移N行
%   data matrix
%   N int 下移几行
result = nan(size(data,1), size(data,2));
if(N<size(data,1))
    result(N+1:end,:) = data(1:end-N, :);

end

