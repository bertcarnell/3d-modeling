/* https://github.com/cfinke/OpenSCAD-Dovetails */
use <../OpenSCAD-Dovetails/dovetails.scad>

edge_x = 1.5;
edge_y = 1.5;
tube_x = 21.25;
tube_y = 21.25;
tube_z = 4;
cube_y = tube_y + 2*edge_y;
cube_x = tube_x + 2*edge_x;
cube_z = tube_z;
nx = 4;
ny = 5;
x_letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I"];

$fn = 100;

tail_width = 4;
tail_count = 4;
tail_length = 4;
board_width = 2*cube_x;
board_length = 3*2.54*10 + 2*tail_length;
side_board_length = 1.5*2.54*10 + 2*tail_length;
angle = 15;
board_thickness = 4.0;
pin_width = pin_width(tail_width = tail_width, 
                      tail_count=tail_count, 
                      board_width=board_width);

// END BOARDS
color( "orange" ) translate([-60, 0, 0])
board_with_dovetail_tails(
    board_length=board_length,
    board_width=board_width,
    board_thickness=board_thickness,
    tail_length=tail_length,
    tail_width=tail_width,
    pin_width=pin_width,
    tail_count=tail_count,
    angle=angle
);

// SIDE BOARDS
color( "green" ) translate([-120, 0, 0])
board_with_dovetail_tails(
    board_length=side_board_length,
    board_width=board_width,
    board_thickness=board_thickness,
    tail_length=tail_length,
    tail_width=tail_width,
    pin_width=pin_width,
    tail_count=tail_count,
    angle=angle
);

module corner_filet(move_x, move_y) {
    assert(move_x == 1 || move_x == 0)
    assert(move_y == 1 || move_y == 0)
    difference() {
        translate([edge_x + move_x*(tube_x -2*edge_x), 
                   edge_y + move_y*(tube_y - 2*edge_y), 
                   0]) {
            cube([2*edge_x, 2*edge_y, cube_z], center = false);
        }
        translate([3*edge_x + move_x*(tube_x - 4*edge_x), 
                   3*edge_y + move_y*(tube_y - 4*edge_y), 
                   -1]) {
            cylinder(r = 2*edge_x, h = cube_z + 2, center = false);
        }
    }
}

