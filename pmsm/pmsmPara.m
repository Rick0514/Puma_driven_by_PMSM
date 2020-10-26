clc
clear
% run this script to config the parameters of the PMSM
% save the pmsm basic parameters
pmsm.Imax = 6.9;
pmsm.J = 1e-4;
pmsm.Ld = 8.35e-3;
pmsm.PM = 0.10667;
pmsm.N = 4;
pmsm.Rs = 0.18;
pmsm.nN = 3000;
pmsm.Tmax = 3/2 * pmsm.N * pmsm.PM * pmsm.Imax;
pmsm.gear = 10;

save pmsm.mat pmsm