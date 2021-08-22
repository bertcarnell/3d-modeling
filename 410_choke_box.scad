// 0.410 ga Choke Tube wrench

outer_cyl_r = 10.0 + 0.5;
handle_w = 10.0 + 0.5;
handle_l = 90.0 + 0.5;
wall_thick = 2.0;
box_l = handle_l + 2*wall_thick;
box_w = 40.0;
box_h = 10.0; //10.0;

choke_spacing = 17.0;
choke_box_start = 25.0;
choke_r = 5.0;
choke_l = 26.0;

types = ["F", "IM", "M", "IC", "C"];
types_w = [5, 8.5, 7, 8.5, 6];

$fn = 100;

union(){
    difference(){
        cube([box_l, box_w, box_h], center = false);
        union(){
            translate([wall_thick + handle_l/2, wall_thick + outer_cyl_r, wall_thick]) {
                cylinder(h = 50.0, r = outer_cyl_r, center =false);
            }
            translate([wall_thick, wall_thick + outer_cyl_r - handle_w/2, wall_thick]) {
                cube([handle_l, handle_w, 50], center = false);
            }
        }
        translate([wall_thick, choke_box_start, wall_thick]){
            cube([handle_l, 13, 20.0], center = false);
        }
    }
    for (i = [0 : 4]){
        translate([wall_thick + handle_l/2 - 2*choke_spacing + i * choke_spacing, 
                   choke_box_start + (2 * choke_r + 3.0) / 2.0, 
                   wall_thick])
        {
            cylinder(h = box_h - wall_thick, r = choke_r, center = false);
        }
        translate([wall_thick + handle_l/2 - 2*choke_spacing + i * choke_spacing - types_w[i]/2, 
                   choke_box_start + (2 * choke_r + 3.0) / 2.0 - 4/2, 
                   box_h])
        {
            linear_extrude(1.5) text(types[i], size = 5.5, spacing = 0.7);
        }
    } 
}

offset_w = -60;
lip_edge = 4.0;
box_top_height = 2*wall_thick + choke_l - lip_edge;
spacer = 0.25;

// ------ Box Top ----------
union() {
    difference(){
        translate([0, offset_w, 0]) {
            cube([box_l + 2 * wall_thick + 2 * spacer,
                  box_w + 2 * wall_thick + 2 * spacer,
                  box_top_height], center = false);
        }
        // middle cut out
        translate([2*wall_thick + spacer, 
                   offset_w + 2*wall_thick + spacer, 
                   wall_thick]){
            cube([box_l - 2*wall_thick - 2*spacer,
                  box_w - 2*wall_thick - 2*spacer,
                  box_h + 50.0], center = false);
        }
        // lip cut out
        translate([wall_thick, 
                   offset_w + wall_thick, 
                   box_top_height - box_h + lip_edge]){
            cube([box_l + 2 * spacer,
                  box_w + 2 * spacer,
                  box_h + 50.0], center = false);
        }
    }
}
