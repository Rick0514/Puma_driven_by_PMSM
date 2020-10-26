% ����������ָ����ʼ�ٶ�v0����ֹ�ٶ�vn�������м�岹����ٶ���֪��������򵥵����
% Input��
%   q���������λ��
%   t��������λ�ö�Ӧ��ʱ��
%   v������������ʼ���м估��ֹ�ٶȵ��ٶ�����
%   tt���岹����
% Output��
%   yy dyy ddyy���������ߺ���ֵ���ٶȡ����ٶ�ֵ
function [yy, dyy, ddyy] = cubicSpline_1(q, t, v, tt)
if length(q) ~= length(t)
    error('���������Ӧ�ɶ�')
end
n = length(q);
T = t(n) - t(1); % ������ʱ��
nn = round(T / tt); % �ܵ���
yy = zeros(1, nn);
dyy = zeros(1, nn);
ddyy = zeros(1, nn);
j = 1;
for i = 1: n-1
    Tk = t(i+1) - t(i);
    a0 = q(i);
    a1 = v(i);
    a2 = (1/Tk) * ((3*(q(i+1)-q(i)))/Tk - 2*v(i) - v(i+1));
    a3 = (1/(Tk*Tk)) * ((2*(q(i)-q(i+1)))/Tk + v(i) + v(i+1));
    
    for tk = t(i): tt: t(i+1)
        if i > 1 && tk == t(i)
            continue
        end
        yy(j) = a0 + a1*(tk-t(i)) + a2*power(tk-t(i), 2) + a3*power(tk-t(i), 3);
        dyy(j) = a1 + 2*a2*(tk-t(i)) + 3*a3*power(tk-t(i), 2);
        ddyy(j) = 2*a2 + 6*a3*(tk-t(i));
        j = j + 1;
    end
end

end