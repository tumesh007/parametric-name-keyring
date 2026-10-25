/*
   ================================================================================
   MAKERWORLD PARAMETRIC MODEL MAKER: CUSTOM NAME KEYRING
   ================================================================================
   Model ID: #961911 (Hayden Kong)
   File Name: CustomNameKeyring.scad / NameKeyringV1.6.scad
   100% Exact MakerWorld UI Compatibility + Stepped Heights + Real Dot Bridge
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

/* [Spacing and Height] */

letter_1_height = 8.0; // [-20:0.5:20]
letter_1_space = 10; // [-20:1:20]

letter_2_height = 3.6; // [-20:0.5:20]
letter_2_space = 8; // [-20:1:20]

letter_3_height = 6.0; // [-20:0.5:20]
letter_3_space = 9; // [-20:1:20]

letter_4_height = 3.6; // [-20:0.5:20]
letter_4_space = 9; // [-20:1:20]

letter_5_height = 6.0; // [-20:0.5:20]
letter_5_space = 8.6; // [-20:1:20]

letter_6_height = 3.6; // [-20:0.5:20]
letter_6_space = 14; // [-20:1:20]

letter_7_height = 6.0; // [-20:0.5:20]
letter_7_space = 9.5; // [-20:1:20]

letter_8_height = 3.6; // [-20:0.5:20]
letter_8_space = 9.7; // [-20:1:20]

letter_9_height = 6.0; // [-20:0.5:20]
letter_9_space = 9.6; // [-20:1:20]

letter_10_height = 3.6; // [-20:0.5:20]
letter_10_space = 9.6; // [-20:1:20]

letter_11_height = 6.0; // [-20:0.5:20]
letter_11_space = 9.4; // [-20:1:20]

letter_12_height = 3.6; // [-20:0.5:20]
letter_12_space = 9.5; // [-20:1:20]

letter_13_height = 6.0; // [-20:0.5:20]
letter_13_space = 20; // [-20:1:20]

/* [ Twist ] */

// angle in degrees
twist = -5; // [-10:0.5:10]

// of twist rotation
center = 30; // [0:1:70]

/* [ Loop Settings ] */

// adjument
Loop_x_position = 10; // [-150:1:50]

// adjument
Loop_y_position = 0; // [-20:1:20]

// to use (default : u)
Loop_character = "o";

// to use (default : Chewy)
Loop_font = "Chewy"; // [ Anton, Chewy, Forte, Gloria Hallelujah, Lobster, Luckiest Guy, Open Sans Extrabold, Oswald, Pacifico, Press Start 2P, Racing Sans One, Sigmar One, Snap ITC]

/* [Hidden] */

// between letters adjust the overlap (e.g. 5 letters = 5 comma seperated numbers [5,5,4.8,4.2,4,5,6])
spacing = [0,letter_1_space,letter_2_space,letter_3_space,letter_4_space,letter_5_space,letter_6_space,letter_7_space, letter_8_space,letter_9_space,letter_10_space,letter_11_space,letter_12_space,letter_13_space];

// of each letter (e.g. 5 letters = 5 comma seperated numbers [4,3,3.5,3,4])
height = [letter_1_height,letter_2_height,letter_3_height,letter_4_height,letter_5_height,letter_6_height,letter_7_height,letter_8_height,letter_9_height,letter_10_height,letter_11_height,letter_12_height,letter_13_height];

rotate([0,0,Rotation]) {

    // Loop
    linear_extrude(height = 3, $fn = 100) {
        translate ([-center-Loop_x_position,Loop_y_position,0]) rotate([0,0,-90]) 
        text(size = 20, text = Loop_character, font = Loop_font, halign = "center", valign= "center", $fn = 100);
    }

    // Letters
    for (i = [0 : len(Text) -1]) {
        h = (i < len(height)) ? height[i] : ( (i % 2 == 0) ? 6.0 : 3.6 );
        sp = (i < len(spacing)) ? spacing[i] : 9.5;
        char = Text[i];
        char_x = (sp*i)-center;

        // Main letter extrusion (full height h)
        linear_extrude(height = h, twist = twist, $fn = 100) {
            translate ([char_x, 0, 0])
                text(size = 25, text = char, font = Font_name, halign = "center", valign = "center", $fn = 100);
        }

        // Recessed dot bridge (recessed height keeps top-surface aesthetics clean)
        if (Connect_dots) {
            bridge_factor = Dot_bridge_height_percent / 100;
            bridge_h = h * bridge_factor;
            bridge_twist = twist * bridge_factor;
            if (char == "i") {
                linear_extrude(height = bridge_h, twist = bridge_twist, $fn = 100)
                    translate([char_x, 0, 0])
                        translate([-1.2, 6.5]) square([2.4, 4.0]);
            }
            if (char == "j") {
                linear_extrude(height = bridge_h, twist = bridge_twist, $fn = 100)
                    translate([char_x, 0, 0])
                        translate([-1.2, 11.0]) square([2.4, 4.0]);
            }
        }
    }
}
