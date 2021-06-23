// parameters

major_od = 34.0; // 33.25;
inner_d = 25.0; // 25.18;
outer_h = 12.0; // 11.86;
level_h = 5.0; // 5.38;
n_facets = 72;
off = 0.25;
mid_second = 50.0;
major_len = 47.57;
small_inner_d = 5.2;  // 4.80

$fn = n_facets;

// pre-calculations

ledge_od = (major_od + inner_d) / 2.0;
other_ledge_od = (ledge_od + inner_d) / 2.0;
upper_h = outer_h - level_h;
assert(upper_h > 0, "distance less than zero");
lower_h = 2.0 * level_h;
middle_cut = upper_h / 2.0;
extra_pt = mid_second + major_len - major_od/2.0 - 4;
assert(extra_pt > 0, "distance less than zero");

// module definition for repeated code
module draw_clip(angle){
    triangle_side_x = mid_second + major_od/2.0 + off + 1.25;
    triangle_point_x = mid_second + major_od/2.0 + off - 0.75;
    triangle_y_1 = level_h + upper_h - (middle_cut + 1.5);
    triangle_y_2 = level_h + upper_h - middle_cut;
    triangle_y_3 = level_h + upper_h - (middle_cut - 1.5);
    rotate_extrude(angle = angle, convexity = 2) {
        polygon([[triangle_side_x, triangle_y_3], 
                 [triangle_side_x, triangle_y_1], 
                 [triangle_point_x, triangle_y_2]]);
    }
}

module draw_clip2(angle){
    triangle_side_x = mid_second - major_od/2.0 - off - 1.25;
    triangle_point_x = mid_second - major_od/2.0 - off + 0.75;
    triangle_y_1 = level_h + upper_h - (middle_cut + 1.5);
    triangle_y_2 = level_h + upper_h - middle_cut;
    triangle_y_3 = level_h + upper_h - (middle_cut - 1.5);
    rotate_extrude(angle = angle, convexity = 2) {
        polygon([[triangle_side_x, triangle_y_3], 
                 [triangle_side_x, triangle_y_1], 
                 [triangle_point_x, triangle_y_2]]);
    }
}


difference(){
    // start with a big cylinder
    translate([0.0, 0.0, 0.0]) {
       cylinder(h = upper_h, r1 = major_od/2.0, r2 = major_od/2.0, center = false);
    }
    // take out the hole the whole way through
    translate([0.0, 0.0, -1.0]) {
       cylinder(h = upper_h + 2.0, r1 = inner_d/2.0, r2 = inner_d/2.0, center = false);
    }
    // take out the cylinder that makes the ledge
    translate([0.0, 0.0, outer_h - lower_h]) {
       cylinder(h = upper_h + 2.0, r1 = ledge_od/2.0 + 0.5, r2 = ledge_od/2.0 + 0.5, center = false);
    }
    // cut the notch in the side of the piece
    rotate_extrude(angle = 360.0, convexity = 2) {
        polygon([[major_od/2.0 + 1.0, middle_cut - 2.0], [major_od/2.0 + 1.0, middle_cut + 2.0], [major_od/2.0 - 1.0, middle_cut]]);
    }
}

// join the cylinder with the holder arm
union() {
    // cylinder part
    difference() {
        // start with the union of two cylinders
        union() {
            // taller cylinder
            translate([mid_second, 0.0, 0.0]) {
               cylinder(h = lower_h, r1 = ledge_od/2.0 + 0.5 - off, 
                        r2 = ledge_od/2.0 + 0.5 - off, center = false);
            }
            // shorter cylinder to make the outside ledge
            translate([mid_second, 0.0, 0.0]) {
                cylinder(h = level_h, r1 = major_od/2.0, r2 = major_od/2.0, 
                         center = false);
            }
        }
        // cut out the hole
        translate([mid_second, 0.0, -1.0]) {
           cylinder(h = lower_h + 2.0, r1 = inner_d/2.0, r2 = inner_d/2.0, center = false);
        }
        // cut to make the inner ledge
        translate([mid_second, 0.0, 5.0]) {
            cylinder(h = lower_h + 2.0, r1 = other_ledge_od/2.0, r2 = other_ledge_od/2.0, center = false);
        }
    }
    // arm part
    difference() {
        // build the arm
        union() {
            // cylinder to put a screw hole in
            translate([extra_pt, 0.0, 0.0]) {
                cylinder(h = level_h, r1 = 5, r2 = 5, center = false);
            }
            // arm attachment
            linear_extrude(height = level_h) {
                    polygon([[76, 5], [73, -3], [63, -4], [63, 7]]);
            }
        }
        // screw hole
        translate([extra_pt, 0.0, -1.0]) {
            cylinder(h = level_h + 2.0, r1 = small_inner_d/2.0, r2 = small_inner_d/2.0, center = false);
        }
    }
    union() {
        // snap fit // extra extensino is to enure some overlap
        translate([mid_second + major_od/2.0 + off, -2.5, level_h - 0.1]) {
            cube([2.5,5,5+0.1], center = false);
        }
        // clip rotating to the right
        draw_clip(2.0);
        // clip rotating to the left
        draw_clip(-2.0);
    }
    linear_extrude(height = level_h) {
        polygon([[35, 5], [35, -5], 
                 [mid_second - major_od/2.0 - off - 2.5, -5], 
                 [mid_second - major_od/2.0 - off - 2.5, 5]]);
    }
    translate([mid_second - major_od/2.0 - off - 2.5, -2.5, level_h -0.1]) {
        cube([2.5, 5, 5+0.1], center = false);
    }
    draw_clip2(-4.0);
    draw_clip2(4.0);
}
