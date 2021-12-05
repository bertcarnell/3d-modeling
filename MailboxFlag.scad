$fn = 100;

// base
linear_extrude(3.8) {
    polygon(points = [[0,0], [-19/sqrt(3), 19], [27-19/sqrt(3), 19],
                     [27-19/sqrt(3), 14.5],[27-19/sqrt(3)+16, 14.5],
                     [35,0]],
            paths = [[0,1,2,3,4,5,6]]);
}

// large cylinder
difference(){
    translate([0.5*(27-19/sqrt(3)) - 2, 10 + 2, 0]) {
        cylinder(h = 20.7, r = 10.2/2, center=false);
        cylinder(h = 8, r = 11.5/2, center = false);
    }
    // hole
    translate([11.5, 0, 6]){
        rotate([0, 0, 30]) {
            cube([3.5, 40, 10.1], center = false);
        }
    }
}

// small cylinder
translate([30,5]){
    cylinder(h = 8, r = 10/2, center=false);
    cylinder(h = 12, r = 5.3/2, center=false);
}
