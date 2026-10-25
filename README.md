# 🏷️ Parametric 3D Printable Name Keyring Studio

[![License: CC BY-NC-SA 4.0](https://img.shields.io/badge/License-CC_BY--NC--SA_4.0-lightgrey.svg)](LICENSE)
[![Format: STL & SCAD](https://img.shields.io/badge/Format-STL_%26_OpenSCAD-blue.svg)](models/)
[![Live 3D WebApp](https://img.shields.io/badge/Web_App-Live_3D_Studio-brightgreen.svg)](https://tumesh007.github.io/parametric-name-keyring/)
[![MakerWorld Model](https://img.shields.io/badge/MakerWorld-%23961911-orange.svg)](https://makerworld.com/en/models/961911)
[![Bambu Lab A1 Mini](https://img.shields.io/badge/Platform-Bambu_A1_Mini-darkgreen.svg)](models/All_10_Keyrings_A1_Mini.stl)

An advanced parametric 3D printable name keyring generator and complete production pipeline. Features alternating stepped 3D letter heights (+15-20% depth separation), 40% recessed under-bridges for floating dots on `i` & `j`, smart automatic kerning, and a pre-arranged 10-keyring batch plate ready for the **Bambu Lab A1 Mini ($180 \times 180\,\text{mm}$)**.

🌐 **Try the Live Browser WebApp**: [https://tumesh007.github.io/parametric-name-keyring/](https://tumesh007.github.io/parametric-name-keyring/)

---

## 📸 Showcase Gallery

| Full 10-Keyring A1 Mini Plate (Isometric) | Top-Down Symmetrical Bed Layout (180x180mm) |
| :---: | :---: |
| ![A1 Mini Plate Isometric](docs/images/All_10_Keyrings_A1_Mini.png) | ![Top Down Plate Layout](docs/images/plate_top_full.png) |

| Recessed 40% Under-Bridge ('i' in Shivansh) | Recessed 40% Under-Bridge ('j' in Pooja) |
| :---: | :---: |
| ![Shivansh i Close Up](docs/images/shivansh_close_up.png) | ![Pooja j Close Up](docs/images/pooja_close_up.png) |

---

## ⚡ Key Engineering Upgrades

### 1. The Floating Dot Problem Solved (40% Recessed Under-Bridge)
In playful fonts like **Chewy**, lowercase `i` and `j` have disconnected round dots. Standard bridging approaches either print in mid-air (causing spaghetti failures) or add a full-height bar that deforms the circular silhouette into an ugly teardrop.

This project introduces a **proportional 40% recessed under-bridge**:
- **Aesthetic Top 60%**: Completely open gap. From the top and front reading angles, the dot appears 100% circular, detached, and authentic to the font design.
- **Structural Bottom 40%**: A solid base bridge spanning $Z \in [0, 0.40 \times h]$ ($\approx 1.5 - 2.4\,\text{mm}$ thick, 8 to 12 solid plastic layers) solidly anchors the dot to the stem and print bed.

### 2. High-Contrast Stepped 3D Letter Heights
Alternating heights create visual pop and tactile depth:
- **Capital 1st Letter**: $8.0\,\text{mm}$
- **Even Letters (2nd, 4th, 6th...)**: $3.6\,\text{mm}$
- **Odd Letters (3rd, 5th, 7th...)**: $6.0\,\text{mm}$
- **Loop Eyelet**: $3.0\,\text{mm}$
- **Helical Twist**: $-5.0^\circ$ continuous z-axis torsion.

### 3. Smart Width-Classification Kerning
Prevents narrow characters (`i`, `l`) from drifting apart while giving wide characters (`m`, `w`) sufficient breathing room:
```openscad
function char_w(c) = 
    (c == "m" || c == "w") ? 15.0 :
    (c == "i" || c == "l") ? 5.2 :
    (c == "j" || c == "t" || c == "f") ? 7.5 :
    (c >= "A" && c <= "Z") ? 14.0 :
    10.5;
```

---

## 🖨️ Bambu Lab A1 Mini Batch Print Plate

A full 10-keyring batch is pre-sliced and pre-arranged on an exact $180 \times 180\,\text{mm}$ build plate:
- **Models Included**:
  - Left Column: `Shivansh`, `Tumesh`, `Luvish`, `Pulkit`, `Rupali`
  - Right Column: `Pooja`, `Nancy`, `Honey`, `Karan`, `Varun`
- **Scale Factor**: $0.88\times$ (88%)
- **Overall Footprint**: $146.10\,\text{mm} \times 149.48\,\text{mm}$
- **Edge Clearances**: $\sim 17\,\text{mm}$ safety margin from left/right edges, $\sim 15\,\text{mm}$ safety margin from front/back edges.
- **Download**: [`models/All_10_Keyrings_A1_Mini.stl`](models/All_10_Keyrings_A1_Mini.stl)

---

## 🌐 Interactive 3D WebApp (GitHub Pages)

Experience the live in-browser 3D studio powered by Three.js and OpenType:
- **Live 3D Preview**: Rotate, zoom, and inspect in real time.
- **Parametric Sliders**: Change text, heights, twist angle, dot bridge %, and eyelet loop.
- **One-Click Instant STL Download**: Browser-side binary STL export.
- **Filament Color Swatches**: Preview in Bambu Gold, Silk Silver, Jade White, Matte Black, and more.
- 🔗 **Launch App**: [https://tumesh007.github.io/parametric-name-keyring/](https://tumesh007.github.io/parametric-name-keyring/)

---

## 💻 Automated Headless CLI Batch Generator

Generate custom name keyrings programmatically using Python and OpenSCAD:

```bash
# Generate from comma-separated names:
python batch_generator.py --names "Emma,Oliver,Lucas,Sophia" --out-dir ./output

# Generate from a text file (one name per line):
python batch_generator.py --file names.txt --out-dir ./output --threads 4
```

---

## 🖨️ Recommended Slicer Settings

| Parameter | Bambu Studio / OrcaSlicer | PrusaSlicer |
| :--- | :--- | :--- |
| **Layer Height** | **0.16 mm** or **0.20 mm** | **0.16 mm** |
| **Wall Loops** | **3 to 4 walls** (1.2 - 1.6 mm) | **3 to 4 perimeters** |
| **Top / Bottom Shells** | 4 Top / 4 Bottom | 4 Top / 4 Bottom |
| **Infill** | 20% Gyroid or Cross Hatch | 20% Gyroid |
| **Supports** | **NONE** (100% support-free) | **NONE** |
| **Brim** | Not required on textured PEI | Optional |
| **Material** | PLA, PLA+, Silk PLA, or PETG | PLA / PETG |

---

## 📜 Attribution & License

- **Original Concept**: Based on *"Custom Name Keyring"* by **Hayden Kong** ([MakerWorld Model #961911](https://makerworld.com/en/models/961911-custom-name-keyring#profileId-931954)).
- **Parametric OpenSCAD Architecture, Dot Bridge Geometry, Batch Plate & WebApp**: Developed by [tumesh007](https://github.com/tumesh007).
- **License**: Released under the [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)](LICENSE) license.
