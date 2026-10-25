#!/usr/bin/env python3
"""
Parametric Name Keyring - Automated Batch Generator
Generates custom 3D printable STLs from a list of names using OpenSCAD CLI.

Usage:
    python batch_generator.py --names "Alice,Bob,Charlie" --out-dir ./output
    python batch_generator.py --file names.txt --out-dir ./output
"""

import argparse
import os
import subprocess
import sys
from concurrent.futures import ThreadPoolExecutor

SCAD_TEMPLATE = """
Font_name = "{font}";
Text = "{name}";
Rotation = {rotation};
Connect_dots = {connect_dots};
Dot_bridge_height_percent = {bridge_pct};

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

span = get_char_x_auto(Text, len(Text)-1);
cx = span / 2;
loop_x = -cx - 8.5;
loop_y = 0;
twist = {twist};
$fn = {fn};

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
"""

def find_openscad():
    candidates = [
        r'C:\Program Files\OpenSCAD\openscad.com',
        r'C:\Program Files\OpenSCAD\openscad.exe',
        'openscad'
    ]
    for c in candidates:
        if os.path.exists(c):
            return c
    return 'openscad'

def build_keyring(name, openscad_bin, out_dir, args):
    name_clean = name.strip()
    if not name_clean:
        return
    scad_code = SCAD_TEMPLATE.format(
        name=name_clean,
        font=args.font,
        rotation=args.rotation,
        connect_dots="true" if args.connect_dots else "false",
        bridge_pct=args.bridge_pct,
        twist=args.twist,
        fn=args.fn
    )
    scad_path = os.path.join(out_dir, f"{name_clean}.scad")
    stl_path = os.path.join(out_dir, f"{name_clean}.stl")
    png_path = os.path.join(out_dir, f"{name_clean}.png")

    with open(scad_path, 'w', encoding='utf-8') as f:
        f.write(scad_code)

    print(f"[*] Compiling {name_clean}.stl ...")
    subprocess.run([openscad_bin, '-o', stl_path, scad_path], check=True, capture_output=True)
    if args.render_png:
        subprocess.run([openscad_bin, '-o', png_path, '--imgsize=800,600', scad_path], capture_output=True)
    print(f"[✓] Finished {name_clean}.stl")

def main():
    parser = argparse.ArgumentParser(description="Batch generate 3D name keyrings")
    parser.add_argument("--names", help="Comma-separated list of names", default="Alice,Bob,Charlie")
    parser.add_argument("--file", help="File containing one name per line")
    parser.add_argument("--out-dir", default="./output", help="Directory to save output files")
    parser.add_argument("--font", default="Chewy", help="Font family name")
    parser.add_argument("--rotation", type=float, default=0, help="Preview rotation angle in degrees")
    parser.add_argument("--twist", type=float, default=-5, help="Twist angle in degrees")
    parser.add_argument("--connect-dots", action="store_true", default=True, help="Bridge floating dots on i and j")
    parser.add_argument("--bridge-pct", type=int, default=40, help="Recessed height percentage of dot bridge")
    parser.add_argument("--fn", type=int, default=32, help="OpenSCAD cylinder/circle facet resolution")
    parser.add_argument("--render-png", action="store_true", default=True, help="Also render PNG preview")
    parser.add_argument("--threads", type=int, default=4, help="Parallel worker threads")

    args = parser.parse_args()
    openscad_bin = find_openscad()
    os.makedirs(args.out_dir, exist_ok=True)

    names = []
    if args.file and os.path.exists(args.file):
        with open(args.file, 'r', encoding='utf-8') as f:
            names = [line.strip() for line in f if line.strip()]
    else:
        names = [n.strip() for n in args.names.split(',') if n.strip()]

    print(f"Starting batch generation of {len(names)} keyrings using {args.threads} workers...")
    with ThreadPoolExecutor(max_workers=args.threads) as executor:
        futures = [executor.submit(build_keyring, name, openscad_bin, args.out_dir, args) for name in names]
        for f in futures:
            f.result()
    print("All keyrings successfully generated!")

if __name__ == "__main__":
    main()
