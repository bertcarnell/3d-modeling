$fn=100;

overall_length = 71.39;
largest_width = 15.96 - 1/32*2.54*10;
finger_section_length = 26.0;
shoulder1 = 2.0;
shoulder2 = 4.75 - 1/32*2.54*10;
slide_width = 8.75;
spring_area_length = 50.23;
spring_area_width = 5.3;
height = 5.5;
base_height = 1.25;
wall_width = 2.0;
hook_width = 4.5;
hook_length = 6.81;
huge_height = 200;
start_under_cutout = 53.0;
start_over_cutout = 62.25;
under_cut_height = 1.0;
arrow_width = 5.4;
shelf_height = 2.6;

module create_slider() {
    difference() {
        union() {
            color("red") 
            cube([finger_section_length, largest_width, height]);
            color("blue")
            translate([0, shoulder2, 0]) {
                cube([overall_length, slide_width, height]);
            }
        }
        // Finger Hole
        translate([largest_width/2, wall_width, base_height]) {
            cube([finger_section_length - largest_width,
                  largest_width - 2*wall_width,
                  height]);
        }
        translate([largest_width/2, largest_width/2, base_height]){ 
            cylinder(h = huge_height, r = largest_width/2-wall_width);
        }
        translate([finger_section_length-largest_width/2, largest_width/2, base_height]){
            cylinder(h = huge_height, r = largest_width/2-wall_width);
        }
        // long notch
        translate([wall_width, shoulder2 + 1, base_height]) {
            cube([spring_area_length,
                  spring_area_width,
                  height]);
        }
        // under slot cut out
        translate([start_under_cutout, shoulder2-0.1, -0.1]) {
            cube([huge_height, 
                  slide_width + 0.2, 
                  under_cut_height + 0.1]);
        }
        // above slot cut out
        translate([start_over_cutout, 
                   shoulder2-0.1, 
                   under_cut_height + shelf_height]) {
            cube([huge_height, slide_width+0.2, huge_height]);
        }
    }

    translate([start_over_cutout, 
                shoulder2 + (slide_width - arrow_width)/2, 
                under_cut_height + shelf_height]) {
        // notch back
        color("purple") cube([3, arrow_width, 5]);
        // notch angled part
        difference() {
            color("yellow") translate([2, 0, 0]) {
                cube([7, arrow_width, 3.6]);
            }
            translate([2, -0.1, 3.6]) rotate([0, 25, 0]) {
                cube([7+1, arrow_width + 0.2, 10]);
            }
            translate([9, arrow_width, 0]) rotate([0, 0, -135]){
                cube([10, 10, 10]);
            }
        }
    }

    // Finger Pull cube
    translate([0, wall_width, 0]) {
        cube([2, largest_width - 2*wall_width, 8]);
    }
}

create_slider();

translate([-10, 0, 0]) mirror([1, 0, 0]) create_slider();

