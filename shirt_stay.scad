// Collar Stay

w = 9.5;
h = 1.0;
ll = 58.0;
saw_od = 64.5;
l2 = 44.0;
sd = 3.0;

$fn = 100;
union() {
    translate([ll - w/2.0, 0, 0]) {
        cylinder(h = h, r = w / 2.0, center = true);
    }
    translate([sd / 2.0, 0, 0]) {
        cylinder(h = h, r = sd / 2.0, center = true);
    }
    translate([ll - l2, -w / 2.0, -h / 2.0]) {
        cube([l2 - w / 2.0, w, h], center = false);
    }
    translate([0, 0, -h / 2.0]) {
        linear_extrude(h) {
            polygon([
                [sd / 2.0, sd / 2.0],
                [ll - l2, w / 2.0],
                [ll - l2, -w / 2.0],
                [sd / 2.0, -sd / 2.0]
            ]);
        }
    }
}

