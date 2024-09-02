
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
inset_pin = 3.0;
pin_h = 4;
x_letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I"];

$fn = 100;

module corner_filet(move_x, move_y) {
    assert(move_x == 1 || move_x == 0)
    assert(move_y == 1 || move_y == 0)
    difference() {
        translate([edge_x + move_x*(tube_x -2*edge_x), edge_y + move_y*(tube_y - 2*edge_y), 0]) {
            cube([2*edge_x, 2*edge_y, cube_z], center = false);
        }
        translate([3*edge_x + move_x*(tube_x - 4*edge_x), 3*edge_y + move_y*(tube_y - 4*edge_y), -1]) {
            cylinder(r=2*edge_x, h = cube_z + 2, center = false);
        }
    }
}

module post_holes(move_x, move_y, move_z) {
    assert(move_x == 1 || move_x == 0)
    assert(move_y == 1 || move_y == 0)
    translate([cube_x/2 - 1 + move_x*(nx*cube_x - 2*cube_x/2), -1.5 + move_y*(ny*cube_y + 1.5), -0.5 + move_z*3]) {
        cube([2, 2, 2.0], center = false);
    }
}

difference() {
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
    }
    post_holes(0,0,0);
    post_holes(0,1,0);
    post_holes(1,0,0);
    post_holes(1,1,0);
}

translate([nx*cube_x+20, 0, 0]) {
    difference() {
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
        }
        post_holes(0,0,0);
        post_holes(0,1,0);
        post_holes(1,0,0);
        post_holes(1,1,0);
        post_holes(0,0,1);
        post_holes(0,1,1);
        post_holes(1,0,1);
        post_holes(1,1,1);
   }
}

translate([nx*cube_x + 20 + nx*cube_x + 20, 0, 0]) {
    difference() {
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
        }
        post_holes(0,0,1);
        post_holes(0,1,1);
        post_holes(1,0,1);
        post_holes(1,1,1);
    }
}

translate([3*(nx*cube_x + 20), 0, 0]) {
    cube([2, 34+1.5+1.5, 2], center = false);
}
