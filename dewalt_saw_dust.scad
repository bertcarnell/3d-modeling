// Dewalt Table Saw dust

saw_od = 64.5;
h1 = 40.0;
middle_h = 60.0;
vacuum_od = 31.3;
h2 = 25.0;
thickness = 5.0;
extra_h = 1.0;

$fn = 100;
difference(){
    union() {
        // main
        cylinder(h = h1, r = saw_od / 2.0 + thickness, center = false);
        translate([0, 0, h1]) {
            cylinder(h = middle_h, r1 = saw_od / 2.0 + thickness, r2 = vacuum_od / 2.0 + thickness, center = false);
        }
        translate([0, 0, h1 + middle_h]) {
            cylinder(h = h2, r = vacuum_od / 2.0 + thickness, center = false);
        }
    }
    // saw hole
    translate([0, 0, -extra_h]) {
        cylinder(h = h1 + extra_h, r = saw_od / 2.0, center = false);
    }
    translate([0, 0, h1 - extra_h]) {
        cylinder(h = middle_h + extra_h, r1 = saw_od / 2.0, r2 = vacuum_od / 2.0, center = false);
    }
    translate([0, 0, h1 + middle_h - extra_h]) {
        cylinder(h = h2 + 2.0 * extra_h, r = vacuum_od / 2.0, center = false);
    }
}

