
cube_y = 19.0;
cube_x = 19.0;
cube_z = 22.5;
tube_d1 = 12.8;
tube_d2 = 11.8;
tube_h = 15.9;
nx = 2;
ny = 3;
inset_pin = 3.0;
pin_h = 4;

$fn = 100;

difference() {
    union() {
        for (i = [0 : (nx-1)]) {
            for (j = [0 : (ny-1)]) {
                translate([i*cube_x, j*cube_y, 0]) {
                    difference() {
                        cube([cube_x, cube_y, cube_z], center = false);
                        translate([cube_x/2.0, cube_y/2.0, cube_z - tube_h]) {
                            cylinder(h = tube_h+0.5, r1 = tube_d2/2, r2 = tube_d1/2, center = false);
                        }
                    }
                }
            }
        }
        translate([inset_pin, inset_pin, cube_z]) {
            cylinder(h = pin_h, r = 1.5, center = false);
        }
        translate([nx*cube_x-inset_pin, ny*cube_y-inset_pin, cube_z]) {
            cylinder(h = pin_h, r = 1.5, center = false);
        }
        translate([inset_pin, ny*cube_y-inset_pin, cube_z]) {
            cylinder(h = pin_h, r = 1.5, center = false);
        }
        translate([nx*cube_x-inset_pin, inset_pin, cube_z]) {
            cylinder(h = pin_h, r = 1.5, center = false);
        }
    }
    translate([inset_pin, inset_pin, -0.5]) {
        cylinder(h = pin_h + 1.5, r = 1.6, center = false);
    }
    translate([nx*cube_x-inset_pin, ny*cube_y-inset_pin, -0.5]) {
        cylinder(h = pin_h + 1.5, r = 1.6, center = false);
    }
    translate([inset_pin, ny*cube_y-inset_pin, -0.5]) {
        cylinder(h = pin_h + 1.5, r = 1.6, center = false);
    }
    translate([nx*cube_x-inset_pin, inset_pin, -0.5]) {
        cylinder(h = pin_h + 1.5, r = 1.6, center = false);
    }
}
