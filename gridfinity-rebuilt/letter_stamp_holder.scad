
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
gridx = 2; //.5
// number of bases along y-axis
gridy = 2; //.5
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
}

d = 7.0;
nw = 7;
nl = 4;
spcw = 4.4;
spcl = 11.0;
hh = 25.0;
$fn = 50;
gh = 7.0;
gridw = 42.0;

letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I",
           "J", "K", "L", "M", "N", "O", "P", "Q", "R",
           "S", "T", "U", "V", "W", "X", "Y", "Z", "&", "."];

translate([-gridx/2*gridw, -gridy/2*gridw, gh]) {
    difference() {
        cube([nw*d + (nw + 1)*spcw, nl*d + (nl + 1)*spcl, hh]);
        for (i = [0:(nw - 1)]) {
            for (j = [0:(nl - 1)]) {
                translate([spcw + i*spcw + i*d + d/2.0, 
                           spcl + j*spcl + j*d + d/2.0, spcw])
                    cylinder(h = hh, r = d/2.0, center = false);
            }
        }
    }

    ii = 0;
    for (i = [0:(nw - 1)]) {
        for (j = [0:(nl - 1)]) {
            translate([-0.5 + i*spcw + i*d + d/2.0, 
                       1.5 + j*spcl + j*d, spcw])
            color("red") 
            linear_extrude(height = hh + 1) 
            text(letters[i + j*nw], size = 8);
        }
    }
}
