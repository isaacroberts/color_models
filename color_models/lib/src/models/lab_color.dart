import 'package:meta/meta.dart';
import '../color_model.dart';
import '../helpers/color_adjustments.dart';
import '../helpers/color_converter.dart';
import '../helpers/color_math.dart';

/// {@template color_models.LabColor}
///
/// A color in the CIELAB color space.
///
/// The CIELAB color space contains channels for [lightness],
/// [a] (red and green opponent values), and [b] (blue and
/// yellow opponent values.)
///
/// {@endtemplate}
@immutable
class LabColor extends ColorModel {
  /// {@template color_models.LabColor.constructor}
  ///
  /// A color in the CIELAB color space.
  ///
  /// [lightness] must be `>= 0` and `<= 100`.
  ///
  /// [a] and [b] must both be `>= -128` and `<= 127`.
  ///
  /// [alpha] must be `>= 0` and `<= 255`.
  ///
  /// {@endtemplate}
  const LabColor(
    this.lightness,
    this.a,
    this.b, [
    int alpha = 255,
  ])  : assert(lightness >= 0 && lightness <= 100),
        assert(a >= -128 && a <= 127),
        assert(b >= -128 && b <= 127),
        assert(alpha >= 0 && alpha <= 255),
        super(alpha: alpha);

  /// Lightness represents the black to white value.
  ///
  /// The value ranges from black at `0` to white at `100`.
  final num lightness;

  /// The red to green opponent color value.
  ///
  /// Green is represented in the negative value range (`-128` to `0`)
  ///
  /// Red is represented in the positive value range (`0` to `127`)
  final num a;

  /// The yellow to blue opponent color value.
  ///
  /// Yellow is represented int he negative value range (`-128` to `0`)
  ///
  /// Blue is represented in the positive value range (`0` to `127`)
  final num b;

  @override
  bool get isBlack =>
      ColorMath.round(lightness) == 0 &&
      ColorMath.round(a) == 0 &&
      ColorMath.round(b) == 0;

  @override
  bool get isWhite =>
      ColorMath.round(lightness) == 1 &&
      ColorMath.round(a) == 0 &&
      ColorMath.round(b) == 0;

  @override
  bool get isMonochromatic =>
      ColorMath.round(a) == 0 && ColorMath.round(b) == 0;

  @override
  LabColor interpolate(ColorModel end, double step) {
    assert(step >= 0.0 && step <= 1.0);
    return super.interpolate(end, step) as LabColor;
  }

  @override
  List<LabColor> lerpTo(
    ColorModel color,
    int steps, {
    bool excludeOriginalColors = false,
  }) {
    assert(steps > 0);
    return super
        .lerpTo(color, steps, excludeOriginalColors: excludeOriginalColors)
        .cast<LabColor>();
  }

  @override
  LabColor get inverted => LabColor(
      100 - lightness, 255 - (a + 128) - 128, 255 - (b + 128) - 128, alpha);

  @override
  LabColor get opposite => rotateHue(180);

  @override
  LabColor rotateHue(num amount) =>
      ColorAdjustments.rotateHue(this, amount).toLabColor();

  @override
  LabColor warmer(num amount, {bool relative = true}) {
    assert(amount > 0);
    return ColorAdjustments.warmer(this, amount, relative: relative)
        .toLabColor();
  }

  @override
  LabColor cooler(num amount, {bool relative = true}) {
    assert(amount > 0);
    return ColorAdjustments.cooler(this, amount, relative: relative)
        .toLabColor();
  }

  /// Returns this [LabColor] modified with the provided [hue] value.
  @override
  LabColor withHue(num hue) {
    assert(hue >= 0 && hue <= 360);
    final hslColor = toHslColor();
    return hslColor.withHue((hslColor.hue + hue) % 360).toLabColor();
  }

  /// Returns this [LabColor] modified with the provided [lightness] value.
  ///
  /// __NOTICE:__ [withLightness] has been deprecated, use [copyWith] instead.
  @deprecated
  LabColor withLightness(num lightness) {
    assert(lightness >= 0 && lightness <= 100);
    return LabColor(lightness, a, b, alpha);
  }

  /// Returns this [LabColor] modified with the provided [a] value.
  ///
  /// __NOTICE:__ [withA] has been deprecated, use [copyWith] instead.
  @deprecated
  LabColor withA(num a) {
    assert(a >= -128 && a <= 127);
    return LabColor(lightness, a, b, alpha);
  }

  /// Returns this [LabColor] modified with the provided [b] value.
  ///
  /// __NOTICE:__ [withB] has been deprecated, use [copyWith] instead.
  @deprecated
  LabColor withB(num b) {
    assert(b >= -128 && b <= 127);
    return LabColor(lightness, a, b, alpha);
  }

  /// Returns this [LabColor] modified with the provided [alpha] value.
  ///
  /// __NOTICE:__ [withAlpha] has been deprecated, use [copyWith] instead.
  @deprecated
  @override
  LabColor withAlpha(int alpha) {
    assert(alpha >= 0 && alpha <= 255);
    return LabColor(lightness, a, b, alpha);
  }

  @override
  LabColor withOpacity(double opacity) {
    assert(opacity >= 0.0 && opacity <= 1.0);
    return copyWith(alpha: (opacity * 255).round());
  }

