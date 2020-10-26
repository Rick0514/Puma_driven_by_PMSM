function t = fwdynamic(q,dq,ddq)
% perform forward dynamic
% input q dq ddq
% output torque
global g mj1 mj2 mj3 Ij1 Ij2 Ij3 t_j1j2 j2c j3c


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

p12 = -t_j1j2;
p2c = j2c(3);
p3c = j3c(1);
p23x = 0.4318;
p23y = -0.0203;
p23z = -0.0453;

q1 = q(1); dq1 = dq(1); ddq1 = ddq(1);
q2 = q(2); dq2 = dq(2); ddq2 = ddq(2);
q3 = q(3); dq3 = dq(3); ddq3 = ddq(3);

t(1) = (Ix2*ddq1)/2 + (Ix3*ddq1)/2 + (Iy2*ddq1)/2 + (Iy3*ddq1)/2 + Iz1*ddq1 + ddq1*m2*p12^2 + ddq1*m3*p12^2 + (ddq1*m3*p23x^2)/2 + (ddq1*m3*p23y^2)/2 + ddq1*m3*p23z^2 + ddq1*m2*p2c^2 + (ddq1*m3*p3c^2)/2 - (Ix2*ddq1*cos(2*q2))/2 + (Iy2*ddq1*cos(2*q2))/2 + (Ix3*ddq1*cos(2*q2 + 2*q3))/2 - (Iy3*ddq1*cos(2*q2 + 2*q3))/2 - 2*ddq1*m3*p12*p23z - 2*ddq1*m2*p12*p2c + (ddq1*m3*p23x^2*cos(2*q2))/2 - (ddq1*m3*p23y^2*cos(2*q2))/2 - (ddq1*m3*p3c^2*cos(2*q2 + 2*q3))/2 + Ix2*dq1*dq2*sin(2*q2) - Iy2*dq1*dq2*sin(2*q2) - Ix3*dq1*dq2*sin(2*q2 + 2*q3) - Ix3*dq1*dq3*sin(2*q2 + 2*q3) + Iy3*dq1*dq2*sin(2*q2 + 2*q3) + Iy3*dq1*dq3*sin(2*q2 + 2*q3) - ddq1*m3*p23y*p3c*cos(2*q2 + q3) - ddq1*m3*p23x*p3c*sin(2*q2 + q3) - dq2^2*m3*p12*p3c*sin(q2 + q3) - dq3^2*m3*p12*p3c*sin(q2 + q3) + dq2^2*m3*p23z*p3c*sin(q2 + q3) + dq3^2*m3*p23z*p3c*sin(q2 + q3) + dq2^2*m3*p12*p23x*cos(q2) - dq2^2*m3*p23x*p23z*cos(q2) - ddq1*m3*p23x*p23y*sin(2*q2) - dq2^2*m3*p12*p23y*sin(q2) + dq2^2*m3*p23y*p23z*sin(q2) - dq1*dq2*m3*p23x^2*sin(2*q2) + dq1*dq2*m3*p23y^2*sin(2*q2) + ddq2*m3*p12*p3c*cos(q2 + q3) + ddq3*m3*p12*p3c*cos(q2 + q3) - ddq2*m3*p23z*p3c*cos(q2 + q3) - ddq3*m3*p23z*p3c*cos(q2 + q3) + dq1*dq2*m3*p3c^2*sin(2*q2 + 2*q3) + dq1*dq3*m3*p3c^2*sin(2*q2 + 2*q3) + ddq2*m3*p12*p23y*cos(q2) - ddq2*m3*p23y*p23z*cos(q2) + ddq1*m3*p23y*p3c*cos(q3) + ddq2*m3*p12*p23x*sin(q2) - ddq2*m3*p23x*p23z*sin(q2) - ddq1*m3*p23x*p3c*sin(q3) - 2*dq2*dq3*m3*p12*p3c*sin(q2 + q3) + 2*dq2*dq3*m3*p23z*p3c*sin(q2 + q3) - dq1*dq3*m3*p23x*p3c*cos(q3) - dq1*dq3*m3*p23y*p3c*sin(q3) - 2*dq1*dq2*m3*p23x*p3c*cos(2*q2 + q3) - dq1*dq3*m3*p23x*p3c*cos(2*q2 + q3) + 2*dq1*dq2*m3*p23y*p3c*sin(2*q2 + q3) + dq1*dq3*m3*p23y*p3c*sin(2*q2 + q3) - 2*dq1*dq2*m3*p23x*p23y*cos(2*q2);
t(2) = Iz2*ddq2 + Iz3*ddq2 + Iz3*ddq3 + ddq2*m3*p23x^2 + ddq2*m3*p23y^2 + ddq2*m3*p3c^2 + ddq3*m3*p3c^2 - (Ix2*dq1^2*sin(2*q2))/2 + (Iy2*dq1^2*sin(2*q2))/2 + (Ix3*dq1^2*sin(2*q2 + 2*q3))/2 - (Iy3*dq1^2*sin(2*q2 + 2*q3))/2 - g*m3*p3c*sin(q2 + q3) + g*m3*p23x*cos(q2) - g*m3*p23y*sin(q2) + (dq1^2*m3*p23x^2*sin(2*q2))/2 - (dq1^2*m3*p23y^2*sin(2*q2))/2 - (dq1^2*m3*p3c^2*sin(2*q2 + 2*q3))/2 - dq3^2*m3*p23x*p3c*cos(q3) - dq3^2*m3*p23y*p3c*sin(q3) + dq1^2*m3*p23x*p3c*cos(2*q2 + q3) - dq1^2*m3*p23y*p3c*sin(2*q2 + q3) + dq1^2*m3*p23x*p23y*cos(2*q2) + ddq1*m3*p12*p3c*cos(q2 + q3) - ddq1*m3*p23z*p3c*cos(q2 + q3) + ddq1*m3*p12*p23y*cos(q2) - ddq1*m3*p23y*p23z*cos(q2) + 2*ddq2*m3*p23y*p3c*cos(q3) + ddq3*m3*p23y*p3c*cos(q3) + ddq1*m3*p12*p23x*sin(q2) - ddq1*m3*p23x*p23z*sin(q2) - 2*ddq2*m3*p23x*p3c*sin(q3) - ddq3*m3*p23x*p3c*sin(q3) - 2*dq2*dq3*m3*p23x*p3c*cos(q3) - 2*dq2*dq3*m3*p23y*p3c*sin(q3);
t(3) = Iz3*ddq2 + Iz3*ddq3 + ddq2*m3*p3c^2 + ddq3*m3*p3c^2 + (Ix3*dq1^2*sin(2*q2 + 2*q3))/2 - (Iy3*dq1^2*sin(2*q2 + 2*q3))/2 - g*m3*p3c*sin(q2 + q3) - (dq1^2*m3*p3c^2*sin(2*q2 + 2*q3))/2 + (dq1^2*m3*p23x*p3c*cos(q3))/2 + dq2^2*m3*p23x*p3c*cos(q3) + (dq1^2*m3*p23y*p3c*sin(q3))/2 + dq2^2*m3*p23y*p3c*sin(q3) + (dq1^2*m3*p23x*p3c*cos(2*q2 + q3))/2 - (dq1^2*m3*p23y*p3c*sin(2*q2 + q3))/2 + ddq1*m3*p12*p3c*cos(q2 + q3) - ddq1*m3*p23z*p3c*cos(q2 + q3) + ddq2*m3*p23y*p3c*cos(q3) - ddq2*m3*p23x*p3c*sin(q3);


end