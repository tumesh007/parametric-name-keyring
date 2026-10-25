/*
   ================================================================================
   ALL 10 CUSTOM NAME KEYRINGS ON BAMBU LAB A1 MINI BUILD PLATE (180 x 180 mm)
   ================================================================================
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
twist = -5;
$fn = 32;

function char_w(c) = 
    (c == "m" || c == "w") ? 15.0 :
    (c == "i" || c == "l") ? 5.2 :
    (c == "j" || c == "t" || c == "f") ? 7.5 :
    (c >= "A" && c <= "Z") ? 14.0 :
    10.5;

function get_step_at(text, i) = 
    (i <= 0) ? 0 :
    ((char_w(text[i-1]) + char_w(text[i])) / 2 * 0.95);

function get_char_x_auto(text, i) = 
    (i <= 0) ? 0 : (get_char_x_auto(text, i - 1) + get_step_at(text, i));

module single_keyring(text_str) {
    span = get_char_x_auto(text_str, len(text_str)-1);
    cx = span / 2;
    loop_x = -cx - 8.5;
    loop_y = 0;

    union() {
        // Loop
        color("DimGray")
        linear_extrude(height = 3, $fn = $fn)
            translate([loop_x, loop_y, 0]) rotate([0, 0, -90])
                text(size = 20, text = "o", font = Font_name, halign = "center", valign = "center", $fn = $fn);

        // Letters
        for (i = [0 : len(text_str) - 1]) {
            h = (i == 0) ? 8.0 : ((i % 2 == 0) ? 6.0 : 3.6);
            char = text_str[i];
            char_x = get_char_x_auto(text_str, i) - cx;

            color([0.92, 0.72, 0.1]) {
                linear_extrude(height = h, twist = twist, $fn = $fn)
                    translate([char_x, 0, 0])
                        text(size = 25, text = char, font = Font_name, halign = "center", valign = "center", $fn = $fn);

                if (Connect_dots) {
                    bridge_factor = Dot_bridge_height_percent / 100;
                    bridge_h = h * bridge_factor;
                    bridge_twist = twist * bridge_factor;
                    if (char == "i") {
                        linear_extrude(height = bridge_h, twist = bridge_twist, $fn = $fn)
                            translate([char_x, 0, 0])
                                translate([-1.2, 6.5]) square([2.4, 4.0]);
                    }
                    if (char == "j") {
                        linear_extrude(height = bridge_h, twist = bridge_twist, $fn = $fn)
                            translate([char_x, 0, 0])
                                translate([-1.2, 11.0]) square([2.4, 4.0]);
                    }
                }
            }
        }
    }
}

// Visual Bed Outline (180 x 180 mm A1 Mini build plate)
if (Show_Bed_Outline) {
    %color([0.22, 0.22, 0.25, 0.35])
        translate([0, 0, -0.5])
            cube([180, 180, 0.5], center = true);
    %color("white")
        translate([0, -83, 0.1])
            text("BAMBU LAB A1 MINI (180 x 180 mm)", size = 5.5, halign = "center", valign = "center");
}

// 10 Keyrings Layout (Centered Symmetrically on A1 Mini Bed)
scale([Scale, Scale, Scale]) {
    // Left Column
    translate([-32.1,  66.7, 0]) single_keyring("Shivansh");
    translate([-34.1,  32.7, 0]) single_keyring("Tumesh");
    translate([-34.1,  -1.3, 0]) single_keyring("Luvish");
    translate([-34.1, -35.3, 0]) single_keyring("Pulkit");
    translate([-34.1, -69.3, 0]) single_keyring("Rupali");

    // Right Column
    translate([ 55.9,  66.7, 0]) single_keyring("Pooja");
    translate([ 53.9,  32.7, 0]) single_keyring("Nancy");
    translate([ 53.9,  -1.3, 0]) single_keyring("Honey");
    translate([ 53.9, -35.3, 0]) single_keyring("Karan");
    translate([ 53.9, -69.3, 0]) single_keyring("Varun");
}
