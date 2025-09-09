$fn = 100;

translate([-225, -165, -234]) resize([155, 150, 110]) import("ThirdParty/darthvader16mmwall.stl");
difference() {
    translate([0, 0, 2]) color("blue") cylinder(h=65, r1=20, r2=40);
    translate([0, 0, 52]) cylinder(h=30, r=35);
}



