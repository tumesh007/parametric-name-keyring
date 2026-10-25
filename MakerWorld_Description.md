# 🏷️ Parametric Custom Name Keyring (Stepped 3D Heights + Under-Bridge Floating Dot Fix)

> **Based on Hayden Kong's Custom Name Keyring (#961911)**, upgraded with genuine alternating stepped 3D letter heights (+15-20% depth separation), 40% recessed under-bridges for floating dots on `i` & `j`, smart automatic kerning, and a pre-arranged 10-keyring batch plate ready for the **Bambu Lab A1 Mini (180 x 180 mm)**!

---

## 🌟 What's New & Upgraded

1. **Classic Stepped Heights**:
   - Capital 1st Letter: **8.0 mm** (bold, thick, solid anchor)
   - Even Letters (2nd, 4th, 6th...): **3.6 mm**
   - Odd Letters (3rd, 5th, 7th...): **6.0 mm**
   - Gives high-contrast depth, tactile feel, and eliminates boring flat top surfaces.

2. **Under-Bridge Floating Dot Fix (for 'i' & 'j')**:
   - **The Problem**: Lowercase `i` and `j` in font Chewy have disconnected round dots that print in mid-air unless manually joined. Standard bridges ruin the round silhouette of the dot.
   - **The Solution**: An under-bridge recessed to **40% of the letter height** ($Z \in [0, 0.40 \times h]$). From the top view, the dot appears 100% round and separated. From underneath, it is anchored with 6 to 12 solid plastic layers!

3. **Smart Character-Aware Kerning**:
   - Built-in width-classification prevents narrow letters (`l`, `i`) from separating and wide letters (`m`, `w`) from overlapping too heavily.

4. **10-Keyring Bambu Lab A1 Mini Batch Plate**:
   - Pre-arranged, centered, and scaled ($0.88\times$) on an exact $180 \times 180\,\text{mm}$ build plate with safe $15\,\text{mm}$ edge margins.

5. **Live Interactive 3D WebApp**:
   - Don't have OpenSCAD? Open our GitHub WebApp in your browser, type any name, inspect in real-time 3D, and download your STL with 1 click!
   - 🌐 [https://tumesh007.github.io/parametric-name-keyring/](https://tumesh007.github.io/parametric-name-keyring/)

---

## 🖨️ Recommended Print Settings (Bambu Studio / OrcaSlicer)

| Setting | Recommendation | Reason |
| :--- | :--- | :--- |
| **Printer** | Bambu Lab A1 Mini / A1 / P1S / X1C | Designed to fit within $180 \times 180\,\text{mm}$ |
| **Nozzle** | 0.4 mm (or 0.2 mm for miniature text) | Standard 0.4mm produces sharp, clean curves |
| **Layer Height** | **0.16 mm** or **0.20 mm** | 0.16mm provides ultra-smooth top chamfers and fillets |
| **Wall Loops** | **3 to 4 walls** (1.2 - 1.6 mm) | Makes the entire outer shell 100% solid perimeter |
| **Top / Bottom Shells** | 4 Top / 4 Bottom | Clean, watertight top ironing surfaces |
| **Infill** | 20% Gyroid or Cross Hatch | Excellent torsional rigidity |
| **Supports** | **NONE required!** | 100% printable directly on the build plate |
| **Brim** | Auto / Mouse-ears (if bed adhesion is weak) | Usually not required on clean textured PEI |
| **Filament** | PLA, PLA+, Matte PLA, or PETG | Bambu PLA Basic / Matte works flawlessly |

---

## 🎨 Multi-Color Printing Tips (Bambu AMS)

Want multi-color letters like the MakerWorld showcase?
- **Layer-Based Color Swap**: In Bambu Studio, right-click the preview layer slider:
  - Base layers ($0.0 - 3.0\,\text{mm}$): Loop color (e.g., Black / Dim Gray)
  - Lower letters ($3.0 - 3.6\,\text{mm}$): Accent color
  - Medium letters ($3.6 - 6.0\,\text{mm}$): Secondary color
  - Capital & accents ($6.0 - 8.0\,\text{mm}$): Bright highlight color
- **AMS Filament Painting**: Use the Bucket Fill or Height Fill tool in Bambu Studio to paint letter faces in contrasting colors!

---

## 📦 Included Pre-Sliced Models Catalog

1. **`All_10_Keyrings_A1_Mini.stl`**: Full 10-piece production batch plate:
   - Left Column: `Shivansh`, `Tumesh`, `Luvish`, `Pulkit`, `Rupali`
   - Right Column: `Pooja`, `Nancy`, `Honey`, `Karan`, `Varun`
2. **Individual STLs (Full Size, 25mm Font)**:
   - `Shivansh.stl`
   - `Tumesh.stl`
   - `Nancy.stl`
   - `Luvish.stl`
   - `Honey.stl`
   - `Karan.stl`
   - `Pooja.stl`
   - `Pulkit.stl`
   - `Varun.stl`
   - `Rupali.stl`

---

## 🛠️ How to Customize in OpenSCAD

1. Open [`CustomNameKeyring.scad`](CustomNameKeyring.scad) in [OpenSCAD](https://openscad.org/).
2. Change the `Text = "YourName";` parameter.
3. Adjust sliders:
   - `letter_X_height`: Customize letter heights.
   - `Dot_bridge_height_percent`: 40% (recessed) or 100% (flush).
   - `twist`: -5° to +5° for subtle helical flair.
4. Press `F5` to preview, `F6` to render, and `F7` to export your STL!

---

## 📜 Attribution

- Original concept by **Hayden Kong** ([MakerWorld #961911](https://makerworld.com/en/models/961911-custom-name-keyring#profileId-931954)).
- Enhanced parametric OpenSCAD architecture, under-bridge dot fix, A1 Mini plate arrangement, and GitHub WebApp by **[tumesh007](https://github.com/tumesh007)**.
- Font: **Chewy** by Sideshow / Squid (Apache 2.0 / Google Fonts).
