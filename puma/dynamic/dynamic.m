clc
clear

load puma560.mat;

% try Newton-Euler iterations
% calulate the torque of each joints

syms g m1 m2 m3 
syms Ix1 Ix2 Ix3 Iy1 Iy2 Iy3 Iz1 Iz2 Iz3  % 各关节转动惯量
syms q1 q2 q3 dq1 dq2 dq3 ddq1 ddq2 ddq3
% p12 关节1到2的距离 p2c关节2到质心距离
syms p12 p2c p3c
% p23 关节2到3距离
syms p23x p23y p23z

v0 = zeros(3,1);
w0 = zeros(3,1);
dv0 = [0;0;g];
dw0 = zeros(3,1);

R12 = round(Rj1j2) * rotm(q2);
tR12 = transpose(R12);
R23 = round(Rj2j3) * rotm(q3);
tR23 = transpose(R23);

w1 = [0;0;dq1];
v1 = zeros(3,1);
dw1 = [0;0;ddq1];
dv1 = [0;0;g];

F1 = [0;0;m1*g];
N1 = [0;0;Iz1*ddq1];

w2 = tR12*w1 + [0;0;dq2];
dw2 = tR12*dw1 + cross(tR12*w1, [0;0;dq2]) + [0;0;ddq2];
P12 = [0;p12;0];
v2 = tR12*cross(w1,P12);
dv2 = tR12*(cross(dw1,P12) + cross(w1, cross(w1, P12)) + dv1);

P2c = [0;0;p2c];
dv2c = cross(dw2,P2c) + cross(w2, cross(w2, P2c)) + dv2;


F2 = m2 * dv2c;
N2 = diag([Ix2 Iy2 Iz2])*dw2 + cross(w2, diag([Ix2 Iy2 Iz2])*w2);

P23 = [p23x;p23y;p23z];
v3 = tR23*(v2 + cross(w2, P23));
w3 = tR23*w2 + [0;0;dq3];
dw3 = tR23*dw2 + cross(tR23*w2, [0;0;dq3]) + [0;0;ddq3];
dv3 = tR23*(cross(dw2,P23) + cross(w2, cross(w2, P23)) + dv2);

P3c = [p3c;0;0];
dv3c = cross(dw3,P3c) + cross(w3, cross(w3, P3c)) + dv3;

F3 = m3 * dv3c;
N3 = diag([Ix3 Iy3 Iz3])*dw3 + cross(w3, diag([Ix3 Iy3 Iz3])*w3);


fe = 0;
ne = 0;

f3 = F3;
n3 = N3 + cross(P3c, F3);
t3 = simplify(n3(3));

f2 = R23 * f3 + F2;
n2 = N2 + R23 * n3 + cross(P2c, F2) + cross(P23, R23*f3);
t2 = simplify(n2(3));

f1 = R12 * f2 + F2;
n1 = N1 + R12 * n2 + cross(P12, R12*f2);
t1 = simplify(n1(3));


function rz = rotm(q)
rz = [cos(q) -sin(q) 0;
    sin(q) cos(q) 0;
    0 0 1];
end
