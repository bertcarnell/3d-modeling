// ============================================================
//  Stationary Medical Workstation
//  Flat-screen monitor + keyboard tray on a V-foot stand
//  Designed for a standing user
// ============================================================

$fn = 48;

// ============================================================
//  DIMENSIONS  (mm)   --  all heights are from the floor
// ============================================================

// --- V-Foot Base ---
foot_count   =   4;    // number of legs radiating from column
foot_length  = 320;    // length of each leg (column center -> tip)
foot_w_hub   =  55;    // leg width at the hub
foot_w_tip   =  22;    // leg width at the tip
foot_h_hub   =  55;    // leg height at the hub
foot_h_tip   =  14;    // leg height at the tip
glide_dia    =  34;    // floor glide pad diameter
glide_h      =   6;
hub_dia      =  110;   // central hub diameter
hub_h        =   60;

// --- Column (vertical pole) ---
col_dia        = 70;
col_height     = 1150;   // from top of base hub to bottom of monitor head

// --- Keyboard tray ---
tray_w         = 480;
tray_d         = 220;
tray_t         =  18;
tray_z         = 1020;   // top surface ~ standing keyboard height (~40")

// --- Monitor ---
mon_screen_w   = 540;    // ~24" 16:9
mon_screen_h   = 320;
mon_bezel      =  10;
mon_thick      =  35;
mon_z_center   = 1500;   // eye level for ~5'8" standing user

// --- Monitor arm / VESA mount ---
arm_len        = 90;
arm_thick      = 28;

// --- Work surface (small shelf above tray, below monitor) ---
shelf_w        = 360;
shelf_d        = 200;
shelf_t        =  14;
shelf_z        = 1180;

// Top of base (where the column starts)
base_top_z = glide_h + hub_h;

// ============================================================
//  COLORS  (medical / clinical palette)
// ============================================================
col_base       = [0.92, 0.92, 0.94];   // off-white plastic
col_column     = [0.78, 0.80, 0.83];   // light gray
col_metal      = [0.65, 0.67, 0.70];   // brushed aluminum
col_tray       = [0.95, 0.95, 0.96];   // white tray
col_keyboard   = [0.20, 0.22, 0.25];   // dark keyboard
col_keys       = [0.85, 0.85, 0.88];
col_monitor    = [0.10, 0.10, 0.12];   // monitor bezel
col_screen_lit = [0.85, 0.92, 0.98];   // lit screen
col_glide      = [0.15, 0.15, 0.17];   // rubber foot glide
col_accent     = [0.10, 0.45, 0.70];   // medical blue accent

// ============================================================
//  HELPERS
// ============================================================
module rounded_plate(w, d, h, r) {
    hull() {
        for (sx=[-1,1], sy=[-1,1])
            translate([sx*(w/2 - r), sy*(d/2 - r), 0])
                cylinder(r=r, h=h, center=true);
    }
}

// ============================================================
//  V-FOOT BASE
//  Central hub with tapered legs radiating outward like a star;
//  each leg slopes downward from the hub to a floor glide.
// ============================================================
module v_foot_leg() {
    // Build one leg lying along +X.
    // Hull between a tall block at the hub end and a thin pad at the tip.
    hull() {
        // Hub end: tall, wide
        translate([hub_dia/2 - 10, 0, foot_h_hub/2 + glide_h])
            cube([10, foot_w_hub, foot_h_hub], center=true);

        // Tip end: short, narrow, on the floor
        translate([foot_length, 0, foot_h_tip/2 + glide_h])
            cube([10, foot_w_tip, foot_h_tip], center=true);
    }

    // Floor glide at the tip
    color(col_glide)
    translate([foot_length, 0, glide_h/2])
        cylinder(d=glide_dia, h=glide_h, center=true);
}

module v_foot_base() {
    // Central hub
    color(col_base)
    translate([0, 0, glide_h + hub_h/2])
        cylinder(d=hub_dia, h=hub_h, center=true);

    // Decorative cap on top of hub
    color(col_accent)
    translate([0, 0, glide_h + hub_h])
        cylinder(d=hub_dia - 20, h=4);

    // Radiating legs
    color(col_base)
    for (i = [0 : foot_count - 1]) {
        rotate([0, 0, i * (360 / foot_count) + 45])  // 45° offset = X pattern
            v_foot_leg();
    }
}

// ============================================================
//  VERTICAL COLUMN
// ============================================================
module column() {
    // Lower wider section (transitions from hub to column)
    color(col_column)
    translate([0, 0, base_top_z])
        cylinder(d1=col_dia + 30, d2=col_dia + 10, h=80);

    // Main column
    color(col_column)
    translate([0, 0, base_top_z + 80])
        cylinder(d=col_dia, h=col_height - 80);

    // Cable channel detail (front strip)
    color(col_metal)
    translate([0, col_dia/2 - 1, base_top_z + col_height/2 + 40])
        cube([12, 4, col_height - 120], center=true);

    // Height-adjust handle (small lever on side)
    color(col_accent)
    translate([col_dia/2 + 6, 0, base_top_z + 850])
        rotate([0, 90, 0])
            cylinder(d=10, h=40);
    color(col_metal)
    translate([col_dia/2 + 46, 0, base_top_z + 850])
        sphere(d=18);
}

