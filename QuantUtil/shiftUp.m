function [ result ] = shiftUp( data, N )
%��data����N��
%   data matrix
%   N int ���Ƽ���
result = nan(size(data,1), size(data,2));
if(N<size(data,1))
    result(1:end-N,:) = data(N+1:end, :);

end
