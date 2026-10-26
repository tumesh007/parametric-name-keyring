/*
   ================================================================================
   MAKERWORLD PARAMETRIC MODEL MAKER: PARAMETRIC CUSTOM NAME KEYRING
   ================================================================================
   Model ID: #3490868
   Model URL: https://makerworld.com/en/models/3490868-parametric-custom-name-keyring
   Stepped 3D Heights + Standard 4mm Keyhole Eyelet + Exact Dot Bridges + Auto/Manual Overlap
   ================================================================================
*/

/* [Text & Font] */

// for your keyring
Font_name = "Chewy"; // [ Anton, Chewy, Forte, Gloria Hallelujah, Lobster, Luckiest Guy, Open Sans Extrabold, Oswald, Pacifico, Press Start 2P, Racing Sans One, Sigmar One, Snap ITC]

// for your keyring
Text = "Shivansh";

// of the preview
Rotation = 50; // [0:5:360]

// Connect floating dots on 'i' and 'j' to avoid mid-air printing
Connect_dots = true; // [true:Yes (Connected), false:No (Floating)]

// Height percentage of the dot bridge (40% retains full strength while keeping top-surface aesthetics)
Dot_bridge_height_percent = 40; // [20:5:100]

/* [Keyring Eyelet Settings] */

// Include left attachment loop
Include_loop = true; // [true:Yes, false:No]

// Standard inner keyhole diameter in mm
Keyhole_diameter = 4.0; // [3.0:0.5:8.0]

// Wall thickness around the keyhole in mm
Loop_wall_thickness = 2.8; // [2.0:0.2:5.0]

// Height / thickness of the eyelet tab in mm
Loop_height = 3.2; // [2.0:0.2:6.0]

// Horizontal position adjustment (closer/further from letter)
Loop_x_offset = 0; // [-15:0.5:15]

// Vertical position adjustment (up/down to match letter shape)
Loop_y_offset = 0; // [-15:0.5:15]

/* [Spacing & Overlap Mode] */

// Automatically arrange letter spacing using typographic widths
Auto_Spacing = true; // [true:Auto Continuous Fusion, false:Manual Per-Letter Sliders]

// Overlap between letters in mm (active when Auto_Spacing is enabled)
Auto_Overlap_mm = 1.8; // [0.5:0.1:4.0]

/* [Manual Spacing and Heights] */

letter_1_height = 8.0; // [-20:0.5:20]
letter_1_space = 8.5; // [-20:0.5:20]

letter_2_height = 3.6; // [-20:0.5:20]
letter_2_space = 8.5; // [-20:0.5:20]

letter_3_height = 6.0; // [-20:0.5:20]
letter_3_space = 8.5; // [-20:0.5:20]

letter_4_height = 3.6; // [-20:0.5:20]
letter_4_space = 8.5; // [-20:0.5:20]

letter_5_height = 6.0; // [-20:0.5:20]
letter_5_space = 8.5; // [-20:0.5:20]

letter_6_height = 3.6; // [-20:0.5:20]
letter_6_space = 8.5; // [-20:0.5:20]

letter_7_height = 6.0; // [-20:0.5:20]
letter_7_space = 8.5; // [-20:0.5:20]

letter_8_height = 3.6; // [-20:0.5:20]
letter_8_space = 8.5; // [-20:0.5:20]

letter_9_height = 6.0; // [-20:0.5:20]
letter_9_space = 8.5; // [-20:0.5:20]

letter_10_height = 3.6; // [-20:0.5:20]
letter_10_space = 8.5; // [-20:0.5:20]

letter_11_height = 6.0; // [-20:0.5:20]
letter_11_space = 8.5; // [-20:0.5:20]

letter_12_height = 3.6; // [-20:0.5:20]
letter_12_space = 8.5; // [-20:0.5:20]

letter_13_height = 6.0; // [-20:0.5:20]
letter_13_space = 8.5; // [-20:0.5:20]

/* [ Twist ] */

// angle in degrees
twist = -5; // [-10:0.5:10]

// of twist rotation (used when Auto_Spacing is disabled)
center = 30; // [0:1:70]

/* [Hidden] */

