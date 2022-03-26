x2 = 50.8;
x238 = 60.325;
x35 = 88.9;
x65 = 165.1;
h = 3.0;
spacing = 2.0;
$fn = 50;

translate([0, 0, 0]) {
    difference() {
        union() {
            cube([x35, x65, h], center = false);
            translate([5, 5, 0]) linear_extrude(h + 2.0) text("3.5 x 6.5", size = 6);
        }
        translate([0.8*x35, 0.1*x65, -1]) {
            cylinder(h = 10, r = 3, center = true);
        }
    }
}
translate([x35 + spacing, 0, 0]) {
    difference() {
        union() {
            cube([x35, x35, h], center = false);
            translate([5, 5, 0]) linear_extrude(h + 2.0) text("3.5 x 3.5", size = 6);
        }
        translate([0.8*x35, 0.2*x35, -1]) {
            cylinder(h = 10, r = 3, center = true);
        }
    }
}
translate([x35 + x35 + 2*spacing, 0, 0]) {
    difference() {
        union() {
            cube([x2, x2, h], center = false);
            translate([5, 5, 0]) linear_extrude(h + 2.0) text("2 x 2", size = 6);
        }
        translate([0.8*x2, 0.2*x2, -1]) {
            cylinder(h = 10, r = 3, center = true);
        }
    }
}
translate([x35 + spacing, 95, 0]) {
    difference() {
        union() {
            cube([x35, x2, h], center = false);
            translate([5, 5, 0]) linear_extrude(h + 2.0) text("3.5 x 2", size = 6);
        }
        translate([0.8*x35, 0.2*x2, -1]) {
            cylinder(h = 10, r = 3, center = true);
        }
    }
}
translate([x35 + x35 + 2*spacing, 95, 0]) {
    difference() {
        union() {
            cube([x238, x238, h], center = false);
            translate([5, 25, 0]) linear_extrude(h + 2.0) text("2 3/8 x 2 3/8", size = 6);
        }
        translate([0.8*x238, 0.2*x238, -1]) {
            cylinder(h = 10, r = 3, center = true);
        }
    }
}



