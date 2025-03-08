edge_x = 1.5;
edge_y = 1.5;
tube_x = 21.25;
tube_y = 21.25;
tube_z = 4;
cube_y = tube_y + 2*edge_y;
cube_x = tube_x + 2*edge_x;
cube_z = tube_z;
nx = 4;
ny = 6;
x_letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I"];

$fn = 100;

tail_width = 4;
tail_count = 4;
tail_length = 4;
board_width = 2*cube_x;
board_length = 3*2.54*10 + 2*tail_length;
side_board_length = 1.5*2.54*10 + 2*tail_length;
angle = 15;
board_thickness = 4.0;
dovetail_offset = 0.005; // from dovetails.scad
pin_width = pin_width(tail_width = tail_width, 
                      tail_count=tail_count, 
                      board_width=board_width);

module corner_filet(move_x, move_y) {
    assert(move_x == 1 || move_x == 0)
    assert(move_y == 1 || move_y == 0)
    difference() {
        translate([edge_x + move_x*(tube_x -2*edge_x), 
                   edge_y + move_y*(tube_y - 2*edge_y), 
                   0]) {
            cube([2*edge_x, 2*edge_y, cube_z], center = false);
        }
        translate([3*edge_x + move_x*(tube_x - 4*edge_x), 
                   3*edge_y + move_y*(tube_y - 4*edge_y), 
                   -1]) {
            cylinder(r = 2*edge_x, h = cube_z + 2, center = false);
        }
    }
}
