// Parametric Hole Plug
//
// A round plug for a hole in a panel: a flange caps the hole from the
// top face, an insert tube centers the plug in the hole, and spring
// clips (cantilevered from the underside of the flange) snap over the
// far face of the panel to hold the plug in place.
//
// All user parameters are given in inches (the units the plug is
// usually specified in) and converted to millimeters for OpenSCAD/the
// slicer. Requires OpenSCAD 2019.05+ (uses the `angle=` argument of
// rotate_extrude()).
//
// Recommended print orientation: flange down, insert pointing up.
// No supports should be needed if barb_depth_in is kept small relative
// to barb_height_in (a shallow, printable overhang).

$fn = 100;

IN = 25.4; // mm per inch

// ---------------- User parameters (inches) ----------------

// Insert (the part that goes into the hole)
insert_diameter_in    = 3;     // nominal outer diameter of the insert / hole
insert_depth_in       = 0.85;  // length of the insert below the flange
insert_clearance_in   = 0.02;  // diametral clearance so the insert slides into the hole
wall_thickness_in     = 0.09;  // wall thickness of the hollow insert tube
lead_in_chamfer_in    = 0.05;  // small taper on the insert's leading edge, to ease starting it into the hole

// Flange (caps the hole on the near/visible face)
flange_diameter_in    = 4;     // outer diameter of the flange
flange_thickness_in   = 0.125; // thickness of the flange

// Material the clips grab (e.g. 1/4" plywood, sheet metal, etc.)
material_thickness_in = 0.25;

// Snap clips
num_clips           = 4;    // number of clips spaced evenly around the insert
clip_gap_deg        = 12;   // angular width of the flex slot cut between clips
clip_top_margin_in  = 0.06; // solid ring left under the flange that the clips cantilever from
barb_depth_in       = 0.045;// how far the barb protrudes beyond the nominal insert diameter
barb_height_in      = 0.09; // height (along the clip) of the barb hook
barb_shoulder_in    = 0.02; // height of the near-vertical catch face of the barb

// ---------------- Derived dimensions (mm) ----------------

insert_r     = insert_diameter_in * IN / 2;
flange_r     = flange_diameter_in * IN / 2;
material_t   = material_thickness_in * IN;
insert_depth = insert_depth_in * IN;
flange_t     = flange_thickness_in * IN;
wall_t       = wall_thickness_in * IN;
clearance    = insert_clearance_in * IN;
chamfer_h    = min(lead_in_chamfer_in * IN, insert_depth / 4);

tube_or = insert_r - clearance / 2; // printed outer radius of the insert tube
tube_ir = tube_or - wall_t;         // inner radius (hollow bore)

barb_depth    = barb_depth_in * IN;
barb_height   = barb_height_in * IN;
barb_shoulder = barb_shoulder_in * IN;
clip_top_margin = clip_top_margin_in * IN;

clip_pitch_deg = 360 / num_clips;
clip_width_deg = clip_pitch_deg - clip_gap_deg;

assert(clip_width_deg > 0, "clip_gap_deg is too large for the number of clips");
assert(tube_ir > 0, "wall_thickness_in is too large for insert_diameter_in");
assert(insert_depth - material_t - barb_height > 0,
       "insert_depth_in must be greater than material_thickness_in + barb_height_in");

// ---------------- Modules ----------------

// Hollow insert tube with a small lead-in chamfer at the free (bottom) end.
module insert_tube() {
    difference() {
        union() {
            translate([0, 0, chamfer_h])
                cylinder(h = insert_depth - chamfer_h, r = tube_or);
            cylinder(h = chamfer_h, r1 = tube_or - chamfer_h, r2 = tube_or);
        }
        translate([0, 0, -0.1])
            cylinder(h = insert_depth + 0.2, r = tube_ir);
    }
}

// One barb: a triangular ridge revolved around the clip's angular width.
// Its shoulder (the flat catch face) lines up with the far face of the
// material once the plug is fully inserted.
module clip_barb(angle_center) {
    shoulder_z = insert_depth - material_t;
    profile = [
        [tube_or, 0],
        [tube_or + barb_depth, -barb_shoulder],
        [tube_or, -barb_height]
    ];
    rotate([0, 0, angle_center - clip_width_deg / 2 + 1])
        translate([0, 0, shoulder_z])
            rotate_extrude(angle = clip_width_deg - 2)
                polygon(points = profile);
}

module clips() {
    for (i = [0 : num_clips - 1])
        clip_barb(i * clip_pitch_deg);
}

// One flex slot: cuts fully through the tube wall (and any barb material)
// between two adjacent clips, from the free end up to clip_top_margin
// below the flange, leaving that top ring solid to anchor the clips.
module clip_slot(angle_center) {
    slot_h = insert_depth - clip_top_margin;
    rotate([0, 0, angle_center - clip_gap_deg / 2])
        rotate_extrude(angle = clip_gap_deg)
            translate([0, -0.1])
                square([tube_or + barb_depth + 1, slot_h + 0.1]);
}

module clip_slots() {
    for (i = [0 : num_clips - 1])
        clip_slot(i * clip_pitch_deg + clip_pitch_deg / 2);
}

module flange() {
    translate([0, 0, insert_depth])
        cylinder(h = flange_t, r = flange_r);
}

module hole_plug() {
    union() {
        difference() {
            union() {
                insert_tube();
                clips();
            }
            clip_slots();
        }
        flange();
    }
}

hole_plug();
