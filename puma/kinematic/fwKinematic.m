clc
clear

% derive the expression of forward kinematic
load puma560.mat
% 1. perform forward kinematic
syms q1 q2 q3 h p12 p23x p23y p23z ex

Tbj1 = [eye(3)*rotm(q1) [0; 0; h];
          zeros(1, 3) 1];
      
Tj1j2 = [round(Rj1j2)*rotm(q2) [0; p12; 0];
            zeros(1, 3), 1];

Tj2j3 = [round(Rj2j3)*rotm(q3) [p23x;p23y;p23z];
            zeros(1, 3) 1];

pj3e = [ex;0;0;1];

pbe = simplify(Tbj1*Tj1j2*Tj2j3*pj3e);


function rz = rotm(q)
rz = [cos(q) -sin(q) 0;
    sin(q) cos(q) 0;
    0 0 1];
end
