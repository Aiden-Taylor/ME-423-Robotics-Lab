function T04 = QArmForwardKinematics(theta1, theta2, theta3, theta4)

% dims in meters
L1 = 0.14;
L2 = 0.35;
L3 = 0.05;
L4 = 0.25;
L5 = 0.15;
beta = atan2(L3,L2);

T04 = [sin(theta1)*sin(theta4) + cos(theta1)*cos(theta2)*cos(theta4)*sin(theta3) + cos(theta1)*cos(theta3)*cos(theta4)*sin(theta2), cos(theta4)*sin(theta1) - cos(theta1)*cos(theta2)*sin(theta3)*sin(theta4) - cos(theta1)*cos(theta3)*sin(theta2)*sin(theta4), cos(theta2 + theta3)*cos(theta1), cos(theta2 + theta3)*cos(theta1)*(L4 + L5) + sin(beta + theta2)*cos(theta1)*sqrt(L2^2 + L3^2); cos(theta2)*cos(theta4)*sin(theta1)*sin(theta3) - cos(theta1)*sin(theta4) + cos(theta3)*cos(theta4)*sin(theta1)*sin(theta2), - cos(theta1)*cos(theta4) - cos(theta2)*sin(theta1)*sin(theta3)*sin(theta4) - cos(theta3)*sin(theta1)*sin(theta2)*sin(theta4), cos(theta2 + theta3)*sin(theta1), sin(beta + theta2)*sin(theta1)*sqrt(L2^2 + L3^2) + cos(theta2 + theta3)*sin(theta1)*(L4 + L5); cos(theta2 + theta3)*cos(theta4), -cos(theta2 + theta3)*sin(theta4), -sin(theta2 + theta3), L1 + cos(beta + theta2)*sqrt(L2^2 + L3^2) - L4*sin(theta2 + theta3) - L5*sin(theta2 + theta3); sym(0), sym(0), sym(0), sym(1)] 
end

