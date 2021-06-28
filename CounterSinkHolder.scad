mlength = 9+21+19+17+12+9;
mwidth = 20;
mheight = 20;
mradius = 6.7/2.0;

$fn = 50;


difference() {
    //cube([mwidth, mlength, mheight], center = false);
    linear_extrude(mheight, center = false){
        union(){
            translate([mwidth/2.0, mwidth/2.0, 0]){
                circle(mwidth/2.0);
            }
            translate([mwidth/2.0, mlength - mwidth/2.0, 0]){
                circle(mwidth/2.0);
            }
            translate([0, mwidth/2.0, 0]){
                square([mwidth, mlength - mwidth], center = false);
            }
        }
    }
    translate([mwidth/2.0, 9, 2]) cylinder(mheight, r = mradius, center = false);
    translate([mwidth/2.0, 9+21, 2]) cylinder(mheight, r = mradius, center = false);
    translate([mwidth/2.0, 9+21+19, 2]) cylinder(mheight, r = mradius, center = false);
    translate([mwidth/2.0, 9+21+19+17, 2]) cylinder(mheight, r = mradius, center = false);
    translate([mwidth/2.0, 9+21+19+17+12, 2]) cylinder(mheight, r = mradius, center = false);
}

