function [flag, sol] = inkine(pos)

global t_j1j2 Tj3e h_bj1
px = 0.4318;
py = -0.0203;
pz = -0.0453;

p12 = -t_j1j2;
ex = Tj3e(1,4);
h = h_bj1;

A = 2*ex*sqrt(px^2+py^2);
B = (px^2+py^2+pz^2) + p12^2 + ex^2 - 2*p12*pz;
C = pos(1)^2 + pos(2)^2 + (pos(3)-h)^2;

if (B-A <= C) && (A+B >= C) && (pos(1)^2 + pos(2)^2 >= (p12-pz)^2)
    flag = true;
else
    flag = false;
end

if flag
    k3 = ((px^2 + py^2 + pz^2) + p12^2 + ex^2 - 2*p12*pz -...
            (pos(1)^2 + pos(2)^2 + (pos(3)-h)^2)) / (2*ex*sqrt(px^2 + py^2));
    a3 = atan2(py, px);
    q3(1) = a3 + asin(k3);
    q3(2) = a3 + pi - asin(k3);

    k2 = (pos(3) - h) / sqrt(pos(1)^2 + pos(2)^2 + (pos(3)-h)^2 - (pz-p12)^2);
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
        sol(1,k) = atan2(pos(2)*kx1-pos(1)*ky1, pos(1)*ky2-pos(2)*kx2);
    end
else
    sol = 0;
end

end