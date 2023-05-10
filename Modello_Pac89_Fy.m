function [Fy_pac,B,C,D,E,BCD]=Modello_Pac89_Fy(x,Fz,gamma,alfa)

C=x(1);                                             % Shape factor
D=(x(2)*Fz.^2+x(3)*Fz);                             % Peak factor
BCD=x(4)*sin(atan(Fz/x(5))*2).*(1-x(6)*abs(gamma));
B=BCD./(C*D);                                       % Stiffness factor
Sh=x(10)*Fz+x(11)+x(9)*gamma;                       % Horizontal shift
Sv=x(12)*Fz.*gamma+x(13)*Fz+x(14);                  % Vertical shift
X1=alfa+Sh;                                         % Composite
E=x(7)*Fz+x(8);                                     % Curvature factor

Fy_pac = (D.*sin(C.*atan(B.*X1-E.*(B.*X1-atan(B.*X1)))))+Sv;
end