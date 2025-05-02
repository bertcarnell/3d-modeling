$fn = 100;

difference(){
    union() {
        cylinder(h=10, r1=8, r2=5);
        cylinder(h = 1, r = 10);
    }
    translate([0, 0, -10]) cylinder(h = 30, r = 1);
    translate([-10,-10,-20]) cube([20, 20, 20]);
}
