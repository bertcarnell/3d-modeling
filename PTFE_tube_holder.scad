// PTFE tube through hole

outer_d = 9.0/2 - 0.1;
inner_d = 4.0/2 + 0.1;
length = 26.0;
flange_outer_d = 14.0/2;
$fn = 100;

difference() {
    union() {
        cylinder(h = length, r = outer_d, center = false);
        translate([0, 0, length]) cylinder(h = 3, r = flange_outer_d, center = false);
    }
    translate([0, 0, -2]) cylinder(h = 2*length, r = inner_d, center = false);
    translate([0, 0, length + 3 - 2]) cylinder(h = 2 + 0.1, r1 = inner_d, r2 = inner_d + 1);
    translate([0, 0, -0.1]) cylinder(h = 2, r1 = inner_d + 1, r2 = inner_d);
}
