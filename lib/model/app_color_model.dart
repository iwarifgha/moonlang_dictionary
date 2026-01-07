import 'package:flutter/material.dart';

class AppColorModel extends ThemeExtension<AppColorModel> {
  final Color kColorPrimary;
  final Color kColorWhiteAndBlack;
  final Color kcColorBlack;
  final Color kColorRedAccent;
  final Color kColorStrokeColor;
  final Color kColorGrey;
  final Color kkColorGrey2;
  final Color kColorGrey3;
  final Color kColorBlack2;
  AppColorModel({
    required this.kColorPrimary,
    required this.kColorWhiteAndBlack,
    required this.kcColorBlack,
    required this.kColorRedAccent,
    required this.kColorStrokeColor,
    required this.kColorGrey,
    required this.kkColorGrey2,
    required this.kColorGrey3,
    required this.kColorBlack2,
  });
  @override
  ThemeExtension<AppColorModel> copyWith() {
    Color? kColorPrimary;
    Color? kColorWhite;
    Color? kcColorBlack;
    Color? kColorRedAccent;
    Color? kColorStrokeColor;
    Color? kColorGrey;
    Color? kkColorGrey2;
    Color? kColorGrey3;
    Color? kColorBlack2;
    return AppColorModel(
      kColorPrimary: kColorPrimary ?? this.kColorPrimary,
      kColorWhiteAndBlack: kColorWhite ?? this.kColorWhiteAndBlack,
      kcColorBlack: kcColorBlack ?? this.kcColorBlack,
      kColorRedAccent: kColorRedAccent ?? this.kColorRedAccent,
      kColorStrokeColor: kColorStrokeColor ?? this.kColorStrokeColor,
      kColorGrey: kColorGrey ?? this.kColorGrey,
      kkColorGrey2: kkColorGrey2 ?? this.kkColorGrey2,
      kColorGrey3: kColorGrey3 ?? this.kColorGrey3,
      kColorBlack2: kColorBlack2 ?? this.kColorBlack2,
    );
  }

  @override
  ThemeExtension<AppColorModel> lerp(
    covariant ThemeExtension<AppColorModel>? other,
    double t,
  ) {
    if (other is! AppColorModel) return this;
    return AppColorModel(
      kColorPrimary: Color.lerp(kColorPrimary, other.kColorPrimary, t)!,
      kColorWhiteAndBlack:
          Color.lerp(kColorWhiteAndBlack, other.kColorWhiteAndBlack, t)!,
      kcColorBlack: Color.lerp(kcColorBlack, other.kcColorBlack, t)!,
      kColorRedAccent: Color.lerp(kColorRedAccent, other.kColorRedAccent, t)!,
      kColorStrokeColor:
          Color.lerp(kColorStrokeColor, other.kColorStrokeColor, t)!,
      kColorGrey: Color.lerp(kColorGrey, other.kColorGrey, t)!,
      kkColorGrey2: Color.lerp(kkColorGrey2, other.kkColorGrey2, t)!,
      kColorGrey3: Color.lerp(kColorGrey3, other.kColorGrey3, t)!,
      kColorBlack2: Color.lerp(kColorBlack2, other.kColorBlack2, t)!,
    );
  }
}
