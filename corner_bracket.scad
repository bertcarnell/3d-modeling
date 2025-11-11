length1 = 6*2.54*10;
widtho = 1.25*2.54*10;
widthi = 0.75*2.54*10;
height1 = 1*2.54*10;

difference() {
    color("purple")
    union() {
        cube([length1, widtho, height1]);
        cube([widtho, length1, height1]);
        translate([length1-widtho, 0, 0]) rotate([0, 0, 45])
            cube([widtho, (length1-widtho)*sqrt(2), height1]);
    }
    translate([-1, (widtho-widthi )/2, 0.25*2.54*10])
        cube([2*length1, widthi, height1]);
    translate([(widtho-widthi)/2, -1, 0.25*2.54*10])
        cube([widthi, 2*length1, height1]);
    translate([-1, -1, 0.25*2.54*10])
        cube([widthi, widthi, height1]);
}

