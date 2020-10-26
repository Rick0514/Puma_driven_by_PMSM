clc
clear
% run this script before activate the simulink model like
% current.slx, revelution.slx and position.slx 
load pmsm.mat

fpwm = 5000;
ts = 2e-6;

% 典1型系统参数
Ts = 2e-4;
Ti = 1e-3;

ksai = 0.707;
Tsigma_i = 1.5*Ts + Ti;
K1 = 0.5 / Tsigma_i;
tao = pmsm.Ld / pmsm.Rs;
Kpi = K1 * tao * pmsm.Rs;
Kii = Kpi / tao;

% 典2型系统参数
Tw = 1e-3;
Tsigma_w = 1/K1 + Tw;
h = 5;
taow = h * Tsigma_w;
K2 = (h+1)/2/h^2/Tsigma_w^2;
Kpw = K2*taow*pmsm.J/(3/2*pmsm.N*pmsm.PM);
Kiw = Kpw / taow;




