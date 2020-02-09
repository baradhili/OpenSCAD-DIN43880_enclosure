/*
   e3DHW project ©2018 Marco Sillano  (marco.sillano@gmail.com)
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU Lesser General Public License as published
   by the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This project is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
   GNU Lesser General Public License for more details.
   
   Designed with: OpenScad 2019.05 http://www.openscad.org/
   Tested with: 3DRAG 1.2 https://www.futurashop.it/3drag-stampante-3d-versione-1.2-in-kit-7350-3dragk
   Documentation extracted by Doxygen 1.8.15 http://www.doxygen.nl/
*/

include <./lib/e3DHW_base_lib.scad>
include <./lib/e3DHW_array_lib.scad>
include <./lib/e3DHW_hardware_data.scad>
include <./lib/e3DHW_addon_base.scad>
include <./lib/e3DHW_DIN_rail_lib.scad>
include <./lib/e3DHW_DIN_boxes_lib.scad>
include <./lib/e3DHW_addon_box.scad>

// This is the DIN container for the project:
module din_DSP4(opt_boxprint,print){
 include <./lib/e3DHW_addon_terminal.scad> //required for this project
// local re-definitions for this project
  _TEXTFONT   ="DejaVu Sans Mono: style=Bold";  // test 
  DEFAULTFILL = 60;
  print_option= print; 
// constats
_hm=10; // 3 half modules = 26.5 mm
   //
    length = get_H(_hm);
        difference(){
            union(){
               simpleDINBox(_hm, width= DINWIDTHS, top = DINHTOP, boxThick = TOPTHICKNESS, lidStyle = LSIN, bottomFill=DEFAULTFILL, uclip = xauto, leftless=-8, print=print_option, OPTION_BOXPRINT = opt_boxprint);
               if(bitwise_and(print_option,PRINTBOX,bv=1)){
                    // here addons
                    // box for Sonoff
                    add_polyBox(sonoffBasicVertex,3, x=-6.5, y=2.5);
                    // 2 x 3 mammuts for 110/220 V AC (IN/OUT)
                    add_cubeMammut(3, 2, length-BOARDTHICKNESS, type =HT, x=84, y=30);
                    add_cubeMammut(3, 2, length-BOARDTHICKNESS, type =HT, x=93, y=2);
                    // decoration
                    add_text("MSDSP4", 5,  x=29, y=56);
                    }
               }
         if(bitwise_and(print_option,PRINTBOX,bv=1)){
            // here carving things
            // front switch
            translate([85/2-5,65,length/2])carve_elongatedHoleBorder(12, 2, rot=[90,0,90]);
            // ventilation
            carve_elongatedHoleBorder(2,length-12, h=length, x= -5 , y= 30 ,rot=[0,0,45]);
            carve_elongatedHoleBorder(2,length-12, h=length, x= 62 , y= 53,rot=[0,0,135]);
            // 2 mammuts re-carving:
            carve_cubeMammut(3, 2, length, type =HT, x=84, y=30);
            carve_cubeMammut(3, 2, length, type =HT, x=93, y=2);
            // dymo  labels
            translate([87.2,16,-10])carve_dymoD1_9(45, rot = [0,-90,0]);
            translate([76,45.1,-10])carve_dymoD1_9(45, rot = [0,-90,90]);
            
             
         }
    } //end difference
}

module printHPCB(){
    projection(cut=true)
        rotate([90,0,0])translate([0,-10,0]){
            din_DSP4(opt_boxprint=false, print=PRINTBOX + PRINTLID);
        }
}
module printVPCB(){
    projection(cut=true)
        translate([0,0,-10]){
            din_DSP4(opt_boxprint=false, print=PRINTBOX);
        }
}

module printZPCB(){
    projection(cut=true)
       translate([0,0,45])rotate([0,90,0]){
            din_DSP4(opt_boxprint=false, print=PRINTBOX + PRINTLID);
        }
}

module printbox(){
    din_DSP4(opt_boxprint=true, print=PRINTBOX);
}

module printlid(){
    rotate([0,180,0]){
        din_DSP4(opt_boxprint=true, print=PRINTLID);
    }
}
//din_DSP4(opt_boxprint=true, print=PRINTBOX + PRINTLID + PRINTHPCB);

printZPCB();

    
