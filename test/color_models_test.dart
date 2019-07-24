import 'package:test/test.dart';
import 'package:color_models/color_models.dart';

/// A set of colors containing black, white, grey, red, green,
/// blue, yellow, cyan, pink, 6 colors that fall into each part
/// of the hue spectrum, and 4 LAB colors that fall outside of
/// the sRGB color space's bounds.
const List<ColorModel> _testColors = <ColorModel>[
  RgbColor(0, 0, 0), // Black
  RgbColor(144, 144, 144), // Grey
  RgbColor(255, 255, 255), // White
  RgbColor(255, 0, 0), // red
  RgbColor(0, 255, 0), // green
  RgbColor(0, 0, 255), // blue
  RgbColor(255, 255, 0), // yellow
  RgbColor(0, 255, 255), // cyan
  RgbColor(255, 0, 255), // pink
  RgbColor(240, 111, 12), // Hue 26°
  RgbColor(102, 204, 51), // Hue 101°
  RgbColor(51, 204, 153), // Hue 161°
  RgbColor(12, 102, 153), // Hue 201°
  RgbColor(120, 42, 212), // Hue 267°
  RgbColor(209, 16, 110), // Hue 331°
  RgbColor(0, 49, 66),
  LabColor(100, 127, 127),
  LabColor(100, -128, -128),
  LabColor(60, 127, -128),
  LabColor(0, -128, 127),
];

/// The following tests convert each of the test colors from RGB
/// to each of the other color spaces. They are then converted
/// back to the RGB color space and are expected to equal the
/// original RGB color value.
void main() {
  test('CMYK Conversions', () {
    _testColors.forEach((ColorModel color) {
      final CmykColor cmykColor = color.toCmykColor();
      expect(color.equals(cmykColor), equals(true));
    });
  });

  test('HSI Conversions', () {
    _testColors.forEach((ColorModel color) {
      final HsiColor hsiColor = color.toHsiColor();
      expect(color.equals(hsiColor), equals(true));
    });
  });

  test('HSL Conversions', () {
    _testColors.forEach((ColorModel color) {
      final HslColor hslColor = color.toHslColor();
      expect(color.equals(hslColor), equals(true));
    });
  });

  test('HSP Conversions', () {
    _testColors.forEach((ColorModel color) {
      final HspColor hspColor = color.toHspColor();
      expect(color.equals(hspColor), equals(true));
    });
  });

  test('HSV Conversions', () {
    _testColors.forEach((ColorModel color) {
      final HsvColor hsvColor = color.toHsvColor();
      expect(color.equals(hsvColor), equals(true));
    });
  });

  test('LAB Conversions', () {
    _testColors.forEach((ColorModel color) {
      final LabColor labColor = color.toLabColor();
      expect(color.equals(labColor), equals(true));
    });
  });

  test('XYZ Conversions', () {
    _testColors.forEach((ColorModel color) {
      final XyzColor xyzColor = color.toXyzColor();
      expect(color.equals(xyzColor), equals(true));
    });
  });

  test('Chained Conversions', () {
    _testColors.forEach((ColorModel color) {
      // Don't bother testing non-RGB colors here. Because
      // of a loss of precision when converting colors back
      // and forth between color spaces, they will never equal
      // the original color exactly without being rounded.
      if (color.runtimeType != RgbColor) return;

      ColorModel copy = color;

      final CmykColor cmykColor = CmykColor.from(copy);
      copy = cmykColor.toRgbColor();
      expect(copy, equals(color));

      final HsiColor hsiColor = HsiColor.from(copy);
      copy = hsiColor.toRgbColor();
      expect(copy, equals(color));

      final HslColor hslColor = HslColor.from(copy);
      copy = hslColor.toRgbColor();
      expect(copy, equals(color));

      final HspColor hspColor = HspColor.from(copy);
      copy = hspColor.toRgbColor();
      expect(copy, equals(color));

      final HsvColor hsvColor = HsvColor.from(copy);
      copy = hsvColor.toRgbColor();
      expect(copy, equals(color));

      final LabColor labColor = LabColor.from(copy);
      copy = labColor.toRgbColor();
      expect(copy, equals(color));

      final XyzColor xyzColor = XyzColor.from(copy);
      copy = xyzColor.toRgbColor();
      expect(copy, equals(color));
    });
  });
}
