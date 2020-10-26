clc
clear

g = 9.8;

% parameters of puma1
% the unit is m

h_bj1 = 0.6718;
% b->j1 trans z h_bj1 m and rotate about
% x axis 90 deg

Tbj1 = [eye(3) [0; 0; h_bj1];
          zeros(1, 3) 1];
      
mj1 = 10;   % kg
Ij1 = [0.05 0.05 0.35];

axang = [1 0 0 pi/2];
rotm = axang2rotm(axang);
t_j1j2 = 0.3 - 0.102;
% j1->j2 trans z t_j1j2 m
Tj1j2 = [rotm [0; -t_j1j2; 0];
            zeros(1, 3), 1];
Rj1j2 = rotm;

mj2 = 17.4;
Ij2 = [0.13 0.524 0.539];
j2c = [0 0 0.025];
Tj2c = [eye(3) j2c';
    zeros(1,3) 1];


% j2->j3 trans to [0.4318 -0.0203 -0.0453]
% and rotate about z axis 90 deg
axang = [0 0 1 pi/2];
rotm = axang2rotm(axang);
Tj2j3 = [rotm [0.4318; -0.0203; -0.0453];
            zeros(1, 3) 1];
Rj2j3 = rotm;
        
j3c = [0.05 0 0];
Tj3c = [eye(3) j3c';
        zeros(1, 3) 1];

mj3 = 4.8;
Ij3 = [66e-3 12.5e-3 86e-3];

% j3->e trans x to 0.361m
% and rotate about y axis 90 deg
axang = [0 1 0 pi/2];
rotm = axang2rotm(axang);
Tj3e = [rotm [0.361; 0; 0];
            zeros(1, 3) 1];

me = 1e-6;

save puma560.mat


        



        