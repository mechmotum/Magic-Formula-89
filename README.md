# Magic-Formula-89
Magic Formula model for lateral force and self-aligning torque
This script generates the parameters for Pacejka 89 model, both for lateral force Fy and self-aligning torque Mz. We have 14 parameters for lateral force Fy, 18 parameters for self-aligning torque Mz.

## Parameters_Pac89.m
### Input: 
.mat struct of bicycle tyre data (from "Bicycle Tyre Data", available here:
G. Dell'Orto, J. K. Moore, G. Mastinu, R. Happee. (2023). Bicycle Tyre Data - Lateral Characteristics (Version 1) [Data set]. Zenodo. https://doi.org/10.5281/zenodo.7866646)
### Output: 
.mat struct with Optimal Parameters for Pacejka 89 model. You can save the Optimal Parameters uncommenting the related lines (you can find all the comments in the script)


% % % Script calls other functions (add functions to the path)
% 1. Pac89_Fy (called through fminunc, it finds parameters for Fy)
% 2. Pac89_Mz (called through fminunc, it finds parameters for Mz)
% Just for plotting, Pacejka 89 model functions are called:
% 3. Modello_Pac89_Fy
% 4. Modello_Pac89_Mz
% (5.) WriteYaml (just in case you want to convert OptParameter struct from
%      .mat to .yaml. You can find functions and instruction here:
%      https://github.com/ewiger/yamlmatlab.git
