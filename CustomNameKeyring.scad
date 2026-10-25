/*
   ================================================================================
   MAKERWORLD PARAMETRIC MODEL MAKER: CUSTOM NAME KEYRING
   ================================================================================
   Model ID: #961911 (Hayden Kong)
   File Name: CustomNameKeyring.scad / NameKeyringV1.6.scad
   100% Exact MakerWorld UI Compatibility + Stepped Heights + Real Dot Bridge + Auto/Manual Overlap
   ================================================================================
*/

/* [Text & Font] */

// for your keyring
Font_name = "Chewy"; // [ Anton, Chewy, Forte, Gloria Hallelujah, Lobster, Luckiest Guy, Open Sans Extrabold, Oswald, Pacifico, Press Start 2P, Racing Sans One, Sigmar One, Snap ITC]

// for your keyring
Text = "Elodie";

// of the preview
Rotation = 50; // [0:5:360]

// Connect floating dots on 'i' and 'j' to avoid mid-air printing
Connect_dots = true; // [true:Yes (Connected), false:No (Floating)]

// Height percentage of the dot bridge (40% retains full strength while keeping top-surface aesthetics)
Dot_bridge_height_percent = 40; // [20:5:100]

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

/* [ Loop Settings ] */

// adjustment (used when Auto_Spacing is disabled)
Loop_x_position = 10; // [-150:1:50]

// adjustment
Loop_y_position = 0; // [-20:1:20]

// to use (default : o)
Loop_character = "o";

// to use (default : Chewy)
Loop_font = "Chewy"; // [ Anton, Chewy, Forte, Gloria Hallelujah, Lobster, Luckiest Guy, Open Sans Extrabold, Oswald, Pacifico, Press Start 2P, Racing Sans One, Sigmar One, Snap ITC]

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
calc_loop_x = Auto_Spacing ? (-calc_center - 8.5) : (-center - Loop_x_position);

rotate([0, 0, Rotation]) {

    // Loop
    linear_extrude(height = 3, $fn = 50) {
        translate ([calc_loop_x, Loop_y_position, 0]) rotate([0, 0, -90]) 
            text(size = 20, text = Loop_character, font = Loop_font, halign = "center", valign = "center", $fn = 50);
    }

    // Letters
    for (i = [0 : len(Text) - 1]) {
        h = (i < len(height)) ? height[i] : ((i % 2 == 0) ? 6.0 : 3.6);
        char = Text[i];
        char_x = get_char_x(i) - calc_center;

        // Main letter extrusion (full height h)
        linear_extrude(height = h, twist = twist, $fn = 50) {
            translate ([char_x, 0, 0])
                text(size = 25, text = char, font = Font_name, halign = "center", valign = "center", $fn = 50);
        }

        // Recessed dot bridge (recessed height keeps top-surface aesthetics clean)
        if (Connect_dots) {
            bridge_factor = Dot_bridge_height_percent / 100;
            bridge_h = h * bridge_factor;
            bridge_twist = twist * bridge_factor;
            if (char == "i") {
                linear_extrude(height = bridge_h, twist = bridge_twist, $fn = 50)
                    translate([char_x, 0, 0])
                        translate([-1.2, 6.5]) square([2.4, 4.0]);
            }
            if (char == "j") {
                linear_extrude(height = bridge_h, twist = bridge_twist, $fn = 50)
                    translate([char_x, 0, 0])
                        translate([-1.2, 11.0]) square([2.4, 4.0]);
            }
        }
    }
}
