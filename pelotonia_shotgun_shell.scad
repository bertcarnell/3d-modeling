od = 19.85; // primary diameter
id = 20.00; // diameter in the brass
ih = 6.50;
ph = 6.25; // primer height
th = 56.0;
pid = 6.0; // primer inner diameter
pod = 7.5; // primer outer diameter
$fn = 100;
sqrt2 = sqrt(2);
gold = (1+sqrt(5))/2;
arrow_scale = 0.6*id;

module make_poly_arrow(a, h) {
    linear_extrude(h) 
    polygon([[a, a/2],
             [a/2, 0],
             [a/2/sqrt2, a/2*(1-1/sqrt2)],
             [(1+sqrt2)*a/2-a/gold, a*(1-1/gold)],
             [a/gold-a/2, a*(1-1/gold)],
             [0, a/2],
             [a/gold-a/2, a/gold],
             [(1+sqrt2)*a/2-a/gold, a/gold],
             [a/2/sqrt2, a/2*(1+1/sqrt2)],
             [a/2, a],
             [a, a/2]]);
}

/*make_poly_arrow(1000,100);*/

difference() {
    union() {
        cylinder(h = th, r = 0.5*id);
        translate([0,0,ih]) cylinder(h=th-ih, r=0.5*od);
    }
    translate([0,0,-0.1]) cylinder(h = ph+0.1, r=pod*0.5);
    
    translate([-arrow_scale/2, -arrow_scale/2, th - 2]) 
        rotate([0,0,0]) 
            make_poly_arrow(arrow_scale, 50);
    translate([arrow_scale/2, od-arrow_scale/2, 10]) 
        rotate([90,-90,0]) 
            make_poly_arrow(arrow_scale, 50);
    translate([arrow_scale/2, od-arrow_scale/2, 25]) 
        rotate([90,-90,0]) 
            make_poly_arrow(arrow_scale, 50);
    translate([arrow_scale/2, od-arrow_scale/2, 40]) 
        rotate([90,-90,0]) 
            make_poly_arrow(arrow_scale, 50);
}

translate([30,0,0]) color("black") cylinder(h=ph, r=pid*0.5);

