choke_len = 77.0;
choke_d = 19.5;
choke_space = 1.5;
choke_len2 = 52.0;

box_outer_l = 115.0;
box_outer_w = 105.0;
box_height = 10.0;
wall_thick = 1.5;
spacer = 0.25;

$fn = 50;

// ------ Choker Holder Bottom ----------
union(){
    difference(){
        cube([box_outer_l, box_outer_w, box_height], center = false);
        for (i = [0 : 2]){
            translate([wall_thick + choke_d / 2.0 + i * (choke_d + choke_space), 
                       wall_thick, 
                       wall_thick + choke_d / 2.0]){
                rotate([-90, 0, 0]) {
                    cylinder(h = choke_len, r = choke_d / 2.0, center = false);
                }
            }
        }
        translate([wall_thick + choke_d / 2.0 + 3 * (choke_d + choke_space), 
                   wall_thick, 
                   wall_thick + choke_d / 2.0]){
            rotate([-90, 0, 0]) {
                cylinder(h = choke_len2, r = choke_d / 2.0, center = false);
            }
        }
        left_square_bin = wall_thick + 4 * (choke_d + choke_space);
        translate([left_square_bin, 
                   wall_thick, 
                   wall_thick]){
            cube([box_outer_l - wall_thick - left_square_bin, 
                  choke_len2 + 5.0, 
                  choke_d], center = false);
        }
        left_square_bin2 = wall_thick + 3 * (choke_d + choke_space);
        translate([left_square_bin2, 
                   choke_len2 + 2*wall_thick, 
                   wall_thick]){
            cube([box_outer_l - wall_thick - left_square_bin2, 
                  box_outer_w - 3*wall_thick - choke_len2, 
                  choke_d], center = false);
        }
        translate([wall_thick,
                   2*wall_thick + choke_len,
                   wall_thick]) {
            cube([3*choke_d + 2*choke_space + 5.0, 
                  5.0, 
                  choke_d], center = false);
        }
    }
    translate([1.7 * choke_d, 
               choke_len + 2*wall_thick + 14.0, 
               box_height]) {
        resize([46, 10, .5]) 
            surface("c:/repositories/3d-modeling/beretta-png-logo-smaller.png", center = true, invert = false);
    }
    /*translate([0, box_outer_w - 5.0, 0]){
        cube([5, 5, 18.0], center = false);
    }
    translate([box_outer_l - 5.0, box_outer_w - 5.0, 0]){
        cube([5, 5, 18.0], center = false);
    }
    translate([box_outer_l - 5.0, 0, 0]){
        cube([5, 5, 18.0], center = false);
    }*/
}

offset_w = -115;
x_inset_border = 9.4;
y_inset_border = 43.5;
box_top_height = box_height + 10.0;

// ------ Box Top ----------
union() {
    difference(){
        translate([0, offset_w, 0]) {
            cube([box_outer_l + 2 * wall_thick + 2 * spacer,
                  box_outer_w + 2 * wall_thick + 2 * spacer,
                  box_top_height], center = false);
        }
        /*translate([wall_thick, offset_w + wall_thick, 2*wall_thick]){
            cube([box_outer_l + 2 * spacer,
                  box_outer_w + 2 * spacer,
                  box_height + 15.0], center = false);
        }*/
        translate([2*wall_thick + spacer, offset_w + 2*wall_thick + spacer, 2*wall_thick]){
            cube([box_outer_l - 2*wall_thick - 2*spacer,
                  box_outer_w - 2*wall_thick - 2*spacer,
                  box_height + 15.0], center = false);
        }
        translate([wall_thick, offset_w + wall_thick, 2*wall_thick + 10]){
            cube([box_outer_l + 2 * spacer,
                  box_outer_w + 2 * spacer,
                  box_height + 15.0], center = false);
        }
        translate([x_inset_border, 
                   offset_w + box_outer_w + 2 * wall_thick + 2 * spacer - y_inset_border, 
                   wall_thick]) {
            rotate([180, 0, 0])
            cube([box_outer_l + 2 * wall_thick + 2 * spacer - 2 * x_inset_border, 
                  box_outer_w + 2 * wall_thick + 2 * spacer - 2 * y_inset_border, 
                  10], center = false);
        }
    }
    translate([(box_outer_l + 2 * wall_thick + 2 * spacer) / 2.0, 
                offset_w + (box_outer_w + 2*wall_thick + 2*spacer) / 2.0, 
                0]) {
        rotate([180, 0, 0])
        // pixels are 463 x 100
        resize([100, 22, wall_thick+0.5])
            surface("c:/repositories/3d-modeling/beretta-png-logo-smaller.png", 
                    center = true, invert = true);
    }
}
