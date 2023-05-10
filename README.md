# Magic-Formula-89
Magic Formula model for lateral force and self-aligning torque.

## Parameters_Pac89.m
This script generates the parameters for Pacejka 89 model, both for lateral force Fy and self-aligning torque Mz. We have 14 parameters for lateral force Fy, 18 parameters for self-aligning torque Mz.
### Input
.mat struct of bicycle tyre data (from "Bicycle Tyre Data", available here:
G. Dell'Orto, J. K. Moore, G. Mastinu, R. Happee. (2023). Bicycle Tyre Data - Lateral Characteristics (Version 1) [Data set]. Zenodo. https://doi.org/10.5281/zenodo.7866646)
### Output
.mat struct with Optimal Parameters for Pacejka 89 model. You can save the Optimal Parameters uncommenting the related lines (you can find all the comments in the script)
The Optimal Parameters have been already evaluated and ready-for-use. They are available here: https://doi.org/10.5281/zenodo.7920414

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

# References
Experimental data were measured with a test-rig specific for bicycles tyres (VeTyT: Velo Tyre Testing). Research papers on VeTyT and experimental results are as follows.

1. Dell’Orto, G., Ballo, F. M., Mastinu, G. (2022). Experimental methods to measure the lateral 	
characteristics of bicycle tyres – a review. Vehicle System Dynamics, 1–23. 	https://doi.org/10.1080/00423114.2022.2144388

2. Dell'Orto, G., Ballo, F. M., Mastinu, G., Gobbi, M. (2022). Bicycle tyres – development of a 	
new test-rig to measure mechanical  characteristics. Measurement, 202, 111813. 	https://doi.org/10.1016/j.measurement.2022.111813

3. Dell'Orto, G., & Mastinu, G. (2022). Effect of temperature on the mechanical characteristics of bicycle tyres. In _Proceedings of the 10th International Cycling Safety Conference_ Technische Universität Dresden. https://doi.org/10.25368/2022.473

4. Dell'Orto, G., Ballo, F. M., Mastinu, G., Gobbi, M., Magnani, G. (2023). Racing bicycle tyres – Influence on mechanical characteristics of internal pressure, vertical force, speed and temperature, European Journal of Mechanics - A/Solids, Volume 100, 105010, ISSN 0997-7538, https://doi.org/10.1016/j.euromechsol.2023.105010

References to Pacejka Model can be found here.
- E. Bakker, H. B. Pacejka, and L. Lidner, “A new tire model with an application in vehicle dynamics studies,” SAE Technical Papers, vol. 98, pp. 101–113, 1989, doi: 10.4271/890087
- H. B. Pacejka, Tire and Vehicle Dynamics. 2006. doi: 10.1016/B978-0-7506-6918-4.X5000-X.
- MSC Software, “Introducing Adams/Tire”.
