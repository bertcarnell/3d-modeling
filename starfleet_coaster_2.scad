newx = 2.54*10*4;
newy = 2.54*10*4;
newz = 2.54*10*0.3333;

linear_extrude(h = 1) offset(r = -0.1) rotate([180, 0, 0]) projection(cut = false) {
    difference() {
        cylinder(h = newz, r = newx / 2 - 0.1, center = false);
        translate([0,0,-0.1]) color("blue") resize([newx, newy, newz + 0.2]) rotate([90, 0, 0]) import("ThirdParty/Starfleet 2.0 Coaster.stl");
    }
}

translate([0, 0, newz])
rotate([180, 0, 0]) {
    translate([100, 0, 0])
    color("blue") resize([newx, newy, newz + 0.2]) rotate([90, 0, 0]) import("ThirdParty/Starfleet 2.0 Coaster.stl");
}

