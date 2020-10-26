clc
clear

global t_j1j2 Tj3e h_bj1
load puma560.mat
load sol.mat

% visual trajectory and planning

[~, num_midp] = size(fsol);

% figure(1);
% x = 0:num_midp-1;
% plot(x, fsol(1,:)*180/pi,'linewidth', 2);
% hold on
% plot(x, fsol(2,:)*180/pi, '--', 'linewidth', 2);
% plot(x, fsol(3,:)*180/pi, '-.', 'linewidth', 2);
% grid on
% legend('q1', 'q2', 'q3');
% 
% % do forward kinematic to see
% cart = zeros(3, num_midp);
% for i = 1:num_midp
%     cart(:,i) = fwkine(fsol(:,i));
% end
% figure(2);
% scatter3(cart(1,:), cart(2,:), cart(3,:), 'filled');


% t start and end
ts = 0.4;
te = 0.4;
% rest of the sections
tr = 0.2;
% begin to planning
total_time = tr * (num_midp + 2);

sum_t = 0;
for i=1:num_midp
    if i == 1 || i == num_midp
        sum_t = sum_t+ts;
    else
        sum_t = sum_t + tr;
    end
    t0(i) = sum_t;
end


tt = 1e-3;
[q1,dq1,ddq1] = cubicSpline_2(fsol(1,:), t0, 0, 0, tt);
[q2,dq2,ddq2] = cubicSpline_2(fsol(2,:), t0, 0, 0, tt);
[q3,dq3,ddq3] = cubicSpline_2(fsol(3,:), t0, 0, 0, tt);

plan.q = [q1;q2;q3];
plan.dq = [dq1;dq2;dq3];
plan.ddq = [ddq1;ddq2;ddq3];

% save plan_traj.mat plan q_init ;

%%
figure(3);
subplot(3,1,1);
plot(tt*(1:length(q1)), q1);
hold on
title('q1');

subplot(3,1,2);
plot(tt*(1:length(q1)), dq1);
hold on
title('dq1');

subplot(3,1,3);
plot(tt*(1:length(q1)), ddq1);
hold on
title('ddq1');

%%
figure(4);
subplot(3,1,1);
plot(tt*(1:length(q2)), q2);
hold on
title('q2');

subplot(3,1,2);
plot(tt*(1:length(q2)), dq2);
hold on
title('dq2');

subplot(3,1,3);
plot(tt*(1:length(q2)), ddq2);
hold on
title('ddq2');

figure(5);
subplot(3,1,1);
plot(tt*(1:length(q3)), q3);
hold on
title('q3');

subplot(3,1,2);
plot(tt*(1:length(q3)), dq3);
hold on
title('dq3');

subplot(3,1,3);
plot(tt*(1:length(q3)), ddq3);
hold on
title('ddq3');
