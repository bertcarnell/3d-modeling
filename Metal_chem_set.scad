rad = 25/2;
hole_rad = 5.2/2;
$fn = 100;

difference() {
    sphere(rad);
    translate([0, 0, -15]){
        cylinder(h=30, r=hole_rad);
    }
    rotate([0, 90, 90]) {
        cylinder(h=30, r=hole_rad);
    }
    rotate([120, 90, 90]) {
        cylinder(h=30, r=hole_rad);
    }
    rotate([240, 90, 90]) {
        cylinder(h=30, r=hole_rad);
    }
}

translate([30, 0, 0]) {
    difference() {
        sphere(rad);
        translate([0, 0, -15]){
            cylinder(h=30, r=hole_rad);
        }
        rotate([0, 90, 90]) {
            cylinder(h=30, r=hole_rad);
        }
        rotate([90, 90, 90]) {
            cylinder(h=30, r=hole_rad);
        }
        rotate([180, 90, 90]) {
            cylinder(h=30, r=hole_rad);
        }
        rotate([270, 90, 90]) {
            cylinder(h=30, r=hole_rad);
        }
    }
}
