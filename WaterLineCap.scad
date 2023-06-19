$fn=150;
h_first_layer=11;
h_second_layer=5;
h_puck=2.53;
r_bottom=41.5;
r_top=48;
theta=30;
d_puck=12.8; // 12.68
inset=d_puck / 2 + 3;
x=(r_bottom - inset)*cos(theta);
y=(r_bottom - inset)*sin(theta);

difference(){
    difference(){
        union(){
            cylinder(h=h_first_layer, r=r_bottom, center=false);
            translate([0, 0, h_first_layer]) {
                cylinder(h=h_second_layer, r=r_top, center=false);
            }
        }
        translate([r_bottom-inset, 0, 0]) {
            cylinder(h=2*h_puck, r=d_puck/2, center=true);
        }
    }
    translate([x, y, 0]) {
        cylinder(h=2*h_puck, r=d_puck/2, center=true);
    }
}



