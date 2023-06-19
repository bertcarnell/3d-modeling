d = 25;
word1 = ["M","O","M"];
word2 = ["D","A","D"];
$fn = 100;

n = len(word1);
assert(n == len(word2))

for (i = [0 : (n-1)]) {
    intersection() {
        translate([d*i, 0, -1*d*i]) {
            linear_extrude(d + 5) {
                text(word1[i], size = d);
            }
        }
        translate([d*i, 0, d*(1- i)]){
            rotate([0, 90, 0]) {
                linear_extrude(d + 5) {
                    text(word2[i], size = d);
                }
            }
        }
    }
}


