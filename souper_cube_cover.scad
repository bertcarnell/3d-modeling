
l1 = 125.0;
l2 = 129.0;
h1 = 6.0;
h2 = 4.0;
u1 = 141.0;
u2 = 145.0;
r2 = 19.0;
r3 = 2.0;
$fn = 100;
lip = 5.0;


//union() {
//    cube([u1, u2, h2]);
//    translate([(u1-l1)/2.0, (u2-l2)/2.0, h2]) {
//        roundedcube([l1, l2, h1], center = false, radius = 5.0, apply_to = "z");
//    }
//}

difference() {
    union() {
        hull() {
            translate([r2, r2, 0]) {
                cylinder(h2, r = r2);
            }
            translate([u1-r2, r2, 0]) {
                cylinder(h2, r =  r2);
            }
            translate([u1-r2, u2-r2, 0]) {
                cylinder(h2, r =  r2);
            }
            translate([r2, u2-r2, 0]) {
                cylinder(h2, r =  r2);
            }
        }
        hull() {
            translate([(u1-l1)/2.0 + r2, (u2-l2)/2.0 + r2, 0]) {
                cylinder(h2 + h1, r =  r2);
            }
            translate([u1 - (u1-l1)/2.0 - r2, (u2-l2)/2.0 + r2, 0]) {
                cylinder(h2 + h1, r =  r2);
            }
            translate([u1 - (u1-l1)/2.0 - r2, u2 - (u2-l2)/2.0 - r2, 0]) {
                cylinder(h2 + h1, r =  r2);
            }
            translate([(u1-l1)/2.0 + r2, u2 - (u2-l2)/2.0 - r2, 0]) {
                cylinder(h2 + h1, r =  r2);
            }
        }
    }
    translate([u1/2.0, u2/2.0, -1]) {
        cylinder(1.5*h2 + 1.0, r = r3);
    }
    hull() {
        translate([(u1-l1)/2.0 + r2 + lip, (u2-l2)/2.0 + r2 + lip, h2]) {
            cylinder(h2 + h1, r =  r2);
        }
        translate([u1 - (u1-l1)/2.0 - r2 - lip, (u2-l2)/2.0 + r2 + lip, h2]) {
            cylinder(h2 + h1, r =  r2);
        }
        translate([u1 - (u1-l1)/2.0 - r2 - lip, u2 - (u2-l2)/2.0 - r2 - lip, h2]) {
            cylinder(h2 + h1, r =  r2);
        }
        translate([(u1-l1)/2.0 + r2 + lip, u2 - (u2-l2)/2.0 - r2 - lip, h2]) {
            cylinder(h2 + h1, r =  r2);
        }
    }
}

translate([-25, 0, 0]) {
    union() {
        cylinder(h2, r = 20);
        cylinder(h2 + 2*h1, r = 8);
        cylinder(h2 + 2*h1 + h2, r = r3);
    }
}
