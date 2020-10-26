clc
clear

global t_j1j2 Tj3e h_bj1

load puma560.mat

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

waypoints = [xd' yd' zd'];

% check the conditions

flag = true;
for i=1:num_midp
    j = [xd(i) yd(i) zd(i)];
    flag = check_conditions(j);
    if ~flag
        break;
    end
end

if flag
    
    disp('solutions exist');
    fsol = zeros(3, num_midp);
    for i = 1:num_midp
        % iterate and solve
        k3 = ((px^2 + py^2 + pz^2) + p12^2 + ex^2 - 2*p12*pz -...
            (xd(i)^2 + yd(i)^2 + (zd(i)-h)^2)) / (2*ex*sqrt(px^2 + py^2));
        a3 = atan2(py, px);
        q3(1) = a3 + asin(k3);
        q3(2) = a3 + pi - asin(k3);

        k2 = (zd(i) - h) / sqrt(xd(i)^2 + yd(i)^2 + (zd(i)-h)^2 - (pz-p12)^2);
        sol = zeros(3, 4);
        for k=1:2
            a2 = atan2(py+ex*cos(q3(k)), px-ex*sin(q3(k)));
            sol(3,2*(k-1) + 1) = q3(k);
            sol(3,2*(k-1) + 2) = q3(k);
            sol(2,2*(k-1) + 1) = asin(k2) - a2;
            sol(2,2*(k-1) + 2) = pi - asin(k2) - a2;
        end

        for k = 1:4
            c2 = cos(sol(2,k));
            s2 = sin(sol(2,k));
            s23 = sin(sol(2,k)+sol(3,k));
            kx1 = px*c2-py*s2-ex*s23;
            kx2 = pz-p12;
            ky1 = p12 - pz;
            ky2 = px*c2 - py*s2 - ex*s23;
            sol(1,k) = atan2(yd(i)*kx1-xd(i)*ky1, xd(i)*ky2-yd(i)*kx2);
        end
        
        % select a solution which is closest to the last solution
        % use dist to evaluate the solution
%         if i == 1
%             last_sol = q_init;
%         end
%         dist = zeros(4,1);
%         for k = 1:4
%             sol(:,k) = scale_angle(sol(:,k));
%             dist(k) = sum((sol(:,k) - last_sol).^2);
%         end
%         [~, minid] = min(dist);
        fsol(:,i) = sol(:,1);
%         last_sol = sol(:,minid);
        
    end
    
    save sol.mat fsol
    vis_traj;
    
else
    disp('no solutions');
end


function a = check_conditions(j)
    global t_j1j2 Tj3e h_bj1
    px = 0.4318;
    py = -0.0203;
    pz = -0.0453;

    p12 = -t_j1j2;
    ex = Tj3e(1,4);
    h = h_bj1;
    
    A = 2*ex*sqrt(px^2+py^2);
    B = (px^2+py^2+pz^2) + p12^2 + ex^2 - 2*p12*pz;
    C = j(1)^2 + j(2)^2 + (j(3)-h)^2;
    
    if (B-A <= C) && (A+B >= C) && (j(1)^2 + j(2)^2 >= (p12-pz)^2)
        a = true;
    else
        a = false;
    end
end

function a = scale_angle(an)
    for i = 1:length(an)
        if an(i) > 0
            div = floor((an(i) + pi) / 2 / pi);
            left = an(i) - 2*pi*div;
            a(i) = left - pi;
        else
            div = floor((-an(i) + pi) / 2 / pi);
            left = -an(i) - 2*pi*div;
            a(i) = -(left - pi);
        end
    end
    a = a'; % ensure colume vector
end
