hole_r = 2.7;
tube_r = 5.04;
cap_thick = 3.0;
cap_r = 11.03;
wedge_h = 2.0;
lip = 1.5;
l1 = 101.23;
$fn = 200;

rotate_extrude(angle = 360) {
    rotate([0,0,90]) {
        polygon(points = [[0, hole_r], 
                          [0, hole_r + lip], 
                          [lip, hole_r + lip], 
                          [lip, cap_r],
                          [lip + cap_thick, cap_r], 
                          [lip + cap_thick, tube_r + wedge_h],
                          [lip + cap_thick + wedge_h, tube_r],
                          [l1 - lip - cap_thick - wedge_h, tube_r],
                          [l1 - lip - cap_thick, tube_r + wedge_h],
                          [l1 - lip - cap_thick, cap_r],
                          [l1 - lip, cap_r],
                          [l1 - lip, hole_r + lip],
                          [l1, hole_r + lip],
                          [l1, hole_r]]);
    }
}

