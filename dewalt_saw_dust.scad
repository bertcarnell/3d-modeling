// Dewalt Table Saw dust

saw_od = 65.5;
h1 = 33.0;
vacuuum_od = 31.3;
h2 = 25.0;
thickness = 5.0;
extra_h = 5.0;

$fn = 100;
difference(){
    // main
    cylinder(h = h1 + h2, r = saw_od / 2.0 + thickness, center = false);
    // saw hole
    translate([0, 0, h1]) {
        cylinder(h = h2 + extra_h, r = saw_od / 2.0, center = false);
    }
    translate([0, 0, -1*extra_h]) {
        cylinder(h = h1 + extra_h + extra_h, r = vacuuum_od / 2.0, center = false);
    }
}

