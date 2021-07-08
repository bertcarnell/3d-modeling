
xc = 75.0;
yc = 75.0;
chain_l = 127.0;
chain_w = 9.5;
chain_l_h = chain_l / 2.0;
chain_w_h = chain_w / 2.0;
o_w = 150.0;
o_h = 3.0;
chain_l2 = 38.0;

$vpt = [0, o_w / sqrt(2.0), 0];
$vpr = [0, 0, 0];

rotate([0, 0, 45]) {
    difference() {
        // base
        cube([o_w, o_w, o_h], center = false);
        // bottom long - notes are for unrotated picture - just comment out the rotation
        translate([xc - chain_l_h - chain_w_h, yc - chain_l_h - chain_w_h, -1.0]) {
            cube([chain_l + chain_w, chain_w, 2*o_w], center = false);
        }
        // right long
        translate([xc + chain_l_h + chain_w_h, yc - chain_l_h - chain_w_h, -1.0]){
            rotate([0, 0, 90]){
                cube([chain_l + chain_w, chain_w, 2*o_w], center = false);
            }
        }
        // left arrow head
        translate([xc - chain_l_h + chain_w_h, yc - chain_l_h - chain_w_h, -1.0]) {
            rotate([0, 0, 90]) {
                cube([chain_l2 + chain_w, chain_w, 2*o_w], center = false);
            }
        }
        // right arrow head
        translate([xc + chain_l_h - chain_l2 - chain_w_h, yc + chain_l_h - chain_w_h, -1.0]){
            cube([chain_l2 + chain_w, chain_w, 2*o_w], center = false);
        }
        // left back of arrow head
        translate([xc - chain_l_h - chain_w_h, yc - chain_l_h + chain_l2 - chain_w_h, -1.0]){
            cube([chain_l_h + chain_w_h, chain_w, 2*o_w], center = false);
        }
        // top back of arrow head
        translate([xc + chain_l_h - chain_l2 - chain_w_h, yc, -1.0]){
            cube([chain_w, chain_l_h + chain_w_h, 2*o_w], center = false);
        }
        // left arrow back
        translate([xc - chain_l_h - chain_w_h, yc + chain_l_h - chain_l2 + 8.0, -1.0]){
            cube([chain_w, chain_l2 + chain_w_h - 8.0, 2*o_w], center = false);
        }
        // top arrow back
        translate([xc - chain_l_h - chain_w_h, yc + chain_l_h - chain_w_h, -1.0]){
            cube([chain_l2 + chain_w_h - 8.0, chain_w, 2*o_w], center = false);
        }
        // bottom arrow shaft
        translate([xc - chain_w_h, yc - chain_l_h + chain_l2 - chain_w_h, -1.0]){
            rotate([0, 0, 45]){
                cube([chain_w, chain_l_h*sqrt(2), 2*o_w], center = false);
            }
        }
        // top arrow shaft
        translate([xc + chain_l_h - chain_l2 + chain_w_h, yc + chain_w_h, -1.0]){
            rotate([0, 0, 135]){
                cube([chain_l_h*sqrt(2), chain_w, 2*o_w], center = false);
            }
        }
        // bottom extra triangle on arrow shaft
        translate([0, 0, -1.0]) {
            linear_extrude(2*o_w){
                polygon([[xc - chain_w_h, yc - chain_l_h + chain_l2 - chain_w_h],
                         [xc + chain_w, yc - chain_l_h + chain_l2 - chain_w_h],
                         [xc - chain_w_h, yc - chain_l_h + chain_l2 + chain_w - 0.8]]);
            }
        }
        translate([0, 0, -1.0]) {
            linear_extrude(2*o_w){
                polygon([[xc + chain_l_h - chain_l2 + chain_w_h, yc + .01],
                         [xc + chain_l_h - chain_l2 - chain_w_h + 0.9, yc + .01],
                         [xc + chain_l_h - chain_l2 + chain_w_h, yc - chain_w]]);
            }
        }
    }
}

