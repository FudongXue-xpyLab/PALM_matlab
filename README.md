# PALM_MATLAB

# System requirements

The PALM script was developed using MATLAB (http://www.mathworks.com). The script requires an Nvidia graphics card that supports CUDA version 3.0. The package has been tested on windows 10 Pro systems.

# Run the demo

1) Set the PALM script folder as current folder in MATLAB. 
2) Run script “main.m”. 
3) Click the “tiffs” button on the main interface, and choose the test data in the popup dialog. 
4) Click the “process” button to run the PALM algorithm using the default settings.
5) Expected output would be reconstructed PALM images with four different presentation forms, a “*.txt” file that show the calculated mean and median photon number, mean and median localization precision, mean sigma and mean background, a “*_position.txt” file that show the position information of each single molecule, three “Microsoft Access Table Shortcut” files that show the Fitting, Reconstruction and Tracking results.
6) Expected run time for demo on a "normal" desktop computer is about 20 minutes.

The test datasets can be download from the link: https://drive.google.com/file/d/1kIt4xNVQ6BE5cMfUmZ4pUw2M-kDKZ4-t/view?usp=sharing

# Run PALM with custom settings

1) Set the PALM script folder as current folder in MATLAB.
2) Run script “main.m”. 
3) Click the “file” button on the main interface, and load a file with the “tiff” suffix.
4) Click the “set parameter” button and set the following parameters according to the experimental conditions used: wavelet threshold, EMCCD gain, conversion factor (CCD sensitivity), pixel size, and amplification. 
5) Click the “process” button to run the PALM algorithm.
