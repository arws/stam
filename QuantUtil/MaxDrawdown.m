function [mdd] = MaxDrawdown(list)
%MAXDRAWDOWN 返回数列的最大回撤
%   此处显示详细说明
mdd = 0;
for i = 1 : length(list)-1
    tmpMin = min(list(i+1:end));
    tmpMdd = (max(0, list(i)-tmpMin)) / list(i);
    if tmpMdd > mdd
        mdd = tmpMdd;
    end
end

end

