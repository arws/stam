function [mdd] = MaxDrawdown(list)
%MAXDRAWDOWN �������е����س�
%   �˴���ʾ��ϸ˵��
mdd = 0;
for i = 1 : length(list)-1
    tmpMin = min(list(i+1:end));
    tmpMdd = (max(0, list(i)-tmpMin)) / list(i);
    if tmpMdd > mdd
        mdd = tmpMdd;
    end
end

end

