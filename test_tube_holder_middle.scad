/* https://github.com/cfinke/OpenSCAD-Dovetails */
use <../OpenSCAD-Dovetails/dovetails.scad>
include <test_tube_holder_params.scad>

union() {
    for (i = [0 : (nx-1)]) {
        for (j = [0 : (ny-1)]) {
            translate([i*cube_x, j*cube_y, 0]) {
                union() {
                    difference() {
                        cube([cube_x, cube_y, cube_z], center = false);
                        translate([edge_x, edge_y, -1]) {
                            cube([tube_x, tube_y, tube_z + 2], center = false);
                        }
                    }
                    corner_filet(0, 0);
                    corner_filet(0, 1);
                    corner_filet(1, 0);
                    corner_filet(1, 1);
                }
            }
        }
    }
    translate([-2*edge_x, -2*edge_y, 0]) {
        cube([nx*cube_x + 4*edge_x, 2*edge_y, cube_z], center = false);
        cube([2*edge_x, ny*cube_y + 4*edge_y, cube_z], center = false);
    }
    translate([nx*cube_x, 0, 0]) {
        cube([2*edge_x, ny*cube_y + 2*edge_y, cube_z], center = false);
    }
    translate([0, ny*cube_y, 0]) {
        cube([nx*cube_x + 2*edge_x, 2*edge_y, cube_z], center = false);
    }
    // DOVETAILS + BORDERS
    translate([-2*edge_x,  
               ny*cube_y/2 - board_width/2, 
               0]) 
    rotate([0, 0, 90]) {
        dovetail_pins(pin_length=tail_length, 
                      pin_width=pin_width, 
                      pin_thickness=board_thickness, 
                      pin_count=tail_count+1, 
                      angle=angle, 
                      tail_width=tail_width);
    }
    translate([nx*cube_x + 2*edge_x + tail_width,
               ny*cube_y/2 - board_width/2, 
               0]) 
    rotate([0, 0, 90]){
        dovetail_pins(pin_length=tail_length, 
                      pin_width=pin_width, 
                      pin_thickness=board_thickness, 
                      pin_count=tail_count+1, 
                      angle=angle, 
                      tail_width=tail_width);
    }
}
