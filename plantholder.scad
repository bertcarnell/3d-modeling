h = 60.0;
r = 80.0;
ir = 65.0;
ih = 50.0;

$fn = 100;

difference() {
    cylinder(h = h, r = r, center = false);
    translate([0, 0, h-ih]) {
        cylinder(h = ih+20.0, r = ir, center = false);
    };
};

