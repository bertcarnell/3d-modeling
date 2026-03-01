// Big Torx Driver Holder

h1 = 1*2.54*10 / 2;
h2 = 0.75*2.54*10 / 2;
h3 = 1*2.54*10 / 2;
h4 = 1*2.54*10 / 2;
h5 = 0.75*2.54*10 / 2;
h6 = 0.75*2.54*10 / 2;
h7 = 0.625*2.54*10 / 2;

shank1 = 0.25*2.54*10 / 2;
shank2 = 0.25*2.54*10 / 2;
shank3 = 0.25*2.54*10 / 2;
shank4 = 0.25*2.54*10 / 2;
shank5 = 0.25*2.54*10 / 2;
shank6 = 0.25*2.54*10 / 2;
shank7 = 0.25*2.54*10 / 2;

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
gridx = 3; //.5
// number of bases along y-axis
gridy = 4; //.5
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
spacer = 2.3;
my_grid = 42;
block_w = 7;

difference() {
    union() {
        gridfinityInit(gridx, gridy, height(gridz, gridz_define, style_lip, enable_zsnap), height_internal, sl=style_lip) {
            cutEqual(n_divx = divx, n_divy = divy, style_tab = style_tab, scoop_weight = scoop, place_tab = place_tab);
        }
        gridfinityBase([gridx, gridy], hole_options=hole_options, only_corners=only_corners, thumbscrew=enable_thumbscrew);

        difference(){
            color("red") 
                translate([-(gridx-1)/2*my_grid, -gridy/2*my_grid, 7]) 
                cube([block_w, gridy*my_grid, h1]);
            translate([-(gridx-1)/2*my_grid - 1, -gridy/2*my_grid + h1 + spacer, h1 + 7]) 
                rotate([0, 90, 0]) 
                cylinder(h = block_w + 2, r = h1, center = false);
            translate([-(gridx-1)/2*my_grid - 1, -gridy/2*my_grid + 2*h1 + h2 + 2*spacer, h1 + 7]) 
                rotate([0, 90, 0]) 
                cylinder(h = block_w + 2, r = h2, center = false);
            translate([-(gridx-1)/2*my_grid - 1, -gridy/2*my_grid + 2*h1 + 2*h2 + h3 + 3*spacer, h1 + 7]) 
                rotate([0, 90, 0]) 
                cylinder(h = block_w + 2, r = h3, center = false);
            translate([-(gridx-1)/2*my_grid - 1, -gridy/2*my_grid + 2*h1 + 2*h2 + 2*h3 + h4 + 4*spacer, h1 + 7]) 
                rotate([0, 90, 0]) 
                cylinder(h = block_w + 2, r = h4, center = false);
            translate([-(gridx-1)/2*my_grid - 1, -gridy/2*my_grid + 2*h1 + 2*h2 + 2*h3 + 2*h4 + h5 + 5*spacer, h1 + 7]) 
                rotate([0, 90, 0]) 
                cylinder(h = block_w + 2, r = h5, center = false);
            translate([-(gridx-1)/2*my_grid - 1, -gridy/2*my_grid + 2*h1 + 2*h2 + 2*h3 + 2*h4 + 2*h5 + h6 + 6*spacer, h1 + 7]) 
                rotate([0, 90, 0]) 
                cylinder(h = block_w + 2, r = h6, center = false);
            translate([-(gridx-1)/2*my_grid - 1, -gridy/2*my_grid + 2*h1 + 2*h2 + 2*h3 + 2*h4 + 2*h5 + 2*h6 + h7 + 7*spacer, h1 + 7]) 
                rotate([0, 90, 0]) 
                cylinder(h = block_w + 2, r = h7, center = false);
        }

        difference(){
            color("purple") 
                translate([(gridx-1)/2*my_grid, -gridy/2*my_grid, 7]) 
                cube([block_w, gridy*my_grid, h1]);
            translate([(gridx-1)/2*my_grid - 1, -gridy/2*my_grid + h1 + spacer, h1 + 7]) 
                rotate([0, 90, 0]) 
                cylinder(h = block_w + 2, r = shank1, center = false);
            translate([(gridx-1)/2*my_grid - 1, -gridy/2*my_grid + 2*h1 + h2 + 2*spacer, h1 + 7]) 
                rotate([0, 90, 0]) 
                cylinder(h = block_w + 2, r = shank2, center = false);
            translate([(gridx-1)/2*my_grid - 1, -gridy/2*my_grid + 2*h1 + 2*h2 + h3 + 3*spacer, h1 + 7]) 
                rotate([0, 90, 0]) 
                cylinder(h = block_w + 2, r = shank3, center = false);
            translate([(gridx-1)/2*my_grid - 1, -gridy/2*my_grid + 2*h1 + 2*h2 + 2*h3 + h4 + 4*spacer, h1 + 7]) 
                rotate([0, 90, 0]) 
                cylinder(h = block_w + 2, r = shank4, center = false);
            translate([(gridx-1)/2*my_grid - 1, -gridy/2*my_grid + 2*h1 + 2*h2 + 2*h3 + 2*h4 + h5 + 5*spacer, h1 + 7]) 
                rotate([0, 90, 0]) 
                cylinder(h = block_w + 2, r = shank5, center = false);
            translate([(gridx-1)/2*my_grid - 1, -gridy/2*my_grid + 2*h1 + 2*h2 + 2*h3 + 2*h4 + 2*h5 + h6 + 6*spacer, h1 + 7]) 
                rotate([0, 90, 0]) 
                cylinder(h = block_w + 2, r = shank6, center = false);
            translate([(gridx-1)/2*my_grid - 1, -gridy/2*my_grid + 2*h1 + 2*h2 + 2*h3 + 2*h4 + 2*h5 + 2*h6 + h7 + 7*spacer, h1 + 7]) 
                rotate([0, 90, 0]) 
                cylinder(h = block_w + 2, r = shank7, center = false);
        }
    }

    for(i = [0]) {
        for (j = [0:gridy]) {
            translate([-i*my_grid, -(gridy + 1)/2*my_grid + j*my_grid, 0]) 
                cylinder(h = 50, r = 14, center = false, $fn = 6);
        }
    }
}
