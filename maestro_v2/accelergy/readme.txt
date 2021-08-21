Description:
This program generates the action counts needed for Accelergy to make energy estimations. It is a more accurate way to 
estimate total energy usage than MAESTRO

Usage:
python3 accelergy_converter.py [input_file] [output_file] [arch_file]

Where input_file is the layer-by-layer output generated from MAESTRO, 
output_file is the desired action counts output to be fed into Accelergy,
and arch_file is the Accelergy YAML description of the architecture

Run the program with the given parameters, and then you can feed the output_file into Accelergy to
generate more accurate energy numbers than defualt MAESTRO. That's it! :

You can run python accelergy_converter --help for more info

PLEASE NOTE:
This software is under active development and may lag behind MAESTRO features such as felxible MAESTRO. 
It is forward-compatible though. It makes assumptions that a cycle-accurate trace would not need to make, 
and is therefore not perfect. However, MAESTRO is an estimation software, so this fits its themes. We will 
update our assumptions to be more accurate as we find improvments to be made. 
contact Matthew Denton (matthewdenton@gatech.edu) for more info.