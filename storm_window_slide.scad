$fn=100;

overall_length = 71.39;
largest_width = 15.96;
finger_section_length = 26.0;
shoulder1 = 2.0;
shoulder2 = 4.75;
slide_width = 8.75;
spring_area_length = 50.23;
spring_area_width = 5.3;
height = 5.5;
base_height = 1.25;
wall_width = 2.0;
hook_width = 4.5;
hook_length = 6.81;

difference() {
    union() {
        color("red") 
        cube([finger_section_length, largest_width, height]);
        color("blue")
        translate([0, shoulder2, 0]) {
            cube([overall_length, slide_width, height]);
        }
    }
    translate([wall_width, wall_width, base_height]) {
        cube([finger_section_length - 2*wall_width,
              largest_width - 2*wall_width,
              height]);
    }
    translate([wall_width, shoulder2 + 1, base_height]) {
        cube([spring_area_length,
              spring_area_width,
              height]);
    }
    translate([53.0, shoulder2-0.1, -0.1]) {
        cube([200, slide_width+0.2, 1+0.1]);
    }
    translate([62.25, shoulder2-0.1, 1+2.6]) {
        cube([200, slide_width+0.2, 200]);
    }
}

