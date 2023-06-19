x = 16.0;
y = 2.0;

linear_extrude(y) {
    polygon(points=[[0, 0],
                    [-x, 0],
                    [-5*x/4, x*sqrt(3)/4],
                    [-x/2, x*sqrt(3)/2],
                    [-x/2, x*sqrt(3)],
                    [0, x*sqrt(3)],
                    [x/4, 5*x*sqrt(3)/4],
                    [x, x*sqrt(3)],
                    [x, x*sqrt(3)/2],
                    [3*x/2, x*sqrt(3)/2],
                    [7*x/4, x*sqrt(3)/4],
                    [x, 0],
                    [x/4, x*sqrt(3)/4]]);
}

