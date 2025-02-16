/* https://github.com/cfinke/OpenSCAD-Dovetails */
use <../OpenSCAD-Dovetails/dovetails.scad>
include <test_tube_holder_params.scad>

// END BOARDS
/*color( "orange" )*/ translate([-60, 0, 0])
board_with_dovetail_tails(
    board_length=board_length,
    board_width=board_width,
    board_thickness=board_thickness,
    tail_length=tail_length,
    tail_width=tail_width,
    pin_width=pin_width,
    tail_count=tail_count,
    angle=angle
);

// SIDE BOARDS
/*color( "green" )*/ translate([-120, 0, 0])
board_with_dovetail_tails(
    board_length=side_board_length,
    board_width=board_width,
    board_thickness=board_thickness,
    tail_length=tail_length,
    tail_width=tail_width,
    pin_width=pin_width,
    tail_count=tail_count,
    angle=angle
);
