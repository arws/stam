function [ result ] = shiftDown( data, N )
%��data����N��
%   data matrix
%   N int ���Ƽ���
result = nan(size(data,1), size(data,2));
if(N<size(data,1))
    result(N+1:end,:) = data(1:end-N, :);

end

