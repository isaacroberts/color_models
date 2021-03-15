import 'package:meta/meta.dart';
import '../color_model.dart';
import '../helpers/color_adjustments.dart';
import '../helpers/color_converter.dart';
import '../helpers/color_math.dart';

/// {@template color_models.HsiColor}
///
/// A color in the HSI color space.
///
/// The HSI color space contains channels for [hue],
/// [saturation], and [intensity].
///
/// {@endtemplate}
@immutable
class HsiColor extends ColorModel {
  /// {@template color_models.HsiColor.constructor}
  ///
  /// A color in the HSI color space.
  ///
  /// [hue] must be `>= 0` and `<= 360`.
  ///
  /// [saturation] and [intensity] must both be `>= 0` and `<= 100`.
  ///
  /// [alpha] must be `>= 0` and `<= 255`.
  ///
  /// {@endtemplate}
  const HsiColor(
    this.hue,
    this.saturation,
    this.intensity, [
    int alpha = 255,
  ])  : assert(hue >= 0 && hue <= 360),
        assert(saturation >= 0 && saturation <= 100),
        assert(intensity >= 0 && intensity <= 100),
        assert(alpha >= 0 && alpha <= 255),
        super(alpha: alpha);

  /// The hue value of this color.
  ///
  /// Ranges from `0` to `360`.
  @override
  final num hue;

  /// The saturation value of this color.
  ///
  /// Ranges from `0` to `100`.
  @override
  final num saturation;

  /// The intensity value of this color.
  ///
  /// Ranges from `0` to `100`.
  final num intensity;

  @override
  bool get isBlack => ColorMath.round(intensity) == 0;

  @override
  bool get isWhite =>
      ColorMath.round(saturation) == 0 && ColorMath.round(intensity) == 100;

  @override
  bool get isMonochromatic =>
      ColorMath.round(intensity) == 0 || ColorMath.round(saturation) == 0;

  @override
  HsiColor interpolate(ColorModel end, double step) {
    assert(step >= 0.0 && step <= 1.0);
    return super.interpolate(end, step) as HsiColor;
  }

  @override
  List<HsiColor> lerpTo(
    ColorModel color,
    int steps, {
    bool excludeOriginalColors = false,
  }) {
    assert(steps > 0);
    return super
        .lerpTo(color, steps, excludeOriginalColors: excludeOriginalColors)
        .cast<HsiColor>();
  }

  /// Adjusts this colors [hue] by `180` degrees while inverting the
  /// [saturation] and [intensity] values.
  @override
  HsiColor get inverted =>
      HsiColor((hue + 180) % 360, 100 - saturation, 100 - intensity, alpha);

  @override
  HsiColor get opposite => rotateHue(180);

  @override
  HsiColor rotateHue(num amount) => withHue((hue + amount) % 360);

  @override
  HsiColor warmer(num amount, {bool relative = true}) {
    assert(amount > 0);
    if (relative) assert(amount <= 100);
    return withHue(ColorAdjustments.warmerHue(hue, amount, relative: relative));
  }

  @override
  HsiColor cooler(num amount, {bool relative = true}) {
    assert(amount > 0);
    if (relative) assert(amount <= 100);
    return withHue(ColorAdjustments.coolerHue(hue, amount, relative: relative));
  }

  /// Returns this [HsiColor] modified with the provided [hue] value.
  @override
  HsiColor withHue(num hue) {
    assert(hue >= 0 && hue <= 360);
    return HsiColor(hue, saturation, intensity, alpha);
  }

  /// Returns this [HsiColor] modified with the provided [saturation] value.
  ///
  /// __NOTICE:__ [withSaturation] has been deprecated, use [copyWith] instead.
  @deprecated
  HsiColor withSaturation(num saturation) {
    assert(saturation >= 0 && saturation <= 100);
    return HsiColor(hue, saturation, intensity, alpha);
  }

  /// Returns this [HsiColor] modified with the provided [intensity] value.
  ///
  /// __NOTICE:__ [withIntensity] has been deprecated, use [copyWith] instead.
  @deprecated
  HsiColor withIntensity(num intensity) {
    assert(intensity >= 0 && intensity <= 100);
    return HsiColor(hue, saturation, intensity, alpha);
  }

  /// Returns this [HsiColor] modified with the provided [alpha] value.
  ///
  /// __NOTICE:__ [withAlpha] has been deprecated, use [copyWith] instead.
  @deprecated
  @override
  HsiColor withAlpha(int alpha) {
    assert(alpha >= 0 && alpha <= 255);
    return HsiColor(hue, saturation, intensity, alpha);
  }

  @override
  HsiColor withOpacity(double opacity) {
    assert(opacity >= 0.0 && opacity <= 1.0);
    return copyWith(alpha: (opacity * 255).round());
  }

  @override
  HsiColor withValues(List<num> values) {
    assert(values.length == 3 || values.length == 4);
    assert(values[0] >= 0 && values[0] <= 360);
    assert(values[1] >= 0 && values[1] <= 100);
    assert(values[2] >= 0 && values[2] <= 100);
    if (values.length == 4) assert(values[3] >= 0 && values[3] <= 255);
    return HsiColor.fromList(values);
  }

  @override
  HsiColor copyWith({num? hue, num? saturation, num? intensity, int? alpha}) {
    assert(hue == null || (hue >= 0 && hue <= 360));
    assert(saturation == null || (saturation >= 0 && saturation <= 100));
    assert(intensity == null || (intensity >= 0 && intensity <= 100));
    assert(alpha == null || (alpha >= 0 && alpha <= 255));
    return HsiColor(
      hue ?? this.hue,
      saturation ?? this.saturation,
      intensity ?? this.intensity,
      alpha ?? this.alpha,
    );
  }

