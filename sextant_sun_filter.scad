// parameters

major_od = 33.25;
inner_d = 25.18;
outer_h = 11.86;
level_h = 5.38;
n_facets = 100;
off = 0.3;
mid_second = 50.0;
major_len = 47.57;
small_inner_d = 4.80;

// pre-calculations

ledge_od = (major_od + inner_d) / 2.0;
other_ledge_od = (ledge_od + inner_d) / 2.0;
upper_h = outer_h - level_h;
lower_h = 2.0 * level_h;
middle_cut = upper_h / 2.0;
extra_pt = mid_second + major_len - major_od/2.0 - 4;

difference(){
    translate([0.0, 0.0, 0.0]) {
       cylinder(h = upper_h, r1 = major_od/2.0, r2 = major_od/2.0, center = false, $fn = n_facets);
    }
    translate([0.0, 0.0, -1.0]) {
       cylinder(h = upper_h + 2.0, r1 = inner_d/2.0, r2 = inner_d/2.0, center = false, $fn = n_facets);
    }
    translate([0.0, 0.0, outer_h - lower_h]) {
       cylinder(h = upper_h + 2.0, r1 = ledge_od/2.0, r2 = ledge_od/2.0, center = false, $fn = n_facets);
    }
    rotate_extrude(angle = 360.0, convexity = 2, $fn = n_facets) {
        polygon([[major_od/2.0 + 1.0, middle_cut - 2.0], [major_od/2.0 + 1.0, middle_cut + 2.0], [major_od/2.0 - 1.0, middle_cut]]);
    }
}

union() {
    difference() {
        translate([mid_second, 0.0, 0.0]) {
           cylinder(h = lower_h, r1 = ledge_od/2.0 - off, r2 = ledge_od/2.0 - off, center = false, $fn = n_facets);
        }
        translate([mid_second, 0.0, -1.0]) {
           cylinder(h = lower_h + 2.0, r1 = inner_d/2.0, r2 = inner_d/2.0, center = false, $fn = n_facets);
        }
        translate([mid_second, 0.0, 5.0]) {
            cylinder(h = lower_h + 2.0, r1 = other_ledge_od/2.0, r2 = other_ledge_od/2.0, center = false, $fn = n_facets);
        }
    }
    difference() {
        union() {
            translate([extra_pt, 0.0, 0.0]) {
                cylinder(h = level_h, r1 = 5, r2 = 5, center = false, $fn = 100);
            }
            linear_extrude(height = level_h) {
                    polygon([[75, 5], [75, -5], [63, -7], [63, 7]]);
            }
        }
        difference() {
            translate([extra_pt, 0.0, -1.0]) {
                cylinder(h = level_h + 2.0, r1 = small_inner_d/2.0, r2 = small_inner_d/2.0, center = false, $fn = 100);
            }
        }
    }
}

