// 0.410 ga Choke Tube wrench

inner_cyl_r = 4.75; // 5.0
inner_cyl_h = 20.0;
handle_h = 10.0;
outer_cyl_r = 10.0;
handle_w = 10.0;
handle_l = 80.0;
peg_w = 1.0;
peg_h = 1.75;
peg_l = 2.0;
round_r = 2.0; // 1.0

$fn = 100;

module rounded_cyl(h = 5, r = 2, round_r = 1) {
    union(){
        rotate_extrude(angle = 360) {
            offset(r = round_r){
                translate([round_r, round_r]){
                    square([r - 2 * round_r,
                            h - 2 * round_r], center = false);
                }
            }
        }
        cylinder(h = h, r = round_r, center = false); // eliminate the dimple
    }
};
  

union(){
    // Inner
    rounded_cyl(h = inner_cyl_h, r = inner_cyl_r, round_r = round_r);
    // Outer
    //cylinder(h = handle_h, r = outer_cyl_r, center = false);
    rounded_cyl(h = handle_h, r = outer_cyl_r, round_r = round_r);
    // peg only on one side
    translate([-peg_l / 2.0, 0, handle_h]){
        color("green")
        cube([peg_l, inner_cyl_r + peg_w, peg_h], center = false); // Measnure height and width
    }
    // rounded handle
    translate([-handle_l / 2.0, -handle_w / 2.0 + round_r, handle_h - round_r]){
        rotate([0, 90, 0]){
            linear_extrude(handle_l){
                offset(r = round_r){
                    square([handle_h - 2 * round_r, 
                            handle_w - 2 * round_r], center = false);
                }
            }
        }
    }
    // rounded ends
    translate([-handle_l / 2.0, 0.0, 0.0]) {
        rounded_cyl(handle_h, handle_w / 2.0, round_r);
    }
    translate([handle_l / 2.0, 0.0, 0.0]) {
        rounded_cyl(handle_h, handle_w / 2.0, round_r);
    }
}
