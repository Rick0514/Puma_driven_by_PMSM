% test dynamic
clc
clear

% devide the whole dynamic equation into M,V,G matrix 
% and test if it is correct

load puma560.mat

m1 = mj1;
m2 = mj2;
m3 = mj3;

Ix1 = Ij1(1);
Iy1 = Ij1(2);
Iz1 = Ij1(3);
Ix2 = Ij2(1);
Iy2 = Ij2(2);
Iz2 = Ij2(3);
Ix3 = Ij3(1);
Iy3 = Ij3(2);
Iz3 = Ij3(3);

p12 = t_j1j2;
p2c = j2c(3);
p3c = j3c(1);
p23x = 0.4318;
p23y = -0.0203;
p23z = -0.0453;

q1 = 0;
dq1 = 0;
ddq1 = 0;
q2 = 0;
dq2 = 0;
ddq2 = 0;
q3 = 0;
dq3 = 0;
ddq3 = 0;

out = test1(g,m1,m2,m3,Ix1,Ix2,Ix3,Iy1,Iy2,Iy3,Iz1,Iz2,Iz3,...
q1,q2,q3,dq1,dq2,dq3,ddq1,ddq2,ddq3,p12,p2c,p3c,p23x,p23y,p23z);

out



function out = test1(g,m1,m2,m3,Ix1,Ix2,Ix3,Iy1,Iy2,Iy3,Iz1,Iz2,Iz3,...
q1,q2,q3,dq1,dq2,dq3,ddq1,ddq2,ddq3,p12,p2c,p3c,p23x,p23y,p23z)

