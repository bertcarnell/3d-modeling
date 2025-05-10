od_1 = 23.0;
bd_1 = 16.0;
sd_1 = 4.0;
l1 = 83.0;

od_2 = 19.0;
bd_2 = 13.0;
sd_2 = 3.4;
l2 = 73.0;

od_3 = 16;
bd_3 = 10;
sd_3 = 2.6;
l3 = 63;

my_grid = 42;
block_w = 7;

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
gridx = 4; //.5
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
union() {
    gridfinityInit(gridx, gridy, height(gridz, gridz_define, style_lip, enable_zsnap), height_internal, sl=style_lip) {
        cutEqual(n_divx = divx, n_divy = divy, style_tab = style_tab, scoop_weight = scoop, place_tab = place_tab);
    }
    gridfinityBase([gridx, gridy], hole_options=hole_options, only_corners=only_corners, thumbscrew=enable_thumbscrew);

    difference(){
        color("red") 
            translate([-block_w/2 - 1.5*my_grid, -1.5*my_grid, 7]) 
                cube([block_w, gridy*my_grid, od_1/2]);
        /* Flat 1 */
        translate([-block_w/2 - 1.5*my_grid - 1, -1.5*my_grid + gridy*my_grid/7, 7 + od_1/2]) 
            rotate([0, 90, 0]) 
                cylinder(h = block_w + 2, r = bd_1/2);
        /* Flat 2 */
        translate([-block_w/2 - 1.5*my_grid - 1, -1.5*my_grid + gridy*my_grid/7*2.6, 7 + od_1/2]) 
            rotate([0, 90, 0]) 
                cylinder(h = block_w + 2, r = bd_2/2);
        /* Flat 3 */
        translate([-block_w/2 - 1.5*my_grid - 1, -1.5*my_grid + gridy*my_grid/7*4.4, 7 + od_1/2]) 
            rotate([0, 90, 0]) 
                cylinder(h = block_w + 2, r = bd_2/2);
        /* Flat 4 */
        translate([-block_w/2 - 1.5*my_grid - 1, -1.5*my_grid + gridy*my_grid/7*6, 7 + od_1/2]) 
            rotate([0, 90, 0]) 
                cylinder(h = block_w + 2, r = bd_3/2);
                
        /* Phillips 1 */
        translate([-block_w/2 - 1.5*my_grid - 1, -1.5*my_grid + gridy*my_grid/4*3, 7 + od_1/2])
            rotate([0, 90, 0])
                cylinder(h = block_w + 2, r = sd_1/2);
    }
    difference() {
        color("blue")
            translate([-block_w/2 + 1.5*my_grid, -1.5*my_grid, 7]) 
                cube([block_w, gridy*my_grid, od_1/2]);
        /* Phillips 1 */
        translate([-block_w/2 + 1.5*my_grid - 1, -1.5*my_grid + gridy*my_grid/4*3, 7 + od_1/2])
            rotate([0, 90, 0])
                cylinder(h = block_w + 2, r = bd_1/2);
        /* Phillips 2 */
        translate([-block_w/2 + 1.5*my_grid - 1, -1.5*my_grid + gridy*my_grid/4*2, 7 + od_1/2])
            rotate([0, 90, 0])
                cylinder(h = block_w + 2, r = bd_2/2);
        /* Phillips 3 */
        translate([-block_w/2 + 1.5*my_grid - 1, -1.5*my_grid + gridy*my_grid/4, 7 + od_1/2])
            rotate([0, 90, 0])
                cylinder(h = block_w + 2, r = bd_3/2);

        /* Flat 1 */
        translate([-block_w/2 + 1.5*my_grid - 1, -1.5*my_grid + gridy*my_grid/7, 7 + od_1/2]) 
            rotate([0, 90, 0]) 
                cylinder(h = block_w + 2, r = sd_1/2);
    }
    /* Flat 2 */
    difference() {
        color("purple")
            translate([-block_w/2 - 1.5*my_grid + l2 - 7, -1.5*my_grid + gridy*my_grid/7*2.6 - 7/2, 7])
                cube([7, 7, od_1/2]);
        translate([-block_w/2 - 1.5*my_grid + l2 - 7 - 1, -1.5*my_grid + gridy*my_grid/7*2.6, 7 + od_1/2])
            rotate([0, 90, 0])
                cylinder(h = 7 + 2, r = sd_2/2);
    }
    /* Flat 3 */
    difference() {
        color("purple")
            translate([-block_w/2 - 1.5*my_grid + l2 - 7, -1.5*my_grid + gridy*my_grid/7*4.4 - 7/2, 7])
                cube([7, 7, od_1/2]);
        translate([-block_w/2 - 1.5*my_grid + l2 - 7 - 1, -1.5*my_grid + gridy*my_grid/7*4.4, 7 + od_1/2])
            rotate([0, 90, 0])
                cylinder(h = 7 + 2, r = sd_2/2);
    }
    /* Flat 4 */
    difference() {
        color("purple")
            translate([-block_w/2 - 1.5*my_grid + l2 - 7, -1.5*my_grid + gridy*my_grid/7*6 - 7/2, 7])
                cube([7, 7, od_1/2]);
        translate([-block_w/2 - 1.5*my_grid + l2 - 7 - 1, -1.5*my_grid + gridy*my_grid/7*6, 7 + od_1/2])
            rotate([0, 90, 0])
                cylinder(h = 7 + 2, r = sd_2/2);
    }
    /* Phillips 2 */
    difference() {
        color("purple")
            translate([-block_w/2 + 1.5*my_grid - l2 + 7, -1.5*my_grid + gridy*my_grid/4*2 - 7/2, 7])
                cube([7, 7, od_1/2]);
        translate([-block_w/2 + 1.5*my_grid - l2 + 7 - 1, -1.5*my_grid + gridy*my_grid/4*2, 7 + od_1/2])
            rotate([0, 90, 0])
                cylinder(h = 7 + 2, r = sd_2/2);
    }
    /* Phillips 3 */
    difference() {
        color("purple")
            translate([-block_w/2 + 1.5*my_grid - l2 + 7, -1.5*my_grid + gridy*my_grid/4 - 7/2, 7])
                cube([7, 7, od_1/2]);
        translate([-block_w/2 + 1.5*my_grid - l2 + 7 - 1, -1.5*my_grid + gridy*my_grid/4, 7 + od_1/2])
            rotate([0, 90, 0])
                cylinder(h = 7 + 2, r = sd_2/2);
    }
}

