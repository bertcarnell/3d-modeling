$fn=100;

difference() {
    union() {
        rotate_extrude() rotate([0, 0, 90]) offset(r=2) {
            translate([2, 2, 0]) {
                square([95-4, 0.25*25-4-0.5]);
                square([0.5*25-4, 15-4]);
                translate([0.5*25-2, 0, 0]) square([40-2, 10-4]);
                translate([0.5*25 + 40 - 2, 0, 0]) square([0.5*25-4, 15-4]);
            }
        }
        cylinder(h = 95, r = 3);
        
    }
    translate([0, 0, -1]) cylinder(h = 8, r = 0.8);
    translate([0, 0, 95-8]) cylinder(h = 20, r = 0.8);
}
