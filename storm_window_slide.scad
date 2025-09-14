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
        translate([largest_width/2, wall_width, base_height]) {
            cube([finger_section_length - largest_width,
                  largest_width - 2*wall_width,
                  height]);
        }
        translate([largest_width/2, largest_width/2, base_height]) cylinder(h = 200, r = largest_width/2-wall_width);
        translate([finger_section_length-largest_width/2, largest_width/2, base_height]) cylinder(h = 200, r = largest_width/2-wall_width);
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

    translate([64, shoulder2 + (slide_width - 5.4)/2, 1+2.6]) {
        color("purple") cube([1, 5.4, 5]);
        difference() {
            color("yellow") cube([7, 5.4, 3.6]);
            translate([0, -0.1, 3.6]) rotate([0, 25, 0]) cube([7+1, 5.4+0.2, 10]);
            translate([7, 5.4, 0]) rotate([0, 0, -135]) cube([10, 10, 10]);
        }
    }

    cube([2, largest_width, 8]);
}

create_slider();

translate([-10, 0, 0]) mirror([1, 0, 0]) create_slider();

