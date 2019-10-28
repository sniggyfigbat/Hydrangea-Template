# Hydrangea: V-REP C++ Client Template
A simple template to set up a Visual Studio project to use as a client for a V-REP simulation. Uses Premake, comes with SFML, spdlog, dOxygen already bundled.
*By Stefan C Bauer.*

## Installation:
1. Clone this branch onto your local machine, using the following command on the command line, in the directory in which your project should be placed:
    `git clone --recurse-submodules https://github.com/sniggyfigbat/Hydrangea-Template.git Hydrangea-Template`
2. Run the `buildVS2017Projects.bat` batch file, which will use premake to create a Visual Studio solution.
3. Open the solution, run the main function with V-REP open and running, check everything works.