function loc = fwkine(q)

global t_j1j2 Tj3e h_bj1

px = 0.4318;
py = -0.0203;
pz = -0.0453;
p12 = -t_j1j2;
ex = Tj3e(1,4);
h = h_bj1;

c1 = cos(q(1));
s1 = sin(q(1));
c2 = cos(q(2));
s2 = sin(q(2));
s23 = sin(q(2)+q(3));
c23 = cos(q(2)+q(3));

loc(1) = px*c1*c2 - py*c1*s2 + pz*s1 - p12*s1 - ex*c1*s23;
loc(2) = px*s1*c2 - py*s1*s2 - pz*c1 + p12*c1 - ex*s1*s23;
loc(3) = h + px*s2 + py*c2 + ex*c23;

end