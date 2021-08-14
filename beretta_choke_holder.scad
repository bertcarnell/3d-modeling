choke_len = 90.0;
choke_d = 22.0;
choke_space = 2.0;

box_outer_l = 140.0;
box_height = 15.0;
wall_thick = 2.0;
spacer = 0.5;

box_outer_w = choke_len + 2*wall_thick;

$fn = 50;

union(){
    difference(){
        cube([box_outer_l, box_outer_w, box_height], center = false);
        for (i = [0 : 3]){
            translate([wall_thick + choke_d / 2.0 + i * (choke_d + choke_space), wall_thick, wall_thick + choke_d / 2.0]){
                rotate([-90, 0, 0]) {
                    cylinder(h = choke_len, r = choke_d / 2.0, center = false);
                }
            }
        }
        translate([wall_thick + 4 * (choke_d + choke_space) + choke_space, wall_thick, wall_thick]){
            cube([35.0, choke_len, choke_d], center = false);
        }
    }
    translate([120, 50, wall_thick]) {
        rotate([0, 0, -90])
        color("green")
        scale([.05, .05, 0.05]) 
            surface("c:/repositories/3d-modeling/beretta-png-logo.png", center = true, invert = false);
    }
}

difference(){
    translate([-200, 0, 0]) {
        cube([box_outer_l + 2 * wall_thick + 2 * spacer,
              box_outer_w + 2 * wall_thick + 2 * spacer,
              box_height + 5.0], center = false);
    }
    translate([-200 + wall_thick, wall_thick, wall_thick]){
        cube([box_outer_l + 2 * spacer,
              box_outer_w + 2 * spacer,
              box_height + 10.0], center = false);
    }
    translate([-200 + (box_outer_l + 2 * wall_thick + 2 * spacer) / 2.0, 50, 0]) {
        rotate([180, 0, 0])
        color("green")
        scale([.11, .11, 1]) 
            surface("c:/repositories/3d-modeling/beretta-png-logo.png", center = true, invert = false);
    }
}
