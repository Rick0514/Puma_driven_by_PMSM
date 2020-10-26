clc
clear

global t_j1j2 Tj3e h_bj1

load puma560.mat

% 修改一个关节角度值，运行程序。如果机械臂的末端与一个蓝点正好重合 说明正运动学验证通过
% 把该图作为验证的图
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
ori = [eloc_init(2) eloc_init(3)-r];
% num of middle points
num_midp = 30;

% try another trajectory
xd = ones(1,num_midp) * eloc_init(1);
for i=0:num_midp-1
    yd(i+1) = ori(1) + r * cos(2*pi/num_midp * i + pi/2);
    zd(i+1) = ori(2) + r * sin(2*pi/num_midp * i + pi/2);
end

q = q_init;
%%
figure(1);
% draw base
draw_coordinate(eye(4));
% draw j1
Tbj1_ = Tbj1 * rottrans(q(1));
draw_coordinate(Tbj1);
% draw j2
Tbj2 = Tbj1 * Tj1j2;
Tbj2_ = Tbj1_ * Tj1j2 * rottrans(q(2));
draw_coordinate(Tbj2);
% draw j3
Tbj3 = Tbj2 * Tj2j3;
Tbj3_ = Tbj2_ * Tj2j3 * rottrans(q(3));
draw_coordinate(Tbj3);
% draw e
Tbe = Tbj3 * Tj3e;
Tbe_ = Tbj3_ * Tj3e;
draw_coordinate(Tbe);

all_joints = [zeros(3,1) Tbj1(1:3, 4) Tbj2(1:3, 4) Tbj3(1:3, 4) Tbe(1:3, 4)];
for i = 1:4
    plot3(all_joints(1, i:i+1), all_joints(2, i:i+1), all_joints(3, i:i+1),...
        'k', 'linewidth', 4);
end


% draw base
draw_coordinate(eye(4));
draw_coordinate(Tbj1);
draw_coordinate(Tbj2_);
draw_coordinate(Tbj3_);
draw_coordinate(Tbe);

all_joints = [zeros(3,1) Tbj1_(1:3, 4) Tbj2_(1:3, 4) Tbj3_(1:3, 4) Tbe_(1:3, 4)];
for i = 1:4
    plot3(all_joints(1, i:i+1), all_joints(2, i:i+1), all_joints(3, i:i+1),...
        'c', 'linewidth', 4);
end

eloc = fwkine(q);
eloc
% scatter3(eloc(1), eloc(2), eloc(3), 'filled');
scatter3(xd,yd,zd,'filled');
grid on


function draw_coordinate(trans)

ori = trans(1:3, 4);
dx = trans(1:3, 1);
dy = trans(1:3, 2);
dz = trans(1:3, 3);

ptx = ori + dx * 0.08;
pty = ori + dy * 0.08;
ptz = ori + dz * 0.08;

plot3([ori(1) ptx(1)], [ori(2) ptx(2)], [ori(3) ptx(3)], 'r-.', 'linewidth', 2);
hold on
plot3([ori(1) pty(1)], [ori(2) pty(2)], [ori(3) pty(3)], 'g-.', 'linewidth', 2);
plot3([ori(1) ptz(1)], [ori(2) ptz(2)], [ori(3) ptz(3)], 'b-.', 'linewidth', 2);

end

function t = rottrans(q)

a = [0 0 1 q];
t = axang2tform(a);
end
