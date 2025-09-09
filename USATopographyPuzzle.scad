
difference() {
    import("ThirdParty/United States Height Map Puzzle - 2759321/USATopographyPuzzle.stl");
    translate([0, 0, -1]) cube([100, 100, 100], center = false);
    translate([-100, -100, -1]) cube([100, 200, 100], center = false); 
}

