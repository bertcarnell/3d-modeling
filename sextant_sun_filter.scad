major_od = 33.25;
inner_d = 25.18;
outer_h = 11.86;
level_h = 5.38;

difference(){
    translate([0,0,0]) cylinder(h = 10, r1 = 22.5, r2 = 22.5, center = false, $fn = 100);
    translate([0,0,-1]) cylinder(h = 10+2, r1 = 12.5, r2 = 12.5, center = false, $fn = 100);
    translate([0,0,5]) cylinder(h = 5+2, r1 = 17.5, r2 = 17.5, center = false, $fn = 100);
    rotate_extrude(angle = 360, convexity = 2, $fn = 100) {
        polygon([[23.5,5],[23.5,9],[21.5,7]]);
    }
}

union() {
    difference() {
        translate([50,0,0]) cylinder(h = 10, r1 = 16.5, r2 = 16.5, center = false, $fn = 100);
        translate([50,0,-1]) cylinder(h = 10+2, r1 = 12.5, r2 = 12.5, center = false, $fn = 100);
        translate([50,0,5]) cylinder(h = 5+2, r1 = 14.5, r2 = 14.5, center = false, $fn = 100);
    }
    difference() {
        union() {
            translate([75,0,0]) cylinder(h = 5, r1 = 5, r2 = 5, center = false, $fn = 100);
            linear_extrude(height = 5) {
                    polygon([[75,5],[75,-5],[63,-10],[63,10]]);
            }
        }
        difference() {
            translate([75,0,-1]) cylinder(h = 5+2, r1 = 2.5, r2 = 2.5, center = false, $fn = 100);
        }
    }
}

