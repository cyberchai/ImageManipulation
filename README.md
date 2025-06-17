# Image Manipulation

**Author:** Chaira Harder
**Project:** Image Manipulation and Filtering in MATLAB

---

#### Overview

This project demonstrates the use of matrix operations in digital image processing using MATLAB. Starting with a standard image (`thai.jpg`), various color filters and transformations including grayscale, sepia, red-channel isolation, hue rotation, and artistic effects like Warhol-style tiling and blurring are used.

---

#### Features

* Extract and manipulate RGB channels
* Apply grayscale and sepia tone transformations via matrix multiplication
* Rotate image hues with color rotation matrices
* Implement image flipping, cropping, darkening, and brightness enhancement
* Simulate Andy Warhol-style image tiling
* Blur an image using a custom-defined `blur()` function

---

#### How to Run

1. Place `thai.jpg` in your MATLAB project directory.
2. Run the script from MATLAB.
3. Generated figures will display each transformation.
4. Optional: Test the `blur()` function with different `wid` (blur width) values for custom effects.

---

#### Notes

* All transformations use pixel-wise or channel-wise manipulation with for-loops and matrix reshaping.
* Hue rotation uses a combination of predefined and trigonometric matrices to simulate real-world color shifting.
* The `blur()` function is manually implemented without using built-in filters (except for testing) for educational purposes.