union() {
    // BLOCKS
    for (i = [0 : (nx-1)]) {
        for (j = [0 : (ny-1)]) {
            translate([i*cube_x, j*cube_y, 0]) {
                union() {
                    difference() {
                        color("purple") cube([cube_x, cube_y, cube_z], center = false);
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
            if (i == 0) {
                translate([-2, j*cube_y + 0.5*cube_y - 2, 1]) {
                    color("Green") linear_extrude(cube_z) text(str(j+1), size = 3);
                }
            }
        }
        translate([i*cube_x + 0.5*cube_x - 2, -2, 1]) {
            color("Red") linear_extrude(cube_z) text(x_letters[i], size = 3);
        }
    }
    // BORDERS
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
    color( "orange" ) 
    translate([nx*cube_x/2 - board_width/2, -2*edge_y-tail_width, 0]) {
        dovetail_pins(pin_length=tail_length, 
                      pin_width=pin_width, 
                      pin_thickness=board_thickness, 
                      pin_count=tail_count+1, 
                      angle=angle, 
                      tail_width=tail_width);
    }
    translate([-2*edge_x, 
               -2*edge_y-tail_width, 
               0]) {
        cube([(nx*cube_x + 4*edge_x - board_width)/2, 
               tail_width, 
               cube_z], center = false);
    }
    translate([nx*cube_x/2 + board_width/2, 
               -2*edge_y-tail_width, 
               0]) {
        cube([(nx*cube_x + 4*edge_x - board_width)/2, 
               tail_width, 
               cube_z], center = false);
    }
    color( "orange" ) 
    translate([nx*cube_x/2 - board_width/2, 
               ny*cube_y + 2*edge_y, 
               0]) {
        dovetail_pins(pin_length=tail_length, 
                      pin_width=pin_width, 
                      pin_thickness=board_thickness, 
                      pin_count=tail_count+1, 
                      angle=angle, 
                      tail_width=tail_width);
    }
    translate([-2*edge_x, 
               ny*cube_y + 2*edge_y, 
               0]) {
        cube([(nx*cube_x + 4*edge_x - board_width)/2, 
               tail_width, 
               cube_z], center = false);
    }
    translate([nx*cube_x/2 + board_width/2, 
               ny*cube_y + 2*edge_y, 
               0]) {
        cube([(nx*cube_x + 4*edge_x - board_width)/2, 
               tail_width, 
               cube_z], center = false);
    }
}


translate([nx*cube_x+20, 0, 0]) {
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
        color( "green" ) 
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
        color( "green" ) 
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
}

translate([nx*cube_x + 20 + nx*cube_x + 20, 0, 0]) {
    union() {
        for (i = [0 : (nx-1)]) {
            for (j = [0 : (ny-1)]) {
                translate([i*cube_x, j*cube_y, 0]) {
                    union() {
                        difference() {
                            cube([cube_x, cube_y, cube_z], center = false);
                            translate([edge_x + tube_x / 3, 2*edge_y, -1]) {
                                cube([tube_x / 3, tube_y - 2*edge_y, tube_z + 2], center = false);
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
        color( "orange" ) 
        translate([nx*cube_x/2 - board_width/2 + board_width, 
                   -2*edge_y-tail_width, 
                   tail_length]) 
        rotate([0, 180, 0]) {
            dovetail_pins(pin_length=tail_length, 
                          pin_width=pin_width, 
                          pin_thickness=board_thickness, 
                          pin_count=tail_count+1, 
                          angle=angle, 
                          tail_width=tail_width);
        }
        translate([-2*edge_x, 
                   -2*edge_y-tail_width, 
                   0]) {
            cube([(nx*cube_x + 4*edge_x - board_width)/2, 
                   tail_width, 
                   cube_z], center = false);
        }
        translate([nx*cube_x/2 + board_width/2, 
                   -2*edge_y-tail_width, 
                   0]) {
            cube([(nx*cube_x + 4*edge_x - board_width)/2, 
                   tail_width, 
                   cube_z], center = false);
        }
        color( "orange" ) 
        translate([nx*cube_x/2 - board_width/2 + board_width, 
                   ny*cube_y + 2*edge_y, 
                   tail_length]) 
        rotate([0, 180, 0]){
            dovetail_pins(pin_length=tail_length, 
                          pin_width=pin_width, 
                          pin_thickness=board_thickness, 
                          pin_count=tail_count+1, 
                          angle=angle, 
                          tail_width=tail_width);
        }
        translate([-2*edge_x, 
                   ny*cube_y + 2*edge_y, 
                   0]) {
            cube([(nx*cube_x + 4*edge_x - board_width)/2, 
                   tail_width, 
                   cube_z], center = false);
        }
        translate([nx*cube_x/2 + board_width/2, 
                   ny*cube_y + 2*edge_y, 
                   0]) {
            cube([(nx*cube_x + 4*edge_x - board_width)/2, 
                   tail_width, 
                   cube_z], center = false);
        }
        // DOVETAILS + BORDERS
        color( "green" ) 
        translate([-2*edge_x,  
                   ny*cube_y/2 - board_width/2 + board_width, 
                   tail_length]) 
        rotate([0, 180, 90]) {
            dovetail_pins(pin_length=tail_length, 
                          pin_width=pin_width, 
                          pin_thickness=board_thickness, 
                          pin_count=tail_count+1, 
                          angle=angle, 
                          tail_width=tail_width);
        }
        color( "green" ) 
        translate([nx*cube_x + 2*edge_x + tail_width,
                   ny*cube_y/2 - board_width/2 + board_width, 
                   tail_length]) 
        rotate([0, 180, 90]){
            dovetail_pins(pin_length=tail_length, 
                          pin_width=pin_width, 
                          pin_thickness=board_thickness, 
                          pin_count=tail_count+1, 
                          angle=angle, 
                          tail_width=tail_width);
        }
    }
}
