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
            translate([5, 5, 0]) {
                linear_extrude(h + 2.0) text("3.5 x 6.5", size = 6);
            }
            /*translate([x35 / 2.0, x65 / 2.0, h + 1]) {
                rotate([0, 0, 90]) {
                    resize([125, 44, 4.0]) {
                        surface("c:/repositories/3d-modeling/Galloping_Horse_500_174.png", center = true, invert = true);
                    }
                }
            }*/
            translate([x35 / 2.0, x65 / 2.0, h-1]) {
                rotate([0, 0, 90]) {
                    resize([125, 44, 3]) {
                        surface("c:/repositories/3d-modeling/Galloping_Horse_Transparent_500_174.png", center = true, invert = false);
                    }
                }
            }
        }
        translate([0.8*x35, 0.1*x65, -1]) {
            cylinder(h = 10, r = 3, center = true);
        }
    }
}

