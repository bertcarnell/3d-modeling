newx = 2.54*10*4;
newy = 2.54*10*4;
newz = 2.54*10*0.3333;

od = 2.54*10*4.5;
id = 2.54*10*4.25;
h = 2.54*10*3.5;
bh = 2.54*10*0.5;

$fn = 100;

difference() {
    cylinder(h = h, r = od/2);
    translate([0, 0, newz]) cylinder(h = h+10, r = id/2);
    translate([0, 0, newz-2]) linear_extrude(h = 10) offset(r = -0.1) rotate([180, 0, 0]) projection(cut = false) {
        difference() {
            cylinder(h = newz, r = newx / 2 - 0.1, center = false);
            translate([0,0,-0.1]) color("blue") resize([newx, newy, newz + 0.2]) rotate([90, 0, 0]) import("ThirdParty/Starfleet 2.0 Coaster.stl");
        }
    }
    translate([-25, -100, newz]) cube([50, 200, 100]);
    translate([-100, -25, newz]) cube([200, 50, 100]);
}
