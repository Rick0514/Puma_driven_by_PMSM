% ����������ָ����ʼ�ٶ�v0����ֹ�ٶ�vn�������м���ٶ�δ֪
% Input��
%   q���������λ��
%   t��������λ�ö�Ӧ��ʱ��
%   v0����ʼ�ٶ�
%   vn����ֹ�ٶ�
%   tt���岹����
% Output��
%   yy dyy ddyy���������ߺ���ֵ���ٶȡ����ٶ�ֵ
function [yy, dyy, ddyy] = cubicSpline_2(q, t, v0, vn, tt)
if length(q) ~= length(t)
    error('���������Ӧ�ɶ�');
end
n = length(q);
c = zeros(n-2, 1);
% ����A�Ǹ�(n-2)*(n-2)�ĶԽ�ռ�ž���
A = zeros(n-2);
for i = 1: n-2
    Tk_1 = t(i+2) - t(i+1);
    Tk = t(i+1) - t(i);
    if i == 1
        A(i, i) = 2*(Tk + Tk_1);
        A(i, i+1) = Tk;
        c(i, 1) = (3/(Tk*Tk_1))*(Tk^2*(q(i+2)-q(i+1))+Tk_1^2*(q(i+1)-q(i))) - Tk_1*v0;
    elseif i == n-2
        A(i, i-1) = Tk_1;
        A(i, i) = 2*(Tk + Tk_1);
        c(i, 1) = (3/(Tk*Tk_1))*(Tk^2*(q(i+2)-q(i+1))+Tk_1^2*(q(i+1)-q(i))) - Tk*vn;
    else
        A(i, i-1) = Tk_1;
        A(i, i) = 2*(Tk + Tk_1);
        A(i, i+1) = Tk;
        c(i, 1) = (3/(Tk*Tk_1))*(Tk^2*(q(i+2)-q(i+1))+Tk_1^2*(q(i+1)-q(i)));
        
    end
end
% ������������õ��Խ�ռ�ž���A��c
% vk = A \ c; % ��һ��matlab���������Ӧ����׷�Ϸ���vk
for i = 1: n-2
    a(i) = A(i, i); % �Խ���
    if i == n-3
        b(i) = A(i, i+1); % �ϱ�
        d(i) = A(i+1, i); % �±�
        continue;
    elseif i < n-2
        b(i) = A(i, i+1); % �ϱ�
        d(i) = A(i+1, i); % �±�
    end
end
[~, ~, vk] = crout(a, b, d, c); % ׷�Ϸ�

% �õ��м�岹����ٶ�vk��Ȼ�����cubicSpline_1����
v_ = [v0, vk, vn];
[yy, dyy, ddyy] = cubicSpline_1(q, t, v_, tt);

end