// ============================================================
//  KEYBOARD TRAY (mounted directly to the central pole)
// ============================================================
module keyboard_tray() {
    // ---- Mounting collar that wraps around the column ----
    color(col_metal)
    translate([0, 0, tray_z - tray_t/2 - 5])
        difference() {
            cylinder(d=col_dia + 22, h=tray_t + 30, center=false);
            translate([0, 0, -1])
                cylinder(d=col_dia + 0.5, h=tray_t + 32);
        }

    // ---- Support arm from collar out to the tray ----
    color(col_metal)
    hull() {
        translate([0, col_dia/2 + 2, tray_z - tray_t/2])
            cube([50, 100, 30], center=true);
        translate([0, col_dia/2 + 70, tray_z - tray_t/2])
            cube([70, 100, 24], center=true);
    }

    // Underside support gusset (triangular brace)
    color(col_metal)
    translate([0, col_dia/2 + 35, tray_z - tray_t/2 - 18])
        rotate([45, 0, 0])
            cube([30, 30, 4], center=true);

    // ---- Tray itself (slightly tilted forward 5° for ergonomics) ----
    rotate([-5, 0, 0])
    translate([0, tray_d/2 + col_dia/2 + 30, tray_z]) {
        // Tray base
        color(col_tray)
            rounded_plate(tray_w, tray_d, tray_t, 12);

        // Raised lip at front
        color(col_tray)
        translate([0, -tray_d/2 + 6, tray_t/2 + 4])
            cube([tray_w - 20, 8, 8], center=true);

        // ----- Keyboard (centered on the tray) -----
        kb_w = 400;
        kb_d = 150;
        kb_h = 14;
        translate([0, 10, tray_t/2 + kb_h/2]) {
            // Keyboard body
            color(col_keyboard)
                rounded_plate(kb_w, kb_d, kb_h, 4);

            // Key area (recessed)
            color(col_keys)
            translate([0, 0, kb_h/2 - 1])
                rounded_plate(kb_w - 16, kb_d - 16, 4, 2);

            // Individual keys (simplified grid)
            for (row = [0:4]) {
                for (col = [0:14]) {
                    color(col_keys)
                    translate([
                        -kb_w/2 + 18 + col * 25,
                         kb_d/2 - 18 - row * 22,
                         kb_h/2 + 1
                    ])
                        rounded_plate(20, 18, 3, 1.5);
                }
            }

            // Spacebar
            color(col_keys)
            translate([0, -kb_d/2 + 18, kb_h/2 + 1])
                rounded_plate(160, 16, 3, 1.5);
        }
    }
}

// ============================================================
//  WORK SHELF (between keyboard & monitor)
// ============================================================
module work_shelf() {
    // Mounting bracket onto column
    color(col_metal)
    translate([0, col_dia/2, shelf_z - shelf_t/2])
        cube([40, 20, 24], center=true);

    color(col_tray)
    translate([0, shelf_d/2 + col_dia/2 - 5, shelf_z])
        rounded_plate(shelf_w, shelf_d, shelf_t, 10);

/*    // Barcode scanner holder (a common medical accessory)
    translate([shelf_w/2 - 50, shelf_d/2 + col_dia/2 + 30, shelf_z + shelf_t/2]) {
        color(col_keyboard)
            rounded_plate(60, 50, 30, 6);
        // Scanner gun (stylized)
        color([0.85, 0.10, 0.10])
        translate([0, 0, 30]) rotate([20, 0, 0]) {
            hull() {
                translate([0, 0, 0])  cylinder(d=30, h=2);
                translate([0, -10, 60]) sphere(d=22);
            }
            // Trigger area
            color(col_keyboard)
            translate([0, -15, 40])
                cube([12, 8, 18], center=true);
        }
    }*/
}

// ============================================================
//  MONITOR + ARM
// ============================================================
module monitor_arm_and_head() {
    arm_z = base_top_z + col_height;

    // Tilt knuckle at top of column
    color(col_metal)
    translate([0, 0, arm_z])
        sphere(d=col_dia + 10);

    // Arm extending forward
    color(col_metal)
    translate([0, arm_len/2, arm_z])
        rotate([90, 0, 0])
            cube([arm_thick, arm_thick, arm_len], center=true);

    // VESA plate
    color(col_metal)
    translate([-55, arm_len + 10 -20, arm_z-10])
        cube([110, 10, 210], center=false);

    // ---- Monitor head ----
    translate([0, arm_len + 18, mon_z_center])
        rotate([90, 0, 0])
        union() {
            // Back shell
            color(col_monitor)
                rounded_plate(mon_screen_w + mon_bezel*2,
                              mon_screen_h + mon_bezel*2,
                              mon_thick, 8);

            // Front bezel face
            color(col_monitor)
            translate([0, 0, mon_thick/2 - 1])
                rounded_plate(mon_screen_w + mon_bezel*2,
                              mon_screen_h + mon_bezel*2,
                              2, 8);

            // Screen (recessed slightly)
            color(col_screen_lit)
            translate([0, 0, mon_thick/2 + 0.2])
                cube([mon_screen_w, mon_screen_h, 0.5], center=true);

            // Manufacturer logo strip
            color(col_metal)
            translate([0, -mon_screen_h/2 - 4, mon_thick/2])
                cube([60, 4, 1], center=true);

            // Power LED
            color([0.2, 0.9, 0.3])
            translate([mon_screen_w/2 - 8, -mon_screen_h/2 - 5, mon_thick/2])
                cylinder(d=2.5, h=1);
        }
}

// ============================================================
//  ASSEMBLY
// ============================================================
v_foot_base();
column();
keyboard_tray();
work_shelf();
monitor_arm_and_head();
