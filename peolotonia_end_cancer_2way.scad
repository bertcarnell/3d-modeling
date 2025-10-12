/*https://www.instructables.com/Design-Model-and-3D-Print-an-Optical-Illusion-Name/*/

d = 40; // text size
m = 2; // margin
h = 2; // base height
lt = 5; // letter thickness
word1 = ["E", "N", "D", "C", "A", "N", "C", "E", "R"];
word2 = ["P", "E", "L", "O", "T", "O", "N", "I", "A"];
$fn = 100;

n = len(word1);
assert(n == len(word2))

// print the words
for (i = [0 : (n-1)]) {
    intersection() {
        ieps1 = 0; /*(word1[i] == "I") ? (d-lt)/3 : 0;*/
        ieps2 = 0; /*(word2[i] == "I") ? (d-lt)/3 : 0;*/
        ifont1 = (word1[i] == "I") ? "Courier New:style=Bold" : "Arial Rounded MT Bold";
        ifont2 = (word2[i] == "I") ? "Courier New:style=Bold" : "Arial Rounded MT Bold";
        id1 = (word1[i] == "I") ? 1.2*d : d;
        id2 = (word2[i] == "I") ? 1.2*d : d;
        translate([d*i + ieps1, 0, -1*d*i - ieps2]) {
            linear_extrude(d + lt) {
                text(word1[i], size = id1, font = ifont1);
            }
        }
        translate([d*i + ieps1, 0, d*(1 - i) - ieps2]){
            rotate([0, 90, 0]) {
                linear_extrude(d + lt) {
                    text(word2[i], size = id2, font = ifont2);
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

