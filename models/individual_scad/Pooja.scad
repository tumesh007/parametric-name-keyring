Font_name = "Chewy";
Text = "Pooja";
Rotation = 50;
Connect_dots = true;
Dot_bridge_height_percent = 40;

function char_w(c) = 
    (c == "m" || c == "w") ? 15.0 :
    (c == "i" || c == "l" || c == "j" || c == "t" || c == "f") ? 7.5 :
    (c >= "A" && c <= "Z") ? 14.0 :
    10.5;

function get_step_at(text, i) = 
    (i <= 0) ? 0 :
    ((char_w(text[i-1]) + char_w(text[i])) / 2 * 0.95);

function get_char_x_auto(text, i) = 
    (i <= 0) ? 0 : (get_char_x_auto(text, i - 1) + get_step_at(text, i));

span = get_char_x_auto(Text, len(Text)-1);
cx = span / 2;
loop_x = -cx - 8.5;
loop_y = 0;
twist = -5;
$fn = 32;

rotate([0, 0, Rotation]) {
    union() {
        // Loop
        color("DimGray")
        linear_extrude(height = 3, $fn = $fn)
            translate([loop_x, loop_y, 0]) rotate([0, 0, -90])
                text(size = 20, text = "o", font = Font_name, halign = "center", valign = "center", $fn = $fn);

        // Letters
        for (i = [0 : len(Text) - 1]) {
            h = (i == 0) ? 8.0 : ((i % 2 == 0) ? 6.0 : 3.6);
            char = Text[i];
            char_x = get_char_x_auto(Text, i) - cx;

            color([0.92, 0.72, 0.1]) {
                // Main letter extrusion (full height h)
                linear_extrude(height = h, twist = twist, $fn = $fn)
                    translate([char_x, 0, 0])
                        text(size = 25, text = char, font = Font_name, halign = "center", valign = "center", $fn = $fn);

                // Recessed bridge at 40% height (retains strength, preserves top surface aesthetics)
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
