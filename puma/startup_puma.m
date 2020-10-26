clc
clear

% before startup any of simulink model

load puma560.mat
load plan_traj.mat

% within 3s goto the init point
% 3.5s start the real task
tf = 3;
tb = 3.5;

% save the pmsm basic parameters
pmsm.Imax = 6.9;
pmsm.J = 1e-4;
pmsm.Ld = 1.67e-3/2;
pmsm.PM = 0.10667;
pmsm.N = 4;
pmsm.Rs = 0.18;
pmsm.nN = 3000;
pmsm.Tmax = 3/2 * pmsm.N * pmsm.PM * pmsm.Imax;
pmsm.gear = 10;

fpwm = 5000;
ts = 2e-6;

% 典1型系统参数 -- 电流环
Ts = 2e-4;
Ti = 1e-3;

ksai = 0.707;
Tsigma_i = 1.5*Ts + Ti;
K1 = 0.5 / Tsigma_i;
tao = pmsm.Ld / pmsm.Rs;
Kpi = K1 * tao * pmsm.Rs;
Kii = Kpi / tao;

% 前馈pid
fd_p = 25;
fd_i = 0;
fd_d = 10;

wn = 5;
md_p = wn^2;
md_d = 2*wn;

