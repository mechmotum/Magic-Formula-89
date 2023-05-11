% % % This script generates the parameters for Pacejka 89 model, both for
% lateral force Fy and self-aligning torque Mz. We have 14 parameters for
% lateral force Fy, 18 parameters for self-aligning torque Mz.

% Input: .mat struct of bicycle tyre data (from "Bicycle Tyre Data",
% available here G. Dell'Orto, J. K. Moore, G. Mastinu, R. Happee. (2023).
% Bicycle Tyre Data - Lateral Characteristics (Version 1) [Data set].
% Zenodo. https://doi.org/10.5281/zenodo.7866646)
% 
% Output: .mat struct with Optimal Parameters for Pacejka 89 model
% You can save the Optimal Parameters uncommenting the line


% % % Script calls other functions (add functions to the path)
% 1. Pac89_Fy (called through fminunc, it finds parameters for Fy)
% 2. Pac89_Mz (called through fminunc, it finds parameters for Mz)
% Just for plotting, Pacejka 89 model functions are called:
% 3. Modello_Pac89_Fy
% 4. Modello_Pac89_Mz
% (5.) WriteYaml (just in case you want to convert OptParameter struct from
%      .mat to .yaml. You can find functions and instruction here:
%      https://github.com/ewiger/yamlmatlab.git


clear all
close all
clc

% Load tyre struct to analyze. Change filename every time
load('T11Rigid_camber0_p350.mat')
% load('sch_T04R01_Fz488_camber0_p300.mat')

% If you want to analyze and plot different data sets, use the following
% lines. "datafull" is for plotting only, "data" is for processing.
% If you are not interested in, don't edit the following lines.
datafull = S;
data = S;       % alphaFy [deg], alphaMz [deg], camber_Fy [deg], camber_Mz [deg]...
                %... Fy [N], Mz [Nm], Pressure [kPa], Fz_Fy [N], Fz_Mz [N]

% Define the gamma camber angle and the vertical load of the
% tests. These data are useful for plotting
gammavect = [0];
Fzvect = [340,400,490]/1000;
% Fzvect = [411,449,526]/1000;

% Define initial parameters for Pacejka model
% % % Initial parameters for Fy. From AdamsCar, adapted by Federico Ballo
% (Politecnico di Milano, 2020)

x0_Fy(1)  = 1.1;       % Shape factor Cfy for lateral forces
x0_Fy(2)  = -219 ;     % Lateral friction Muy
x0_Fy(3)  = 1100 ;     % Variation of friction Muy with load
x0_Fy(4)  = 116 ;      % Variation of friction Muy with squared camber
x0_Fy(5)  = 0.75 ;     % Lateral curvature Efy at Fznom
x0_Fy(6)  = 4.7e-4 ;   % Variation of curvature Efy with load
x0_Fy(7)  = 3 ;        % Zero order camber dependency of curvature Efy
x0_Fy(8)  = -2 ;       % Variation of curvature Efy with camber
x0_Fy(9)  = 0.04 ;     % Variation of curvature Efy with camber squared
x0_Fy(10) = 0.4 ;      % Maximum value of stiffness Kfy/Fznom
x0_Fy(11) = 0.06 ;     % Load at which Kfy reaches maximum value
x0_Fy(12) = 23 ;       % Variation of Kfy/Fznom with camber
x0_Fy(13) = -61 ;      % Curvature of stiffness Kfy
x0_Fy(14) = 23;        % Peak stiffness variation with camber squared


% % % Initial parameters for Mz. From AdamsCar, adapted by Federico Ballo
% (Politecnico di Milano, 2020)
%
x0_Mz(1)  = 2.34;
x0_Mz(2)  = 1.495 ; 
x0_Mz(3)  = 6.416654 ; 
x0_Mz(4)  = -3.57403 ; 
x0_Mz(5)  = -0.087737 ;   
x0_Mz(6)  = 0.098410 ;  
x0_Mz(7)  = 0.0027699 ; 
x0_Mz(8)  = -0.0001151 ;    
x0_Mz(9)  = 0.1 ;  
x0_Mz(10) = -1.33329 ;  
x0_Mz(11) = 0.025501 ; 
x0_Mz(12) = -0.02357 ;  
x0_Mz(13) = 0.03027 ; 
x0_Mz(14) = -0.0647 ;       
x0_Mz(15) = 0.0211329 ;
x0_Mz(16) = 0.89469 ;
x0_Mz(17) = -0.099443 ;
x0_Mz(18) = -3.336941 ;

% Convert Fz in kN for processing. Set the options as limit values for
% fminunc. This is repeated both for Fy and Mz
data.Fz = data.Fz_Fy./1000; 
data.camber = data.camber_Fy; 
options=optimset('MaxFunEvals',200000,'MaxIter',200000,'TolF',1e-10,'TolX',1e-10);
[OptParameterMF_Fy,sse_Fy] = fminunc(@(x) Pac89_Fy(x,data),x0_Fy,options);
sse_Fy                  % To check the fitting quality. Higher values mean 
                        % better fitting quality

% Cut the data for Mz parametrization. We are interested in the range +-4
% deg, to avoid numerical issues and have a better quality fitting
data.Fz = data.Fz_Mz./1000; 
data.camber = data.camber_Mz; 
ind_Mz = find(data.alphaMz <= 3 & data.alphaMz >= -3); 

data.alphaMz = data.alphaMz(ind_Mz);
data.Mz = data.Mz(ind_Mz);
data.camber = data.camber(ind_Mz);
data.Fz = data.Fz(ind_Mz);
options=optimset('MaxFunEvals',200000,'MaxIter',200000,'TolF',1e-10,'TolX',1e-10);
[OptParameterMF_Mz,sse_Mz] = fminunc(@(x) Pac89_Mz(x,data),x0_Mz,options);
sse_Mz                  % Fitting quality. Higher values mean better fitting

% % % Collect Optimal Parameters in a single struct
OptParameterMF.OptParameterMF_Fy = OptParameterMF_Fy ;
OptParameterMF.OptParameterMF_Mz = OptParameterMF_Mz ;

% % Change the filename every time. Uncomment if you want to save Opt
% Parameters struct.
% save('OptParameterMF_T11Rigid_camber0_p350','OptParameterMF')

% % Uncomment to convert the OptParameterMF in .yaml format (Note: you need the
% function "WriteYaml" available here" https://github.com/ewiger/yamlmatlab.git )

% yaml.WriteYaml('T04R01_camber5_p300.yaml',S)

%% Plots

%%%% Plot Fy
alfa_Fy = (linspace(-7,7,100))';        % Create the alpha slip angle vector for plotting MF model
testo_leg={};                           % Dynamic update of legenda
figure('color','w')                     % Background 'white' for the figures
for ii=1:length(Fzvect)
    for jj=1:length(gammavect)
        hold on
        Fy_pac=Modello_Pac89_Fy(OptParameterMF_Fy,Fzvect(ii),gammavect(jj),alfa_Fy); % generate fitting curves from Optimal Parameters 
        plot(alfa_Fy,Fy_pac)
        grid on
        testo_leg(end+1)={['F_z=',num2str(Fzvect(ii).*1000),' N, \gamma=',num2str(gammavect(jj)),'°']};
        xlabel '\alpha [deg]'
        ylabel 'F_y [-]'
        legend(testo_leg, 'Location','best')
    end
end
hold on 
title('MF89 Fitting F_y')

% Plot experimental data in the same figure with MF Pacejka fitting curves
plot(datafull.alphaFy, datafull.Fy,'.')
grid on

% How to have origin 0 centered (y-axis symmetric with respect to the
% origin). You can apply the same for x-axis.
limits = max( abs(gca().YLim) );  % take the larger of the two "nice" endpoints
ylim( [-limits, limits] );        % use this nice value for both endpoints

%%%% Plot Mz
alfa_Mz = (linspace(-4,4,100))';        % Create the alpha slip angle vector for plotting MF model
testo_leg={};                           % Dynamic update of legenda
figure('color','w')
for ii=1:length(Fzvect)
    for jj=1:length(gammavect)
        Mz_pac=Modello_Pac89_Mz(OptParameterMF_Mz,Fzvect(ii),gammavect(jj),alfa_Mz); % generate fitting curves from Optimal Parameters
        plot(alfa_Mz,Mz_pac,'-x')
        hold on
        grid on
        testo_leg(end+1)={['M_z=',num2str(Fzvect(ii).*1000),' N, \gamma=',num2str(gammavect(jj)),'°']};
        xlabel '\alpha [deg]'
        ylabel 'M_z [Nm]'
        legend(testo_leg)
    end
end

hold on 
title('MF89 Fitting M_z')

plot(data.alphaMz, data.Mz,'.')
grid on
% xlim([-4,4])
% How to have origin 0 centered (y-axis symmetric with respect to the
% origin). You can apply the same for x-axis.
limits = max( abs(gca().YLim) );  % take the larger of the two "nice" endpoints
ylim( [-limits, limits] );        % use this nice value for both endpoints