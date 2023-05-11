% % % This script is intended for plotting only. This script is intended
% for plotting only. It plots the Magic Formula fitting curves for the
% selected tyre.

% Input: 
% 1.    .mat struct of Optimal Parameters MF 89, available here:
%       Gabriele Dell'Orto, Jason Keith Moore, Gianpiero Mastinu, &
%       Riendere Happee. (2023). Magic Formula Parameters - Bicycle Tyres
%       (Version 1) [Data set]. Zenodo.
%       https://doi.org/10.5281/zenodo.7920415
% 2.    .mat Experimental bicycle tyre data, available here:
%       G. Dell'Orto, J. K. Moore, G. Mastinu, R. Happee. (2023).
%       Bicycle Tyre Data - Lateral Characteristics (Version 1) [Data set].
%       Zenodo. https://doi.org/10.5281/zenodo.7866646)
% Output: figures


% % % Script calls other functions (add functions to the path)
% 1. Modello_Pac89_Fy (called through fminunc, it finds parameters for Fy)
% 2. Modello_Pac89_Mz (called through fminunc, it finds parameters for Mz)


clear all
close all
clc

% Load tyre struct to analyze. Change filename as you want to display.
% Please load the OptParameterMF file correspondent to the same tyre 
% experimental dataset
load('T11Rigid_camber0_p350.mat')                   % Load experimental data
load('OptParameterMF_T11Rigid_camber0_p350.mat')    % Load optimal parameters

% If you want to analyze and plot different datasets, use the following
% lines. "datafull" is for plotting only, "data" is for processing.
% If you are not interested in, don't edit the following lines.
datafull = S;   % Corresponds to the experimental data
data = OptParameterMF;       % Corresponds to the optimal parameter set

% Define the gamma camber angle and the vertical load of the
% tests. These data are useful for plotting
gammavect = [0];
Fzvect = [340,400,490]/1000;


OptParameterMF_Fy = OptParameterMF.OptParameterMF_Fy ;
OptParameterMF_Mz = OptParameterMF.OptParameterMF_Mz ;

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
        ylabel 'F_y [N]'
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

% These lines are useful to cut the results from experimental data. You can
% change the limits, or erase them commenting the following lines 
ind_Mz = find(datafull.alphaMz <= 3 & datafull.alphaMz >= -3); 
datafull.alphaMz = datafull.alphaMz(ind_Mz);
datafull.Mz = datafull.Mz(ind_Mz);
% % 
% %
plot(datafull.alphaMz, datafull.Mz,'.')
grid on
% xlim([-4,4])
% How to have origin 0 centered (y-axis symmetric with respect to the
% origin). You can apply the same for x-axis.
limits = max( abs(gca().YLim) );  % take the larger of the two "nice" endpoints
ylim( [-limits, limits] );        % use this nice value for both endpoints