out(1) = (Ix2*ddq1)/2 + (Ix3*ddq1)/2 + (Iy2*ddq1)/2 + (Iy3*ddq1)/2 + Iz1*ddq1 + ddq1*m2*p12^2 + ddq1*m3*p12^2 + (ddq1*m3*p23x^2)/2 + (ddq1*m3*p23y^2)/2 + ddq1*m3*p23z^2 + ddq1*m2*p2c^2 + (ddq1*m3*p3c^2)/2 - (Ix2*ddq1*cos(2*q2))/2 + (Iy2*ddq1*cos(2*q2))/2 + (Ix3*ddq1*cos(2*q2 + 2*q3))/2 - (Iy3*ddq1*cos(2*q2 + 2*q3))/2 - 2*ddq1*m3*p12*p23z - 2*ddq1*m2*p12*p2c + (ddq1*m3*p23x^2*cos(2*q2))/2 - (ddq1*m3*p23y^2*cos(2*q2))/2 - (ddq1*m3*p3c^2*cos(2*q2 + 2*q3))/2 + Ix2*dq1*dq2*sin(2*q2) - Iy2*dq1*dq2*sin(2*q2) - Ix3*dq1*dq2*sin(2*q2 + 2*q3) - Ix3*dq1*dq3*sin(2*q2 + 2*q3) + Iy3*dq1*dq2*sin(2*q2 + 2*q3) + Iy3*dq1*dq3*sin(2*q2 + 2*q3) - ddq1*m3*p23y*p3c*cos(2*q2 + q3) - ddq1*m3*p23x*p3c*sin(2*q2 + q3) - dq2^2*m3*p12*p3c*sin(q2 + q3) - dq3^2*m3*p12*p3c*sin(q2 + q3) + dq2^2*m3*p23z*p3c*sin(q2 + q3) + dq3^2*m3*p23z*p3c*sin(q2 + q3) + dq2^2*m3*p12*p23x*cos(q2) - dq2^2*m3*p23x*p23z*cos(q2) - ddq1*m3*p23x*p23y*sin(2*q2) - dq2^2*m3*p12*p23y*sin(q2) + dq2^2*m3*p23y*p23z*sin(q2) - dq1*dq2*m3*p23x^2*sin(2*q2) + dq1*dq2*m3*p23y^2*sin(2*q2) + ddq2*m3*p12*p3c*cos(q2 + q3) + ddq3*m3*p12*p3c*cos(q2 + q3) - ddq2*m3*p23z*p3c*cos(q2 + q3) - ddq3*m3*p23z*p3c*cos(q2 + q3) + dq1*dq2*m3*p3c^2*sin(2*q2 + 2*q3) + dq1*dq3*m3*p3c^2*sin(2*q2 + 2*q3) + ddq2*m3*p12*p23y*cos(q2) - ddq2*m3*p23y*p23z*cos(q2) + ddq1*m3*p23y*p3c*cos(q3) + ddq2*m3*p12*p23x*sin(q2) - ddq2*m3*p23x*p23z*sin(q2) - ddq1*m3*p23x*p3c*sin(q3) - 2*dq2*dq3*m3*p12*p3c*sin(q2 + q3) + 2*dq2*dq3*m3*p23z*p3c*sin(q2 + q3) - dq1*dq3*m3*p23x*p3c*cos(q3) - dq1*dq3*m3*p23y*p3c*sin(q3) - 2*dq1*dq2*m3*p23x*p3c*cos(2*q2 + q3) - dq1*dq3*m3*p23x*p3c*cos(2*q2 + q3) + 2*dq1*dq2*m3*p23y*p3c*sin(2*q2 + q3) + dq1*dq3*m3*p23y*p3c*sin(2*q2 + q3) - 2*dq1*dq2*m3*p23x*p23y*cos(2*q2);
out(2) = Iz2*ddq2 + Iz3*ddq2 + Iz3*ddq3 + ddq2*m3*p23x^2 + ddq2*m3*p23y^2 + ddq2*m3*p3c^2 + ddq3*m3*p3c^2 - (Ix2*dq1^2*sin(2*q2))/2 + (Iy2*dq1^2*sin(2*q2))/2 + (Ix3*dq1^2*sin(2*q2 + 2*q3))/2 - (Iy3*dq1^2*sin(2*q2 + 2*q3))/2 - g*m3*p3c*sin(q2 + q3) + g*m3*p23x*cos(q2) - g*m3*p23y*sin(q2) + (dq1^2*m3*p23x^2*sin(2*q2))/2 - (dq1^2*m3*p23y^2*sin(2*q2))/2 - (dq1^2*m3*p3c^2*sin(2*q2 + 2*q3))/2 - dq3^2*m3*p23x*p3c*cos(q3) - dq3^2*m3*p23y*p3c*sin(q3) + dq1^2*m3*p23x*p3c*cos(2*q2 + q3) - dq1^2*m3*p23y*p3c*sin(2*q2 + q3) + dq1^2*m3*p23x*p23y*cos(2*q2) + ddq1*m3*p12*p3c*cos(q2 + q3) - ddq1*m3*p23z*p3c*cos(q2 + q3) + ddq1*m3*p12*p23y*cos(q2) - ddq1*m3*p23y*p23z*cos(q2) + 2*ddq2*m3*p23y*p3c*cos(q3) + ddq3*m3*p23y*p3c*cos(q3) + ddq1*m3*p12*p23x*sin(q2) - ddq1*m3*p23x*p23z*sin(q2) - 2*ddq2*m3*p23x*p3c*sin(q3) - ddq3*m3*p23x*p3c*sin(q3) - 2*dq2*dq3*m3*p23x*p3c*cos(q3) - 2*dq2*dq3*m3*p23y*p3c*sin(q3);
out(3) = Iz3*ddq2 + Iz3*ddq3 + ddq2*m3*p3c^2 + ddq3*m3*p3c^2 + (Ix3*dq1^2*sin(2*q2 + 2*q3))/2 - (Iy3*dq1^2*sin(2*q2 + 2*q3))/2 - g*m3*p3c*sin(q2 + q3) - (dq1^2*m3*p3c^2*sin(2*q2 + 2*q3))/2 + (dq1^2*m3*p23x*p3c*cos(q3))/2 + dq2^2*m3*p23x*p3c*cos(q3) + (dq1^2*m3*p23y*p3c*sin(q3))/2 + dq2^2*m3*p23y*p3c*sin(q3) + (dq1^2*m3*p23x*p3c*cos(2*q2 + q3))/2 - (dq1^2*m3*p23y*p3c*sin(2*q2 + q3))/2 + ddq1*m3*p12*p3c*cos(q2 + q3) - ddq1*m3*p23z*p3c*cos(q2 + q3) + ddq2*m3*p23y*p3c*cos(q3) - ddq2*m3*p23x*p3c*sin(q3);
 
