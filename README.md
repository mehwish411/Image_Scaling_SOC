# Image Scaling SOC
This repository contains the design and implementation of a System-on-Chip (SoC) for image scaling, capable of enlarging images while ensuring correctness through verification. The design integrates multiple functional submodules, including boundary computation, area generation, edge detection, and arithmetic operations, to process image data in real time. The system takes pixel intensity values and area parameters as inputs, computes boundary values, and applies edge-detection logic to generate a processed image as the output. ModelSim was utilized for functional verification of the Verilog modules, ensuring accurate operation at each stage, while Quartus Prime facilitated hardware synthesis and resource optimization for FPGA implementation.  
## System Architecture
![image](https://github.com/user-attachments/assets/3f18cd74-0e05-46b6-b16c-b91ab7df6975)
## Modular Design Block Diagram 
The design of the Image Scaling SoC is divided into modular components, enabling easier integration and debugging. The following modules have been developed:  

![image](https://github.com/user-attachments/assets/78941637-2bd5-405b-a94e-9b4aabad550d)  

**AP_design:** Handles pixel processing and coordinates.  
**area_generator:** Calculates interpolation areas.  
**EDGE_CATCH_AREA_TUNE:** The EDGE_CATCH_AREA_TUNE module compares adjacent pixels to detect edges. When an edge is detected, it adjusts the interpolation areas (Amn, Am1n, etc.) to preserve edge sharpness in the scaled image.  
**MULT/division_processor:** Basic arithmetic operations.  
**REG_BANK:** Manages data storage and flow.  
## Maximum Image Size
The design uses 16-bit width for image dimensions and pixel values, so theoretically it can handle images up to 65535x65535 pixels, but practical limitations would depend on the target FPGA/ASIC resources.
#Input Image
