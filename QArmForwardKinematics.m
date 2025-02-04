function T04 = QArmForwardKinematic(theta1, theta2, theta3, theta4)

% dims in meters
L1 = 0.14;
L2 = 0.35;
L3 = 0.05;
L4 = 0.25;
L5 = 0.15;
beta = atan2(L3,L2);

syms theta d a alp 

T = [cos(theta) -sin(theta)*cos(alp) sin(theta)*sin(alp) a*cos(theta);
    sin(theta) cos(theta)*cos(alp) -cos(theta)*sin(alp) a*sin(theta);
    0 sin(alp) cos(alp) d;
    0 0 0 1];

T01 = subs(T, [theta, d, a, alp], [theta1, L1, 0, -pi/2]);

T12 = subs(T, [theta, d, a, alp], [(beta-pi/2)+theta2, 0, sqrt(L2^2 + L3^2), 0]);

T23 = subs(T, [theta, d, a, alp], [-beta+theta3, 0, 0, -pi/2]);

T34 = subs(T, [theta, d, a, alp], [theta4, L4+L5, 0, 0]);

T04 = T01*T12*T23*T34;

end

T04 = simplify(QArmForwardKinematic(0, 0, 0, 0))
