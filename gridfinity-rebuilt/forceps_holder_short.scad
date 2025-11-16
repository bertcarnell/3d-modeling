
/*
https://github.com/kennetek/gridfinity-rebuilt-openscad
*/

use <../../gridfinity-rebuilt-openscad/src/core/gridfinity-rebuilt-utility.scad>
use <../../gridfinity-rebuilt-openscad/src/core/gridfinity-rebuilt-holes.scad>

// ===== PARAMETERS ===== //

/* [Setup Parameters] */
$fa = 8;
$fs = 0.25; // .01

/* [General Settings] */
// number of bases along x-axis
gridx = 1; //.5
// number of bases along y-axis
gridy = 3; //.5
// bin height. See bin height information and "gridz_define" below.
gridz = 1; //.1

/* [Linear Compartments] */
// number of X Divisions (set to zero to have solid bin)
divx = 1;
// number of Y Divisions (set to zero to have solid bin)
divy = 1;

/* [Height] */
// determine what the variable "gridz" applies to based on your use case
gridz_define = 0; // [0:gridz is the height of bins in units of 7mm increments - Zack's method,1:gridz is the internal height in millimeters, 2:gridz is the overall external height of the bin in millimeters]
// overrides internal block height of bin (for solid containers). Leave zero for default height. Units: mm
height_internal = 0;
// snap gridz height to nearest 7mm increment
enable_zsnap = false;

/* [Features] */
// the type of tabs
style_tab = 5; //[0:Full,1:Auto,2:Left,3:Center,4:Right,5:None]
// which divisions have tabs
place_tab = 0; // [0:Everywhere-Normal,1:Top-Left Division]
// how should the top lip act
style_lip = 1; //[0: Regular lip, 1:remove lip subtractively, 2: remove lip and retain height]
// scoop weight percentage. 0 disables scoop, 1 is regular scoop. Any real number will scale the scoop.
scoop = 0; //[0:0.1:1]

/* [Base Hole Options] */
// only cut magnet/screw holes at the corners of the bin to save uneccesary print time
only_corners = false;
//Use gridfinity refined hole style. Not compatible with magnet_holes!
refined_holes = false;
// Base will have holes for 6mm Diameter x 2mm high magnets.
magnet_holes = false;
// Base will have holes for M3 screws.
screw_holes = false;
// Magnet holes will have crush ribs to hold the magnet.
crush_ribs = true;
// Magnet/Screw holes will have a chamfer to ease insertion.
chamfer_holes = true;
// Magnet/Screw holes will be printed so supports are not needed.
printable_hole_top = true;
// Enable "gridfinity-refined" thumbscrew hole in the center of each base: https://www.printables.com/model/413761-gridfinity-refined
enable_thumbscrew = false;

hole_options = bundle_hole_options(refined_holes, magnet_holes, screw_holes, crush_ribs, chamfer_holes, printable_hole_top);

// ===== IMPLEMENTATION ===== //
difference() {
    union() {
        gridfinityInit(gridx, gridy, height(gridz, gridz_define, style_lip, enable_zsnap), height_internal, sl=style_lip) {
            cutEqual(n_divx = divx, n_divy = divy, style_tab = style_tab, scoop_weight = scoop, place_tab = place_tab);
        }
        gridfinityBase([gridx, gridy], hole_options=hole_options, only_corners=only_corners, thumbscrew=enable_thumbscrew);
    }
    for (i = [0:2]) {
        for (j = [0:1]) {
            color("red") 
                translate([(i-1)*my_grid, j*my_grid, -1]) 
                    cylinder(h = 10, r = my_grid/3, $fn = 6);
        }
    }
}

//  Tool holders

my_grid = 42.0;
forcep_w = 7.0;
gap = 5.0;

// slant holders
translate([-gridx/2*my_grid, -0.5*my_grid - 3.5, 6]) {
    difference() {
        rotate([90, 0, 0]) linear_extrude(height = my_grid-7)
        difference() {
            square([gridx*my_grid, my_grid]);
            for(i = [0:2]) {
                translate([-gridx/2*my_grid + 7 + (i*3 + 1)*gap, 5, 0]) 
                rotate([0, 0, 45]) {
                    union() {
                        circle(r = forcep_w/2);
                        translate([0, -forcep_w/2, 0]) square([100, forcep_w]);
                    }
                }
            }
            translate([-1.5*my_grid+50, 5, 0]) rotate([0, 0, 45]) {
                union() {
                    circle(r = 7/2);
                    translate([0, -7/2, 0]) square([100, 21]);
                }
            }
        }
        color("purple") 
            rotate([0, 90, 0]) 
            translate([0, -0.5*my_grid + 5, 0]) 
            cylinder(h=200, r = 13);
    }
}
translate([-gridx/2*my_grid+2, -gridy/2*my_grid+0.5, 7])
color("orange")
    cube([gridx*my_grid-4, 3, 10]);
translate([-gridx/2*my_grid+2, -0.5*my_grid-3.5, 7])
color("orange")
    cube([gridx*my_grid-4, 3, 10]);

// long bar of rests
translate([-gridx/2*my_grid-7, 0.5*my_grid, 6]) {
    difference() {
        translate([10,0,0]) cube([gridx*my_grid-3, 5, my_grid/2]);
        for(i = [1:4]) {
            color("red") 
                translate([(i*3+1)*gap+gap, my_grid/2, my_grid/2])
                    rotate([90, 0, 0])
                        cylinder(h = my_grid, r = 6);
        }
    }
}

// short bar of rests
/*
translate([-1.5*my_grid, 1.5*my_grid-5, 6]) {
    difference() {
        translate([10,0,0]) cube([1.5*my_grid-10, 5, my_grid*2/3]);
        for(i = [1:7]) {
            color("blue") 
                translate([(i*3+1)*gap+gap, my_grid-5, my_grid*2/3])
                    rotate([90, 0, 0])
                        cylinder(h = my_grid, r = 6);
        }
    }
}
*/
