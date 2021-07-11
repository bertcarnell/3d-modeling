$fn = 50.0;

rad = 18.5 / 2;

difference() {
    union() {
        difference() {
            cylinder(h = rad + 3.0, r = rad + 3.0, center = true);
            cylinder(h = 30, r = rad, center = true);
        }
        translate([rad + 1.0, -3, -(rad + 3.0) / 2]){
            cube([40.0, 6.0, rad + 3.0], center = false);
        }
        translate([50, -2*(rad + 3.0), -(rad + 3.0) / 2]){
            cube([6, 4*(rad + 3.0), rad + 3.0]);
        }
        
    }
    translate([51, -20, 0]) {
        rotate([0, 90, 0]) {
            cylinder(r = 1.5, h = 10, center = true);
        }
    }
    translate([51, 20, 0]) {
        rotate([0, 90, 0]) {
            cylinder(r = 1.5, h = 10, center = true);
        }
    }
}