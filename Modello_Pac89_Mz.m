function [Mz_pac,B,C,D,E,BCD]=Modello_Pac89_Mz(x,Fz,gamma,alfa)

C=x(1);                             % Shape factor
D=(x(2)*Fz.^2+x(3)*Fz);             % Peak factor
BCD=(x(4)*Fz.^2+x(5)*Fz).*(1-x(7)*abs(gamma)).*exp(-x(6)*Fz);
B=BCD./(C*D);                       % Stiffness factor
Sh=x(12)*gamma+x(13)*Fz+x(14);      % Horizontal shift
Sv=(x(15)*Fz.^2+x(16)*Fz).*gamma+x(17)*Fz+x(18);    % Vertical shift
X1=alfa+Sh;                         % Composite
E=(x(8)*Fz.^2+x(9)*Fz+x(10)).*(1-x(11)*abs(gamma)); % Curvature factor

Mz_pac = (D.*sin(C.*atan(B.*X1-E.*(B.*X1-atan(B.*X1)))))+Sv;
end