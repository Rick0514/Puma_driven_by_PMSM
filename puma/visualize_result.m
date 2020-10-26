clc
clear

% visualize the feedforward effect
global t_j1j2 Tj3e h_bj1

% the task started at 2.5s
tb = 2.5;

% load ffcon_q.mat

load puma560.mat
load ffcon_q.mat
load bmcon_q.mat
load bmcon_q1.mat
% load  testall.mat

fq = ffq.Data;
tt = ffq.Time;
ft = tt(tt>tb);
fq = fq(tt>tb, :);

% fq1 = ta.Data;
% tt = ta.Time;
% ft1 = tt(tt>tb);
% fq1 = fq1(tt>tb, :);

bq = bmq.Data;
tt = bmq.Time;
bt = tt(tt>tb);
bq = bq(tt>tb, :);

bq1 = bmq1.Data;
tt = bmq1.Time;
bt1 = tt(tt>tb);
bq1 = bq1(tt>tb, :);

fnum = length(ft);
% fnum1 = length(ft1);
bnum = length(bt);
bnum1 = length(bt1);

ferr = zeros(fnum, 1);
% ferr1 = zeros(fnum1, 1);
berr = zeros(bnum, 1);
berr1 = zeros(bnum1, 1);

px = 0.4318;
py = -0.0203;
pz = -0.0453;
p12 = -t_j1j2;
ex = Tj3e(1,4);
h = h_bj1;

% init position
q_init = [0 0 -pi/5]';
eloc_init = fwkine(q_init);
% generate trajectory
r = 0.3;
ori = [eloc_init(1) eloc_init(2) eloc_init(3)-r];

for i=1:fnum
    floc = fwkine(fq(i,:));
    ferr(i) = sqrt(sum((floc - ori).^2)) - r;
end

% for i=1:fnum1
%     floc = fwkine(fq1(i,:));
%     ferr1(i) = sqrt(sum((floc - ori).^2)) - r;
% end

for i=1:bnum
    bloc = fwkine(bq(i,:));
    berr(i) = sqrt(sum((bloc - ori).^2)) - r;
end
% 
for i=1:bnum1
    bloc = fwkine(bq1(i,:));
    berr1(i) = sqrt(sum((bloc - ori).^2)) - r;
end

figure(1);
subplot(1,2,1);
plot((0:bnum-1), berr, 'LineWidth', 2);
grid on
title('Error');
legend('P=5 D=0.1');

subplot(1,2,2);
plot((0:bnum1-1), berr1, 'LineWidth', 2);
grid on
title('Error');
legend('P=25 D=10');

% subplot(1,2,2);
% plot((0:fnum-1), ferr, 'LineWidth', 2);
% grid on
% title('Error');
% legend('非线性前馈');
% 
% subplot(1,2,2);
% plot((0:fnum1-1), ferr1, 'LineWidth', 2);
% grid on
% title('Error');
% legend('集成PMSM');
