import 'package:color_models/color_models.dart' as cm;
import '../../color_model.dart';

/// Mixes in methods to convert a color to any other color model.
mixin CastToColor on cm.ColorModel {
  @override
  bool equals(cm.ColorModel color) =>
      RgbColor.from(this) == RgbColor.from(color);

  /// Converts `this` to the CMYK color space.
  @override
  CmykColor toCmykColor() => _cast().toCmykColor().cast();

  /// Converts `this` to the HSV color space.
  @override
  HsbColor toHsbColor() => _cast().toHsbColor().cast();

  /// Converts `this` to the HSI color space.
  @override
  HsiColor toHsiColor() => _cast().toHsiColor().cast();

  /// Converts `this` to the HSL color space.
  @override
  HslColor toHslColor() => _cast().toHslColor().cast();

  /// Converts `this` to the HSP color space.
  @override
  HspColor toHspColor() => _cast().toHspColor().cast();

  /// Converts `this` to the LAB color space.
  @override
  LabColor toLabColor() => _cast().toLabColor().cast();

  @override
  OklabColor toOklabColor() => _cast().toOklabColor().cast();

  /// Converts `this` to the RGB color space.
  @override
  RgbColor toRgbColor() => _cast().toRgbColor().cast();

  /// Converts `this` to the XYZ color space.
  @override
  XyzColor toXyzColor() => _cast().toXyzColor().cast();

  cm.ColorModel _cast() {
    if (this is ColorModel) {
      late cm.ColorModel colorModel;
      switch (runtimeType) {
        case CmykColor:
          colorModel = cm.CmykColor.fromList(toListWithAlpha());
          break;
        case HsbColor:
          colorModel = cm.HsbColor.fromList(toListWithAlpha());
          break;
        case HsiColor:
          colorModel = cm.HsiColor.fromList(toListWithAlpha());
          break;
        case HslColor:
          colorModel = cm.HslColor.fromList(toListWithAlpha());
          break;
        case HspColor:
          colorModel = cm.HspColor.fromList(toListWithAlpha());
          break;
        case LabColor:
          colorModel = cm.LabColor.fromList(toListWithAlpha());
          break;
        case OklabColor:
          colorModel = cm.OklabColor.fromList(toListWithAlpha());
          break;
        case RgbColor:
          colorModel =
              cm.RgbColor.fromList((this as RgbColor).toPreciseListWithAlpha());
          break;
        case XyzColor:
          colorModel = cm.XyzColor.fromList(toListWithAlpha());
          break;
      }
      return colorModel;
    }
    return this;
  }
}

extension CastToCmykColor on cm.CmykColor {
  /// Casts a [CmykColor] from the `color_models` package to a
  /// [CmykColor] from the `flutter_color_models` package.
  CmykColor cast() => CmykColor(cyan, magenta, yellow, black, alpha);
}

extension CastFromCmykColor on CmykColor {
  /// Casts a [CmykColor] from the `flutter_color_models` package
  /// to a [CmykColor] from the `color_models` package.
  cm.CmykColor cast() => cm.CmykColor(cyan, magenta, yellow, black, alpha);
}

extension CastToHsbColor on cm.HsbColor {
  /// Casts a [HsbColor] from the `color_models` package to a
  /// [HsbColor] from the `flutter_color_models` package.
  HsbColor cast() => HsbColor(hue, saturation, brightness, alpha);
}

extension CastFromHsbColor on HsbColor {
  /// Casts a [HsbColor] from the `flutter_color_models` package
  /// to a [HsbColor] from the `color_models` package.
  cm.HsbColor cast() => cm.HsbColor(hue, saturation, brightness, alpha);
}

extension CastToHsiColor on cm.HsiColor {
  /// Casts a [HsiColor] from the `color_models` package to a
  /// [HsiColor] from the `flutter_color_models` package.
  HsiColor cast() => HsiColor(hue, saturation, intensity, alpha);
}

extension CastFromHsiColor on HsiColor {
  /// Casts a [HsiColor] from the `color_models` package to a
  /// [HsiColor] from the `flutter_color_models` package.
  cm.HsiColor cast() => cm.HsiColor(hue, saturation, intensity, alpha);
}

extension CastToHslColor on cm.HslColor {
  /// Casts a [HslColor] from the `color_models` package to a
  /// [HslColor] from the `flutter_color_models` package.
  HslColor cast() => HslColor(hue, saturation, lightness, alpha);
}

extension CastFromHslColor on HslColor {
  /// Casts a [HslColor] from the `color_models` package to a
  /// [HslColor] from the `flutter_color_models` package.
  cm.HslColor cast() => cm.HslColor(hue, saturation, lightness, alpha);
}

extension CastToHspColor on cm.HspColor {
  /// Casts a [HspColor] from the `color_models` package to a
  /// [HspColor] from the `flutter_color_models` package.
  HspColor cast() => HspColor(hue, saturation, perceivedBrightness, alpha);
}

extension CastFromHspColor on HspColor {
  /// Casts a [HspColor] from the `color_models` package to a
  /// [HspColor] from the `flutter_color_models` package.
  cm.HspColor cast() =>
      cm.HspColor(hue, saturation, perceivedBrightness, alpha);
}

extension CastToLabColor on cm.LabColor {
  /// Casts a [LabColor] from the `color_models` package to a
  /// [LabColor] from the `flutter_color_models` package.
  LabColor cast() => LabColor(lightness, a, b, alpha);
}

extension CastFromLabColor on LabColor {
  /// Casts a [LabColor] from the `color_models` package to a
  /// [LabColor] from the `flutter_color_models` package.
  cm.LabColor cast() => cm.LabColor(lightness, a, b, alpha);
}

extension CastToOklabColor on cm.OklabColor {
  /// Casts a [OklabColor] from the `color_models` package to a
  /// [OklabColor] from the `flutter_color_models` package.
  OklabColor cast() => OklabColor(lightness, a, b, alpha);
}

extension CastFromOklabColor on OklabColor {
  /// Casts a [OklabColor] from the `color_models` package to a
  /// [OklabColor] from the `flutter_color_models` package.
  cm.OklabColor cast() => cm.OklabColor(lightness, a, b, alpha);
}

extension CastToRgbColor on cm.RgbColor {
  /// Casts a [RgbColor] from the `color_models` package to a
  /// [RgbColor] from the `flutter_color_models` package.
  RgbColor cast() => RgbColor.fromList(toPreciseListWithAlpha());
}

extension CastFromRgbColor on RgbColor {
  /// Casts a [RgbColor] from the `color_models` package to a
  /// [RgbColor] from the `flutter_color_models` package.
  cm.RgbColor cast() => cm.RgbColor.fromList(toPreciseListWithAlpha());
}

extension CastToXyzColor on cm.XyzColor {
  /// Casts a [XyzColor] from the `color_models` package to a
  /// [XyzColor] from the `flutter_color_models` package.
  XyzColor cast() => XyzColor(x, y, z, alpha);
}

extension CastFromXyzColor on XyzColor {
  /// Casts a [XyzColor] from the `color_models` package to a
  /// [XyzColor] from the `flutter_color_models` package.
  cm.XyzColor cast() => cm.XyzColor(x, y, z, alpha);
}
