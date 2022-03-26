/*https://www.instructables.com/Design-Model-and-3D-Print-an-Optical-Illusion-Name/*/

d = 40; // text size
m = 2; // margin
h = 2; // base height
lt = 5; // letter thickness
word1 = ["G", "A", "V", "I", "N"];
word2 = ["T", "O", "U", "G", "H"];
$fn = 100;

n = len(word1);
assert(n == len(word2))

// print the words
for (i = [0 : (n-1)]) {
    intersection() {
        ieps = (word1[i] == "I") ? (d-lt)/3 : 0;
        translate([d*i + ieps, 0, -1*d*i]) {
            linear_extrude(d + lt) {
                text(word1[i], size = d, font = "Arial Rounded MT Bold");
            }
        }
        translate([d*i + ieps, 0, d*(1 - i)]){
            rotate([0, 90, 0]) {
                linear_extrude(d + lt) {
                    text(word2[i], size = d, font = "Arial Rounded MT Bold");
                }
            }
        }
    }
}

// middle base
base_eps = 0.2;
translate([-m/sqrt(2), -h, -m/sqrt(2)]){
    rotate([0, 45, 0]) {
        cube([(n-1)*d*sqrt(2), h+base_eps, 2*m + d*sqrt(2)], center=false);
    }
}
// base rounded ends
translate([d/2, -h/2+base_eps/2, d/2]){
    rotate([90, 0, 0]) {
        cylinder(h = h+base_eps, r = (2*m + d*sqrt(2))/2, center=true);
    }
}
translate([d/2+d*(n-1), -h/2+base_eps/2, d/2 - d*(n-1)]){
    rotate([90, 0, 0]) {
        cylinder(h = h+base_eps, r = (2*m + d*sqrt(2))/2, center=true);
    }
}

