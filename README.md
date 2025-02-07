# Image Scaling SOC
This repository contains the design and implementation of a System-on-Chip (SoC) for image scaling, capable of enlarging images while ensuring correctness through verification. The design integrates multiple functional submodules, including boundary computation, area generation, edge detection, and arithmetic operations, to process image data in real time. The system takes pixel intensity values and area parameters as inputs, computes boundary values, and applies edge-detection logic to generate a processed image as the output. ModelSim was utilized for functional verification of the Verilog modules, ensuring accurate operation at each stage, while Quartus Prime facilitated hardware synthesis and resource optimization for FPGA implementation.  

## Modular Design Block Diagram 
The design of the Image Scaling SoC is divided into modular components, enabling easier integration and debugging. The following modules have been developed:  

![bd](https://github.com/user-attachments/assets/17796d55-cccf-411a-aaad-c7b312709387)

## Sub Modules
### AP_design:
Performs arithmetic operations on pixel values and determines boundary conditions for image processing. It takes area parameters (sw, sh, tw, th), coordinates (locx, locy), and a start signal as inputs. The outputs include readiness signals (pixel_rdy, pixel_rdy11) and processed pixel values (pixel_val, pixel_val11). Computes boundaries (left_val, right_val, top_val, bttm_val) based on the size parameters. And **Division processing:** Uses multiple instances of division_processor to divide pixel data and produce results. 
### area_generator: Computes areas (Amn, Am1n, Amn1, Am1n1) using the boundary conditions provided by the AP_design module. It takes top, bottom, left, and right boundary values as inputs. The outputs include the computed areas and a ready signal (out_rdy).Uses multipliers (MULT modules) to calculate areas. For example:  
**Top-Left Area (lt) = Top × Left.**   
**Top-Right Area (tr) = Top × Right.**  
The results are combined to output the four areas.  
### EDGE_CATCH_AREA_TUNE:
Adjusts the area values (Amn, Am1n, etc.) and incorporates edge detection logic for enhanced processing. It takes the original pixel values (imgmn, imgm1n, etc.), area values, and a ready signal as inputs. The outputs include the tuned area values (Amnf, Am1nf, etc.) and the final processed image value (out_img).  
### Division_processor:
Performs 16-bit division iteratively using a shift-subtract method. It takes the dividend, divisor, and a ready signal as inputs. The division process is carried out step by step, where the quotient is updated based on the remainder and the current dividend bit. The outputs include the computed quotient and a ready signal indicating the completion of the division operation.  
### MULT:
Multiplies two 16-bit numbers and produces the product as output. 
###REG_BANK: 
This module stores and forwards the incoming pixel (imgmn, imgm1n, imgmn1, imgm1n1) data to other processing units. The register bank holds pixel data temporarily and passes it forward when ready. It ensures synchronization between input data and downstream processing. 
## System Architecture
![image](https://github.com/user-attachments/assets/3f18cd74-0e05-46b6-b16c-b91ab7df6975)   

##Workflow: 
- Input Handling: Pixel values (imgmn, imgm1n, etc.) are fed into REG_BANK for initial processing. 
- Boundary Computation: AP_design calculates boundary values (left, right, top, bottom) and sends them to area_generator.  
- Area Calculation: area_generator computes area values (Amn, Am1n, etc.) using multipliers. 
###Edge Detection and Adjustment:  
- EDGE_CATCH_AREA_TUNE processes area values and applies edge-detection logic. 
- The resulting image data (out_img) is sent to the output. 
- Final Outputs: Ready signals (pixel_rdy, etc.) and processed values (pixel_val, etc.) are generated.
  
![image](https://github.com/user-attachments/assets/e00963e7-5187-4462-a407-e1100c01b942)

### Maximum Image Size
The design uses 16-bit width for image dimensions and pixel values, so theoretically it can handle images up to 65535x65535 pixels, but practical limitations would depend on the target FPGA/ASIC resources.  

## Simulation Result
![wave](https://github.com/user-attachments/assets/9d604332-c674-47b8-8e1f-c28828401e3e)

## RTL View
![rtl view](https://github.com/user-attachments/assets/5000dac2-f02c-4883-8606-5028e35003ba)

## Input Image
![image](https://github.com/user-attachments/assets/4dd33380-3cee-4633-8af8-c782c280893a)

## Output Image
![image](https://github.com/user-attachments/assets/b6402533-c6b9-42d8-9ed5-5a6d4ea2e9d2)