  @override
  RgbColor toRgbColor() => ColorConverter.hsiToRgb(this);

  @override
  HsiColor toHsiColor() => this;

  /// Returns a fixed-lenght list containing the [hue],
  /// [saturation], and [intensity] values, in that order.
  @override
  List<num> toList() =>
      List<num>.from(<num>[hue, saturation, intensity], growable: false);

  /// Returns a fixed-lenght list containing the [hue], [saturation],
  /// [intensity], and [alpha] values, in that order.
  @override
  List<num> toListWithAlpha() =>
      List<num>.from(<num>[hue, saturation, intensity, alpha], growable: false);

  /// Returns a fixed-length list containing the [hue], [saturation],
  /// and [intensity] values factored to be on 0 to 1 scale.
  List<double> toFactoredList() => List<double>.from(<double>[
        hue / 360,
        saturation / 100,
        intensity / 100,
      ], growable: false);

  /// Returns a fixed-length list containing the [hue], [saturation],
  /// [intensity], and [alpha] values factored to be on 0 to 1 scale.
  List<double> toFactoredListWithAlpha() => List<double>.from(<double>[
        hue / 360,
        saturation / 100,
        intensity / 100,
        alpha / 255,
      ], growable: false);

  /// Constructs a [HsiColor] from [color].
  factory HsiColor.from(ColorModel color) => color.toHsiColor();

  /// Constructs a [HsiColor] from a list of [hsi] values.
  ///
  /// [hsi] must not be null and must have exactly `3` or `4` values.
  ///
  /// The hue must be `>= 0` and `<= 360`.
  ///
  /// The saturation and intensity must both be `>= 0` and `<= 100`.
  ///
  /// The [alpha] value, if included, must be `>= 0 && <= 255`.
  factory HsiColor.fromList(List<num> values) {
    assert(values.length == 3 || values.length == 4);
    assert(values[0] >= 0 && values[0] <= 360);
    assert(values[1] >= 0 && values[1] <= 100);
    assert(values[2] >= 0 && values[2] <= 100);
    if (values.length == 4) assert(values[3] >= 0 && values[3] <= 255);
    final alpha = values.length == 4 ? values[3].round() : 255;
    return HsiColor(values[0], values[1], values[2], alpha);
  }

  /// Constructs a [HsiColor] from a RGB [hex] color.
  ///
  /// [hex] is case-insensitive and must be `3` or `6` characters
  /// in length, excluding an optional leading `#`.
  factory HsiColor.fromHex(String hex) =>
      ColorConverter.hexToRgb(hex).toHsiColor();

  /// Constructs a [HsiColor] from a list of [hsi] values on a `0` to `1` scale.
  ///
  /// [hsi] must not be null and must have exactly `3` or `4` values.
  ///
  /// Each of the values must be `>= 0` and `<= 1`.
  factory HsiColor.extrapolate(List<double> values) {
    assert(values.length == 3 || values.length == 4);
    assert(values[0] >= 0 && values[0] <= 1);
    assert(values[1] >= 0 && values[1] <= 1);
    assert(values[2] >= 0 && values[2] <= 1);
    if (values.length == 4) assert(values[3] >= 0 && values[3] <= 1);
    final alpha = values.length == 4 ? (values[3] * 255).round() : 255;
    return HsiColor(values[0] * 360, values[1] * 100, values[2] * 100, alpha);
  }

  /// Generates a [HsiColor] at random.
  ///
  /// [minHue] and [maxHue] constrain the generated [hue] value. If
  /// `minHue < maxHue`, the range will run in a clockwise direction
  /// between the two, however if `minHue > maxHue`, the range will
  /// run in a counter-clockwise direction. Both [minHue] and [maxHue]
  /// must be `>= 0 && <= 360` and must not be `null`.
  ///
  /// [minSaturation] and [maxSaturation] constrain the generated [saturation]
  /// value.
  ///
  /// [minIntensity] and [maxIntensity] constrain the generated [intensity]
  /// value.
  ///
  /// Min and max values, besides hues, must be `min <= max && max >= min`,
  /// must be in the range of `>= 0 && <= 100`, and must not be `null`.
  factory HsiColor.random({
    num minHue = 0,
    num maxHue = 360,
    num minSaturation = 0,
    num maxSaturation = 100,
    num minIntensity = 0,
    num maxIntensity = 100,
  }) {
    assert(minHue >= 0 && minHue <= 360);
    assert(maxHue >= 0 && maxHue <= 360);
    assert(minSaturation >= 0 && minSaturation <= maxSaturation);
    assert(maxSaturation >= minSaturation && maxSaturation <= 100);
    assert(minIntensity >= 0 && minIntensity <= maxIntensity);
    assert(maxIntensity >= minIntensity && maxIntensity <= 100);
    return HsiColor(
      ColorMath.randomHue(minHue, maxHue),
      ColorMath.random(minSaturation, maxSaturation),
      ColorMath.random(minIntensity, maxIntensity),
    );
  }

  @override
  HsiColor convert(ColorModel other) => other.toHsiColor();

  @override
  String toString() => 'HsiColor($hue, $saturation, $intensity, $alpha)';

  @override
  bool operator ==(Object other) =>
      other is HsiColor &&
      ColorMath.round(hue) == ColorMath.round(other.hue) &&
      ColorMath.round(saturation) == ColorMath.round(other.saturation) &&
      ColorMath.round(intensity) == ColorMath.round(other.intensity) &&
      alpha == other.alpha;

  @override
  int get hashCode =>
      hue.hashCode ^ saturation.hashCode ^ intensity.hashCode ^ alpha.hashCode;
}