  @override
  LabColor withValues(List<num> values) {
    assert(values.length == 3 || values.length == 4);
    assert(values[0] >= 0 && values[0] <= 100);
    assert(values[1] >= -128 && values[1] <= 127);
    assert(values[2] >= -128 && values[2] <= 127);
    if (values.length == 4) assert(values[3] >= 0 && values[3] <= 255);
    return LabColor.fromList(values);
  }

  @override
  LabColor copyWith({num? lightness, num? a, num? b, int? alpha}) {
    assert(lightness == null || (lightness >= 0 && lightness <= 100));
    assert(a == null || (a >= -128 && a <= 127));
    assert(b == null || (b >= -128 && b <= 127));
    assert(alpha == null || (alpha >= 0 && alpha <= 255));
    return LabColor(
      lightness ?? this.lightness,
      a ?? this.a,
      b ?? this.b,
      alpha ?? this.alpha,
    );
  }

  @override
  RgbColor toRgbColor() => ColorConverter.labToRgb(this);

  @override
  LabColor toLabColor() => this;

  @override
  XyzColor toXyzColor() => ColorConverter.labToXyz(this);

  /// Returns a fixed-lenght list containing the [lightness],
  /// [a], and [b] values, in that order.
  @override
  List<num> toList() => List<num>.from(<num>[lightness, a, b], growable: false);

  /// Returns a fixed-lenght list containing the [lightness],
  /// [a], [b], and [alpha] values, in that order.
  @override
  List<num> toListWithAlpha() =>
      List<num>.from(<num>[lightness, a, b, alpha], growable: false);

  /// Constructs a [LabColor] from [color].
  factory LabColor.from(ColorModel color) => color.toLabColor();

  /// Constructs a [LabColor] from a list of [lab] values.
  ///
  /// [lab] must have exactly `3` or `4` values.
  ///
  /// The first value (L) must be `>= 0 && <= 100`.
  ///
  /// The A and B values must be `>= -128 && <= 127`.
  ///
  /// The [alpha] value, if included, must be `>= 0 && <= 255`.
  factory LabColor.fromList(List<num> values) {
    assert(values.length == 3 || values.length == 4);
    assert(values[0] >= 0 && values[0] <= 100);
    assert(values[1] >= -128 && values[1] <= 127);
    assert(values[2] >= -128 && values[2] <= 127);
    if (values.length == 4) assert(values[3] >= 0 && values[3] <= 255);
    final alpha = values.length == 4 ? values[3].round() : 255;
    return LabColor(values[0], values[1], values[2], alpha);
  }

  /// Constructs a [LabColor] from a RGB [hex] color.
  ///
  /// [hex] is case-insensitive and must be `3` or `6` characters
  /// in length, excluding an optional leading `#`.
  factory LabColor.fromHex(String hex) =>
      ColorConverter.hexToRgb(hex).toLabColor();

  /// Constructs a [LabColor] from a list of [lab] values on a `0` to `1` scale.
  ///
  /// [lab] must not be null and must have exactly `3` or `4` values.
  ///
  /// Each of the values must be `>= 0` and `<= 1`.
  factory LabColor.extrapolate(List<double> values) {
    assert(values.length == 3 || values.length == 4);
    assert(values[0] >= 0 && values[0] <= 1);
    assert(values[1] >= 0 && values[1] <= 1);
    assert(values[2] >= 0 && values[2] <= 1);
    if (values.length == 4) assert(values[3] >= 0 && values[3] <= 1);
    final alpha = values.length == 4 ? (values[3] * 255).round() : 255;
    return LabColor(values[0] * 100, (values[1] * 255) - 128,
        (values[2] * 255) - 128, alpha);
  }

  /// Generates a [LabColor] at random.
  ///
  /// [minLightness] and [maxLightness] constrain the generated [lightness]
  /// value.
  ///
  /// [minA] and [maxA] constrain the generated [a] value.
  ///
  /// [minB] and [maxB] constrain the generated [b] value.
  ///
  /// All min and max values must be `min <= max && max >= min`, must
  /// be in the range of `>= 0 && <= 100`, and must not be `null`.
  factory LabColor.random({
    num minLightness = 0,
    num maxLightness = 100,
    num minA = 0,
    num maxA = 100,
    num minB = 0,
    num maxB = 100,
  }) {
    assert(minLightness >= 0 && minLightness <= maxLightness);
    assert(maxLightness >= minLightness && maxLightness <= 100);
    assert(minA >= 0 && minA <= maxA);
    assert(maxA >= minA && maxA <= 100);
    assert(minB >= 0 && minB <= maxB);
    assert(maxB >= minB && maxB <= 100);
    return LabColor(
      ColorMath.random(minLightness, maxLightness),
      ColorMath.random(minA, maxA),
      ColorMath.random(minB, maxB),
    );
  }

  @override
  LabColor convert(ColorModel other) => other.toLabColor();

  @override
  String toString() => 'LabColor($lightness, $a, $b, $alpha)';

  @override
  bool operator ==(Object other) =>
      other is LabColor &&
      ColorMath.round(lightness) == ColorMath.round(other.lightness) &&
      ColorMath.round(a) == ColorMath.round(other.a) &&
      ColorMath.round(b) == ColorMath.round(other.b) &&
      alpha == other.alpha;

  @override
  int get hashCode =>
      lightness.hashCode ^ a.hashCode ^ b.hashCode ^ alpha.hashCode;
}
