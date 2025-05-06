// Big Torx Driver Holder

shank1 = 8 / 2 + 0.2;
shank2 = 6 / 2 + 0.2;
shank3 = 6 / 2 + 0.2;
shank4 = 6 / 2 + 0.2;
shank5 = 5 / 2 + 0.2;
shank6 = 5 / 2 + 0.2;

h1 = 33.5 / 2;
h2 = 30 / 2;
h3 = 30 / 2;
h4 = 30 / 2;
h5 = 28 / 2;
h6 = 28 / 2;


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
gridx = 6; //.5
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
lr_buffer = 8;
gamma = 1.3;
my_grid = 42;
block_w = 7;
letter_height = 1.5;
difference() {
    union() {
        gridfinityInit(gridx, gridy, height(gridz, gridz_define, style_lip, enable_zsnap), height_internal, sl=style_lip) {
            cutEqual(n_divx = divx, n_divy = divy, style_tab = style_tab, scoop_weight = scoop, place_tab = place_tab);
        }
        gridfinityBase([gridx, gridy], hole_options=hole_options, only_corners=only_corners, thumbscrew=enable_thumbscrew);

        difference(){
            color("red") translate([0, -3*my_grid/2, 7]) cube([block_w, 3*my_grid, h1]);
            translate([-1, -3*my_grid/2 + lr_buffer + h1/2, 7+h1]) rotate([0, 90, 0]) cylinder(h = block_w + 2, r = shank1, center = false);
            translate([-1, -3*my_grid/2 + lr_buffer + gamma*h1 + h2/2, 7+h2]) rotate([0, 90, 0]) cylinder(h = block_w + 2, r = shank2, center = false);
            translate([-1, -3*my_grid/2 + lr_buffer + gamma*(h1 + h2) + h3/2, 7+h3]) rotate([0, 90, 0]) cylinder(h = block_w + 2, r = shank3, center = false);
            translate([-1, -3*my_grid/2 + lr_buffer + gamma*(h1 + h2 + h3) + h4/2, 7+h4]) rotate([0, 90, 0]) cylinder(h = block_w + 2, r = shank4, center = false);
            translate([-1, -3*my_grid/2 + lr_buffer + gamma*(h1 + h2 + h3 + h4) + h5/2, 7+h5]) rotate([0, 90, 0]) cylinder(h = block_w + 2, r = shank5, center = false);
            translate([-1, -3*my_grid/2 + lr_buffer + gamma*(h1 + h2 + h3 + h4 + h5) + h6/2, 7+h6]) rotate([0, 90, 0]) cylinder(h = block_w + 2, r = shank6, center = false);
            
            translate([-1, -3*my_grid/2 + lr_buffer + gamma*(h1) + h2/2 - shank2, 7+h2]) cube([block_w+2, shank2*2, 5]);
            translate([-1, -3*my_grid/2 + lr_buffer + gamma*(h1 + h2) + h3/2 - shank3, 7+h3]) cube([block_w+2, shank3*2, 5]);
            translate([-1, -3*my_grid/2 + lr_buffer + gamma*(h1 + h2 + h3) + h4/2 - shank4, 7+h4]) cube([block_w+2, shank4*2, 5]);
            translate([-1, -3*my_grid/2 + lr_buffer + gamma*(h1 + h2 + h3 + h4) + h5/2 - shank5, 7+h5]) cube([block_w+2, shank5*2, 5]);
            translate([-1, -3*my_grid/2 + lr_buffer + gamma*(h1 + h2 + h3 + h4 + h5) + h6/2 - shank6, 7+h6]) cube([block_w+2, shank6*2, 5]);
        }
        translate([0.5, -3*my_grid/2 + lr_buffer + h1/2 - 5, 7+h1]) linear_extrude(letter_height, center = false) rotate([0, 0, -90]) text("T40", size=4);
        translate([0.5, -3*my_grid/2 + lr_buffer + gamma*h1 + h2/2 - 5, 7+h1]) linear_extrude(letter_height, center = false) rotate([0, 0, -90]) text("T30", size=4);
        translate([0.5, -3*my_grid/2 + lr_buffer + gamma*(h1 + h2) + h3/2 - 5, 7+h1]) linear_extrude(letter_height, center = false) rotate([0, 0, -90]) text("T27", size=4);
        translate([0.5, -3*my_grid/2 + lr_buffer + gamma*(h1 + h2 + h3) + h4/2 - 5, 7+h1]) linear_extrude(letter_height, center = false) rotate([0, 0, -90]) text("T25", size=4);
        translate([0.5, -3*my_grid/2 + lr_buffer + gamma*(h1 + h2 + h3 + h4) + h5/2 - 5, 7+h1]) linear_extrude(letter_height, center = false) rotate([0, 0, -90]) text("T20", size=4);
        translate([0.5, -3*my_grid/2 + lr_buffer + gamma*(h1 + h2 + h3 + h4 + h5) + h6/2 - 5, 7+h1]) linear_extrude(letter_height, center = false) rotate([0, 0, -90]) text("T15", size=4);
    }
    translate([-3*my_grid, -3*my_grid/2, 0]) cube([my_grid/3, 3*my_grid, 50]);
    translate([3*my_grid - my_grid/3, -3*my_grid/2, 0]) cube([my_grid/3, 3*my_grid, 50]);
    translate([-my_grid/2, 0, 0]) cylinder(h = 50, r = 14, center = false, $fn = 6);
    translate([-my_grid/2, -my_grid, 0]) cylinder(h = 50, r = 14, center = false, $fn = 6);
    translate([-my_grid/2, my_grid, 0]) cylinder(h = 50, r = 14, center = false, $fn = 6);
    translate([my_grid/2, 0, 0]) cylinder(h = 50, r = 14, center = false, $fn = 6);
    translate([my_grid/2, -my_grid, 0]) cylinder(h = 50, r = 14, center = false, $fn = 6);
    translate([my_grid/2, my_grid, 0]) cylinder(h = 50, r = 14, center = false, $fn = 6);
    //translate([20, -3*my_grid/2 + 10, 0]) cube([my_grid+23, 3*my_grid-20, 50]);
    //translate([-2*my_grid-3, -3*my_grid/2 + 10, 0]) cube([2*my_grid-10, 3*my_grid-20, 50]);
}


