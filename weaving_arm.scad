arm_thickness = 17.5; // mm
base_width = 74.3;
small_arm_width = 3;
large_arm_width = 7.3;
arm_height = 25.0;
small_arm_latch = 4;
large_arm_latch = 8;
my_fn = 100;
triangle_x = 136.8;
triangle_y = 86;
triangle_mid_x = 22.23;
triangle_mid_y = 40.33;
handle_back = 6.6;
new_width = 3.25 * 2.54 * 10 + 2*small_arm_width;

difference() {
    union() {
        // small arm with latch
        translate([-arm_height, 0, 0]) {
            cube([arm_height, small_arm_width, arm_thickness]);
            translate([0, small_arm_width, 0]) {
               linear_extrude(arm_thickness) {
                  polygon([[0, 0], [small_arm_latch, 0], [small_arm_latch, small_arm_latch]]);
               }
            }
        }
        // bigger arm with latch
        translate([-arm_height, base_width - large_arm_width, 0]) {
            cube([arm_height, large_arm_width, arm_thickness]);
            translate([0, -large_arm_latch + small_arm_latch, 0]) {
                cube([small_arm_latch, large_arm_latch - small_arm_latch, arm_thickness]);
                translate([small_arm_latch / 2, 0, 0]){
                   cylinder(h=arm_thickness, r = small_arm_latch / 2, $fn = my_fn, center = false);
                }
            }
        }
        // handle back
        cube([handle_back, base_width, arm_thickness]);
        // triangular shape
        linear_extrude(arm_thickness){
           polygon([[handle_back, 0], [triangle_x, -triangle_y], [triangle_mid_x, triangle_mid_y], [handle_back, base_width]]);
        }
        // small angled latch
        translate([triangle_x, -triangle_y, 0]) {
            rotate([0, 0, -47.8]) {
                cube([small_arm_width, 0.75*2.54*10 + small_arm_latch, arm_thickness]);
                translate([-small_arm_latch, 0.75*2.54*10, 0]){
                   linear_extrude(arm_thickness){
                      polygon([[0, 0], [small_arm_latch, 0], [small_arm_latch, small_arm_latch]]);
                   }
               }
            }
        }
        // backer
        translate([triangle_x + cos(47.8)*small_arm_width, -triangle_y-sin(47.8)*small_arm_width, 0]) {
            rotate([0, 0, -47.8-180]) {
                cube([new_width, handle_back, arm_thickness]);
            }
        }
        // bigger angled latch
        translate([triangle_x - cos(47.8)*new_width + 2*cos(47.8)*small_arm_width, 
                   -triangle_y+sin(47.8)*new_width - 2*sin(47.8)*small_arm_width, 
                   arm_thickness]) {
            rotate([0, 180, -47.8]) {
                cube([small_arm_width, 0.75*2.54*10 + small_arm_latch, arm_thickness]);
                translate([-small_arm_latch, 0.75*2.54*10, 0]){
                   linear_extrude(arm_thickness){
                      polygon([[0, 0], [small_arm_latch, 0], [small_arm_latch, small_arm_latch]]);
                   }
               }
            }
        }
    }
    translate([20, 15, 0]) cylinder(h = 3*arm_thickness, r = 7, center = true, $fn = my_fn);
    translate([35, 0, 0]) cylinder(h = 3*arm_thickness, r = 7, center = true, $fn = my_fn);
    translate([52, -15, 0]) cylinder(h = 3*arm_thickness, r = 7, center = true, $fn = my_fn);
}

