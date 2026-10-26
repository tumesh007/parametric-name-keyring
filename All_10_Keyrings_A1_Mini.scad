/*
   ================================================================================
   ALL 10 CUSTOM NAME KEYRINGS ON BAMBU LAB A1 MINI BUILD PLATE (180 x 180 mm)
   ================================================================================
   Model on MakerWorld: https://makerworld.com/en/models/3490868-parametric-custom-name-keyring
   Names included:
   Left Column:  1. Shivansh, 2. Tumesh, 3. Luvish, 4. Pulkit, 5. Rupali
   Right Column: 6. Pooja,    7. Nancy,  8. Honey,  9. Karan,  10. Varun
   ================================================================================
*/

/* [Plate Configuration] */
// Uniform scale for all keyrings (0.88 fits 10 keyrings comfortably on A1 Mini with generous clearance)
Scale = 0.88; // [0.70:0.01:1.00]

// Show the 180x180 mm A1 Mini bed outline in preview (auto-hidden in STL)
Show_Bed_Outline = true;

/* [Settings] */
Font_name = "Chewy";
Connect_dots = true;
Dot_bridge_height_percent = 40;
Keyhole_diameter = 4.0;
Loop_wall_thickness = 2.8;
Loop_height = 3.2;
twist = -5;
$fn = 36;

function char_w(c) = 
    (c == "m" || c == "w" || c == "M" || c == "W") ? 15.0 :
    (c == "i" || c == "l" || c == "I") ? 5.2 :
    (c == "j" || c == "t" || c == "f") ? 7.5 :
    (c >= "A" && c <= "Z") ? 14.0 :
    10.5;

function get_step_at(text, i) = 
    (i <= 0) ? 0 :
    (((char_w(text[i-1]) + char_w(text[i])) / 2) - 1.8);

function get_char_x_auto(text, i) = 
    (i <= 0) ? 0 : (get_char_x_auto(text, i - 1) + get_step_at(text, i));

module single_keyring(text_str, loop_x_off = 0, loop_y_off = 0) {
    span = get_char_x_auto(text_str, len(text_str)-1);
    cx = span / 2;
    loop_outer_r = (Keyhole_diameter / 2) + Loop_wall_thickness;
    first_char_left = -cx - (char_w(text_str[0]) / 2);
    calc_loop_x = first_char_left - loop_outer_r + 2.0;
    loop_x = calc_loop_x + loop_x_off;
    loop_y = loop_y_off;
    tab_reach = max(loop_outer_r + 3.0, (first_char_left - loop_x) + 2.5);

    union() {
        // Engineering 4mm Keyhole Eyelet
        translate([loop_x, loop_y, 0]) {
            linear_extrude(height = Loop_height, $fn = $fn) {
                difference() {
                    union() {
                        circle(r = loop_outer_r, $fn = $fn);
                        polygon(points = [
                            [0, loop_outer_r],
                            [tab_reach, loop_outer_r * 0.75],
                            [tab_reach, -loop_outer_r * 0.75],
                            [0, -loop_outer_r]
                        ]);
                    }
                    circle(r = Keyhole_diameter / 2, $fn = $fn);
                }
            }
        }

        // Letters + Exact Dot Bridges
        for (i = [0 : len(text_str) - 1]) {
            h = (i == 0) ? 8.0 : ((i % 2 == 0) ? 6.0 : 3.6);
            char = text_str[i];
            char_x = get_char_x_auto(text_str, i) - cx;

            linear_extrude(height = h, twist = twist, $fn = $fn) {
                translate([char_x, 0, 0])
                    text(size = 25, text = char, font = Font_name, halign = "center", valign = "center", $fn = $fn);
            }

            if (Connect_dots && (char == "i" || char == "j")) {
                bridge_factor = Dot_bridge_height_percent / 100;
                bridge_h = h * bridge_factor;
                bridge_twist = twist * bridge_factor;
                if (char == "i") {
                    linear_extrude(height = bridge_h, twist = bridge_twist, $fn = $fn)
                        translate([char_x, 0, 0])
                            translate([-1.2, 6.5]) square([2.5, 3.6]);
                }
                if (char == "j") {
                    linear_extrude(height = bridge_h, twist = bridge_twist, $fn = $fn)
                        translate([char_x, 0, 0])
                            translate([-1.5, 11.0]) square([2.8, 3.6]);
                }
            }
        }
    }
}

// 180 x 180 mm A1 Mini Bed Boundary Helper
if ($preview && Show_Bed_Outline) {
    %color([0.2, 0.7, 0.3, 0.15])
        translate([0, 0, -0.5])
            cube([180, 180, 1], center = true);
}

// Placed Keyrings on Build Plate (Scale 0.88x)
scale([Scale, Scale, Scale]) {
    // Left Column (X = -42 mm)
    translate([-42.0 / Scale,  64.0 / Scale, 0]) single_keyring("Shivansh");
    translate([-42.0 / Scale,  32.0 / Scale, 0]) single_keyring("Tumesh", loop_x_off = 3.0); // Inward fusion uniting T and u
    translate([-42.0 / Scale,   0.0 / Scale, 0]) single_keyring("Luvish");
    translate([-42.0 / Scale, -32.0 / Scale, 0]) single_keyring("Pulkit");
    translate([-42.0 / Scale, -64.0 / Scale, 0]) single_keyring("Rupali");

    // Right Column (X = +42 mm)
    translate([ 42.0 / Scale,  64.0 / Scale, 0]) single_keyring("Pooja");
    translate([ 42.0 / Scale,  32.0 / Scale, 0]) single_keyring("Nancy");
    translate([ 42.0 / Scale,   0.0 / Scale, 0]) single_keyring("Honey");
    translate([ 42.0 / Scale, -32.0 / Scale, 0]) single_keyring("Karan");
    translate([ 42.0 / Scale, -64.0 / Scale, 0]) single_keyring("Varun");
}