end

function out = testT3(g,m1,m2,m3,Ix1,Ix2,Ix3,Iy1,Iy2,Iy3,Iz1,Iz2,Iz3,...
q1,q2,q3,dq1,dq2,dq3,ddq1,ddq2,ddq3,p12,p2c,p3c,p23x,p23y,p23z)

mp = m3*p3c;
mp2 = m3*p3c^2;

M = [mp*(p12-p23z)*cos(q2 + q3)
    Iz3 + mp2 + mp*(p23y*cos(q3) - p23x*sin(q3))
    Iz3 + mp2];

G = - mp*sin(q2 + q3)*g;

V = dq1^2 * ( (Ix3 - Iy3 - mp2)*sin(2*q2 + 2*q3)/2 + ...
    mp*(p23x*cos(q3)/2 + p23y*sin(q3)/2) + ...
	mp*(p23x*cos(2*q2 + q3)/2 - p23y*sin(2*q2 + q3)/2) ) + ...
 dq2^2 * ( mp*(p23x*cos(q3) + p23y*sin(q3)) );

out = M' * [ddq1;ddq2;ddq3] + G + V; 

end


function out = testT2(g,m1,m2,m3,Ix1,Ix2,Ix3,Iy1,Iy2,Iy3,Iz1,Iz2,Iz3,...
q1,q2,q3,dq1,dq2,dq3,ddq1,ddq2,ddq3,p12,p2c,p3c,p23x,p23y,p23z)

mp = m3*p3c;
mp2 = m3*p3c^2;

M = [m3*p12*p3c*cos(q2 + q3) - m3*p23z*p3c*cos(q2 + q3) + m3*p12*p23y*cos(q2) - m3*p23y*p23z*cos(q2) + m3*p12*p23x*sin(q2) - m3*p23x*p23z*sin(q2) 
    Iz2 + Iz3 + m3*(p23x^2 + p23y^2) + m3*p3c^2 + 2*m3*p23y*p3c*cos(q3) - 2*m3*p23x*p3c*sin(q3)    
    Iz3 + mp2 + m3*p23y*p3c*cos(q3) - m3*p23x*p3c*sin(q3)];

G = - g*m3*p3c*sin(q2 + q3) + g*m3*p23x*cos(q2) - g*m3*p23y*sin(q2);

V = -(Ix2*dq1^2*sin(2*q2))/2 + (Iy2*dq1^2*sin(2*q2))/2 + (Ix3*dq1^2*sin(2*q2 + 2*q3))/2 -...
    (Iy3*dq1^2*sin(2*q2 + 2*q3))/2 + (dq1^2*m3*p23x^2*sin(2*q2))/2 -...
    (dq1^2*m3*p23y^2*sin(2*q2))/2 - (dq1^2*m3*p3c^2*sin(2*q2 + 2*q3))/2 -...
    dq3^2*m3*p23x*p3c*cos(q3) - dq3^2*m3*p23y*p3c*sin(q3) +...
    dq1^2*m3*p23x*p3c*cos(2*q2 + q3) - dq1^2*m3*p23y*p3c*sin(2*q2 + q3) +...
    dq1^2*m3*p23x*p23y*cos(2*q2) - 2*dq2*dq3*m3*p23x*p3c*cos(q3) - 2*dq2*dq3*m3*p23y*p3c*sin(q3);

