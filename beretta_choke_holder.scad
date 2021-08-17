choke_len = 91.0; // 90.0
choke_d = 23.0; // 22.0
choke_space = 1.5;

box_outer_l = 140.0;
box_height = 12.0; // 15.0
wall_thick = 1.5;
spacer = 0.25; // 0.50

box_outer_w = choke_len + 2*wall_thick;

$fn = 50;

// ------ Choker Holder Bottom ----------
union(){
    difference(){
        union(){
            cube([box_outer_l, box_outer_w, box_height], center = false);
            translate([wall_thick + 4 * choke_d + 3 * choke_space,
                       0,
                       0]) {
                cube([box_outer_l - (wall_thick + 4 * choke_d + 3 * choke_space), 
                      box_outer_w, 
                      choke_d], center = false);
            }
        }
        for (i = [0 : 3]){
            translate([wall_thick + choke_d / 2.0 + i * (choke_d + choke_space), wall_thick, wall_thick + choke_d / 2.0]){
                rotate([-90, 0, 0]) {
                    cylinder(h = choke_len, r = choke_d / 2.0, center = false);
                }
            }
        }
        left_square_bin = wall_thick + 4 * (choke_d + choke_space);
        translate([left_square_bin, 
                   wall_thick, 
                   wall_thick]){
            cube([box_outer_l - wall_thick - left_square_bin, 
                  choke_len, 
                  choke_d], center = false);
        }
    }
    translate([120, box_outer_w / 2.0, wall_thick]) {
        rotate([0, 0, -90])
        //color("green")
        scale([.15, .15, .05]) 
            surface("c:/repositories/3d-modeling/beretta-png-logo-smaller.png", center = true, invert = false);
    }
}

offset_w = -100.0;
x_inset_border = 14.0;
y_inset_border = 36.5;

// ------ Box Top ----------
union() {
    difference(){
        translate([0, offset_w, 0]) {
            cube([box_outer_l + 2 * wall_thick + 2 * spacer,
                  box_outer_w + 2 * wall_thick + 2 * spacer,
                  box_height + 8.0], center = false);
        }
        translate([wall_thick, offset_w + wall_thick, 2*wall_thick]){
            cube([box_outer_l + 2 * spacer,
                  box_outer_w + 2 * spacer,
                  box_height + 10.0], center = false);
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
        //color("green")
        // .1 is too much, 0.05, 0.06 not enough, 0.07 no, 0.08 no, 0.09 no
        //scale([.2, .2, 0.07])
        // pixels are 463 x 100
        resize([115.75, 25, wall_thick+0.5])
            surface("c:/repositories/3d-modeling/beretta-png-logo-smaller.png", 
                    center = true, invert = true);
    }
}
