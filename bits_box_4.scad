h1 = 32.0;
h2 = 35.0;
lg = 115.0;
wi = 126.0;
$fn = 100;

union() {
    difference(){
        union() {
            cube([wi, lg, h1], center = false);
            translate([wi/2, 10, 0]) {
                cylinder(h=4, r=30, center = false);
            }
        }
        translate([2,2,2]){
            cube([wi-4, lg-4, h1], center = false);
        }
    };
    cube([wi, 2, h2], center = false);
    translate([wi/2-1, 0, 0]){
        cube([2, lg, h1], center = false);
    }
    translate([0, lg/2-1, 0]) {
        cube([wi, 2, h1], center = false);
    }
};