out = M' * [ddq1;ddq2;ddq3] + V + G;

end

function out = testT1(g,m1,m2,m3,Ix1,Ix2,Ix3,Iy1,Iy2,Iy3,Iz1,Iz2,Iz3,...
q1,q2,q3,dq1,dq2,dq3,ddq1,ddq2,ddq3,p12,p2c,p3c,p23x,p23y,p23z)

M = [Ix2/2 + Ix3/2 + Iy2/2 + Iy3/2 + Iz1 + m2*p12^2 + m3*p12^2 + (m3*p23x^2)/2 + (m3*p23y^2)/2 + m3*p23z^2 + m2*p2c^2 + (m3*p3c^2)/2 - Ix2*cos(2*q2)/2 + Iy2*cos(2*q2)/2 + Ix3*cos(2*q2 + 2*q3)/2 - Iy3*cos(2*q2 + 2*q3)/2 - 2*m3*p12*p23z - 2*m2*p12*p2c + m3*p23x^2*cos(2*q2)/2 - m3*p23y^2*cos(2*q2)/2 - m3*p3c^2*cos(2*q2 + 2*q3)/2- m3*p23y*p3c*cos(2*q2 + q3) - m3*p23x*p3c*sin(2*q2 + q3)- m3*p23x*p23y*sin(2*q2) + m3*p23y*p3c*cos(q3)- m3*p23x*p3c*sin(q3)
    m3*p12*p3c*cos(q2 + q3)- m3*p23z*p3c*cos(q2 + q3)+ m3*p12*p23y*cos(q2) - m3*p23y*p23z*cos(q2) + m3*p12*p23x*sin(q2) - m3*p23x*p23z*sin(q2) 
    m3*(p12-p23z)*p3c*cos(q2 + q3)
    ];

V = Ix2*dq1*dq2*sin(2*q2) - Iy2*dq1*dq2*sin(2*q2) - Ix3*dq1*dq2*sin(2*q2 + 2*q3) -...
    Ix3*dq1*dq3*sin(2*q2 + 2*q3) + Iy3*dq1*dq2*sin(2*q2 + 2*q3) + Iy3*dq1*dq3*sin(2*q2 + 2*q3)-...
    dq2^2*m3*p12*p3c*sin(q2 + q3) - dq3^2*m3*p12*p3c*sin(q2 + q3) +...
    dq2^2*m3*p23z*p3c*sin(q2 + q3) + dq3^2*m3*p23z*p3c*sin(q2 + q3) +...
    dq2^2*m3*p12*p23x*cos(q2) - dq2^2*m3*p23x*p23z*cos(q2) - dq2^2*m3*p12*p23y*sin(q2) +...
    dq2^2*m3*p23y*p23z*sin(q2) - dq1*dq2*m3*p23x^2*sin(2*q2) + dq1*dq2*m3*p23y^2*sin(2*q2) +...
    dq1*dq2*m3*p3c^2*sin(2*q2 + 2*q3) + dq1*dq3*m3*p3c^2*sin(2*q2 + 2*q3) -...
    2*dq2*dq3*m3*p12*p3c*sin(q2 + q3) + 2*dq2*dq3*m3*p23z*p3c*sin(q2 + q3) -...
    dq1*dq3*m3*p23x*p3c*cos(q3) - dq1*dq3*m3*p23y*p3c*sin(q3) -...
    2*dq1*dq2*m3*p23x*p3c*cos(2*q2 + q3) - dq1*dq3*m3*p23x*p3c*cos(2*q2 + q3) +...
    2*dq1*dq2*m3*p23y*p3c*sin(2*q2 + q3) + dq1*dq3*m3*p23y*p3c*sin(2*q2 + q3)  - 2*dq1*dq2*m3*p23x*p23y*cos(2*q2);

out = M' * [ddq1;ddq2;ddq3] + V;
end