spacing = [0, letter_1_space, letter_2_space, letter_3_space, letter_4_space, letter_5_space, letter_6_space, letter_7_space, letter_8_space, letter_9_space, letter_10_space, letter_11_space, letter_12_space, letter_13_space];

height = [letter_1_height, letter_2_height, letter_3_height, letter_4_height, letter_5_height, letter_6_height, letter_7_height, letter_8_height, letter_9_height, letter_10_height, letter_11_height, letter_12_height, letter_13_height];

function char_w(c) =
    (c == "m" || c == "w" || c == "M" || c == "W") ? 15.0 :
    (c == "i" || c == "l" || c == "I") ? 5.2 :
    (c == "j" || c == "t" || c == "f") ? 7.5 :
    (c >= "A" && c <= "Z") ? 14.0 :
    10.5;

function get_step(i) =
    (i <= 0) ? 0 :
    (Auto_Spacing ?
        (((char_w(Text[i-1]) + char_w(Text[i])) / 2) - Auto_Overlap_mm) :
        ((i < len(spacing)) ? spacing[i] : 8.5));

function get_char_x(i) =
    (i <= 0) ? 0 : (get_char_x(i - 1) + get_step(i));

total_span = get_char_x(len(Text) - 1);
calc_center = Auto_Spacing ? (total_span / 2) : center;

loop_outer_r = (Keyhole_diameter / 2) + Loop_wall_thickness;
first_char_left = -calc_center - (char_w(Text[0]) / 2);
calc_loop_x = Auto_Spacing ? (first_char_left - loop_outer_r + 2.0) : (-center - 12.0);

loop_x = calc_loop_x + Loop_x_offset;
loop_y = Loop_y_offset;

// Dynamic tab reach ensuring solid penetration into the first letter
tab_reach = max(loop_outer_r + 4.0, (first_char_left - loop_x) + 6.0);

rotate([0, 0, Rotation]) {

    // Engineering Keyring Eyelet with 4.0 mm Keyhole & Custom X/Y Offsets
    if (Include_loop) {
        translate ([loop_x, loop_y, 0]) {
            linear_extrude(height = Loop_height, $fn = 60) {
                difference() {
                    union() {
                        circle(r = loop_outer_r, $fn = 60);
                        // Tangent fusion tab embedding into first letter
                        polygon(points = [
                            [0, loop_outer_r],
                            [tab_reach, loop_outer_r * 0.75],
                            [tab_reach, -loop_outer_r * 0.75],
                            [0, -loop_outer_r]
                        ]);
                    }
                    // Precision 4mm Circular Keyhole
                    circle(r = Keyhole_diameter / 2, $fn = 60);
                }
            }
        }
    }

    // Letters + Exact Dot Bridges
    for (i = [0 : len(Text) - 1]) {
        h = (i < len(height)) ? height[i] : ((i % 2 == 0) ? 6.0 : 3.6);
        char = Text[i];
        char_x = get_char_x(i) - calc_center;

        // Main letter extrusion (full height h)
        linear_extrude(height = h, twist = twist, $fn = 40) {
            translate ([char_x, 0, 0])
                text(size = 25, text = char, font = Font_name, halign = "center", valign = "center", $fn = 40);
        }

        // Recessed dot bridge (recessed height keeps top-surface aesthetics clean)
        if (Connect_dots && (char == "i" || char == "j")) {
            bridge_factor = Dot_bridge_height_percent / 100;
            bridge_h = h * bridge_factor;
            bridge_twist = twist * bridge_factor;
            
            // Bridge for 'i': spans from stem top (Y=7.2) into dot bottom (Y=9.4)
            if (char == "i") {
                linear_extrude(height = bridge_h, twist = bridge_twist, $fn = 40)
                    translate([char_x, 0, 0])
                        translate([-1.2, 6.5]) square([2.5, 3.6]);
            }
            
            // Bridge for 'j': spans from stem top (Y=11.9) into dot bottom (Y=13.9)
            if (char == "j") {
                linear_extrude(height = bridge_h, twist = bridge_twist, $fn = 40)
                    translate([char_x, 0, 0])
                        translate([-1.5, 11.0]) square([2.8, 3.6]);
            }
        }
    }
}
