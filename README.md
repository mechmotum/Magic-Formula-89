# Magic-Formula-89
Magic Formula model for lateral force and self-aligning torque.

## Parameters_Pac89.m
This script generates the parameters for Pacejka 89 model, both for lateral force Fy and self-aligning torque Mz. We have 14 parameters for lateral force Fy, 18 parameters for self-aligning torque Mz.
### Input
.mat struct of bicycle tyre data (from "Bicycle Tyre Data", available here:
G. Dell'Orto, J. K. Moore, G. Mastinu, R. Happee. (2023). Bicycle Tyre Data - Lateral Characteristics (Version 1) [Data set]. Zenodo. https://doi.org/10.5281/zenodo.7866646)
### Output
.mat struct with Optimal Parameters for Pacejka 89 model. You can save the Optimal Parameters uncommenting the related lines (you can find all the comments in the script)

The script calls other functions:
1. Pac89_Fy (called through fminunc, it finds parameters for Fy)
2. Pac89_Mz (called through fminunc, it finds parameters for Mz)
3. Modello_Pac89_Fy
4. Modello_Pac89_Mz

(5.) WriteYaml (just in case you want to convert OptParameter struct from .mat to .yaml. You can find functions and instruction here: https://github.com/ewiger/yamlmatlab.git . If you were not interested in yaml files, please comment the lines in the script

## Plot_Pac89
This script is intended for plotting only. It plots the Magic Formula fitting curves for the selected tyre. 

### Input 
1. .mat struct of Optimal Parameters MF 89, available here: https://doi.org/10.5281/zenodo.7920414   
2. .mat Experimental bicycle tyre data, available here: G. Dell'Orto, J. K. Moore, G. Mastinu, R. Happee. (2023). Bicycle Tyre Data - Lateral Characteristics (Version 1) [Data set]. Zenodo. https://doi.org/10.5281/zenodo.7866646)
### Output 
.mat Figures

Script calls other functions (add functions to the path)
1. Modello_Pac89_Fy (called through fminunc, it finds parameters for Fy)
2. Modello_Pac89_Mz (called through fminunc, it finds parameters for Mz)
