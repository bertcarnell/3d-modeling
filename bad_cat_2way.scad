/*https://www.instructables.com/Design-Model-and-3D-Print-an-Optical-Illusion-Name/*/

d = 40;
m = 5;
h = 3;
word1 = ["B","A","D"];
word2 = ["C","A","T"];
$fn = 100;

n = len(word1);
assert(n == len(word2))

for (i = [0 : (n-1)]) {
    intersection() {
        translate([d*i, 0, -1*d*i]) {
            linear_extrude(d + 5) {
                text(word1[i], size = d, font = "Arial Rounded MT Bold");
            }
        }
        translate([d*i, 0, d*(1 - i)]){
            rotate([0, 90, 0]) {
                linear_extrude(d + 5) {
                    text(word2[i], size = d, font = "Arial Rounded MT Bold");
                }
            }
        }
    }
}

translate([-m/sqrt(2), -h, -m/sqrt(2)]){
    rotate([0, 45, 0]) {
        cube([(n-1)*d*sqrt(2), h+0.2, 2*m + d*sqrt(2)], center=false);
    }
}
translate([d/2, -h/2+0.1, d/2]){
    rotate([90, 0, 0]) {
        cylinder(h = h+0.2, r = (2*m + d*sqrt(2))/2, center=true);
    }
}
translate([d/2+d*(n-1), -h/2+0.1, d/2 - d*(n-1)]){
    rotate([90, 0, 0]) {
        cylinder(h = h+0.2, r = (2*m + d*sqrt(2))/2, center=true);
    }
}

