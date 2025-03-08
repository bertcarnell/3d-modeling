block_base_height = 33; // mm
inner_length = 3.25 * 2.54 * 10; // 3.25 inches
inner_height = 3/8 * 2.54 * 10; //0.75 inches
bar_width = 18;
arm_latch = 2;
length_extension = 10;
cylinder_width = bar_width - 5;
total_length = length_extension + inner_length + length_extension;
$fn = 100;

union() {
    difference() {
        union() {
            cube([5*bar_width, total_length, block_base_height]);
            translate([0, length_extension/2, 0])
                cylinder(block_base_height + inner_height + arm_latch, r = length_extension/2);
            translate([0, total_length - length_extension/2, 0])
                cylinder(block_base_height + inner_height + arm_latch, r = length_extension/2);
            translate([5*bar_width, length_extension/2, 0])
                cylinder(block_base_height + inner_height + arm_latch, r = length_extension/2);
            translate([5*bar_width, total_length - length_extension/2, 0])
                cylinder(block_base_height + inner_height + arm_latch, r = length_extension/2);
        }
        for (i = [1,3]) {
            translate([i*bar_width, length_extension, -1]) {
                cube([bar_width, inner_length, block_base_height + 2]);
            }
        }
        for (i = [0.5, 4.5]) {
            translate([i*bar_width, -1, block_base_height - cylinder_width/2 - 5]) {
                rotate([-90, 0, 0])
                cylinder(h = total_length + 2, r = cylinder_width / 2, center = false);
            }
        }
        for (i = [0, 4]) {
            translate([2.5 + i*bar_width, -1, -1]) {
                cube([cylinder_width, total_length + 2, block_base_height - cylinder_width/2 - 5]);
            }
        }
    }
    for (j = [0, length_extension + inner_length]) {
        for (i = [0, 2, 4]) {
            translate([i*bar_width, j, block_base_height]) {
                cube([bar_width, length_extension, inner_height + arm_latch]);
            }
        }
    }
    for (i = [0, 2, 4]) {
        translate([i*bar_width, length_extension, block_base_height + inner_height + arm_latch]) {
            rotate([0, 90, 0])
            linear_extrude(bar_width) {
              polygon([[0, 0], [arm_latch, 0], [arm_latch, arm_latch]]);
            }
        }
        translate([(i+1)*bar_width, length_extension + inner_length, block_base_height + inner_height + arm_latch]) {
            rotate([-180, 90, 0])
            linear_extrude(bar_width) {
              polygon([[0, 0], [arm_latch, 0], [arm_latch, arm_latch]]);
            }
        }
    }

}
