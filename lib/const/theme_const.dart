import 'package:flutter/material.dart';
import 'package:moonlang_dictionary/const/color_const.dart';
import 'package:moonlang_dictionary/model/app_color_model.dart';
 
class ThemeDataConstants {
  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    toggleButtonsTheme: ToggleButtonsThemeData(
      color: Colors.red,
      //kColorPrimary,
      selectedColor: Colors.amber,

      borderColor: kColorGrey,
    ),
    iconTheme: IconThemeData(size: 20, color: kColorWhite),
    extensions: [
      AppColorModel(
        kColorPrimary: kColorPrimary,
        kColorWhiteAndBlack: kColorWhite,
        kcColorBlack: kcColorBlack,
        kColorRedAccent: kColorRedAccent,
        kColorStrokeColor: kColorStrokeColor,
        kColorGrey: kColorGrey,
        kkColorGrey2: kkColorGrey2,
        kColorGrey3: kColorGrey3,
        kColorBlack2: kColorBlack2,
      ),
    ],
    // primaryColor: kColorPrimary,
    scaffoldBackgroundColor: Colors.black,
    // textTheme: TextTheme(
    //   bodyLarge: kStyleWhiteBodyLarge,
    //   bodySmall: kStyleWhiteBodySmall,
    //   bodyMedium: kStyleWhiteBodyMedium,
    //   titleLarge: kStyleWhiteTitleLarge,
    //   titleMedium: kStyleWhiteTitleMedium,
    //   titleSmall: kStyleWhiteTitleSmall
    // )
    //elevatedButtonTheme:
  );

  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    toggleButtonsTheme: ToggleButtonsThemeData(
      color: kColorWhite,
      selectedColor: kColorPrimary,
      borderColor: kColorStrokeColor,
    ),
    iconTheme: IconThemeData(size: 20, color: kColorPrimary),
    extensions: [
      AppColorModel(
        kColorPrimary: kColorPrimary,
        kColorWhiteAndBlack: kcColorBlack,
        kcColorBlack: kColorWhite,
        kColorRedAccent: kColorRedAccent,
        kColorStrokeColor: kColorStrokeColor,
        kColorGrey: kColorGrey,
        kkColorGrey2: kkColorGrey2,
        kColorGrey3: kColorGrey3,
        kColorBlack2: kColorBlack2,
      ),
    ],
    primaryColor: kColorWhite,
    scaffoldBackgroundColor: kColorWhite,
    // fontFamily: GoogleFonts.nunitoSans().fontFamily,
    // textTheme: TextTheme(
    //   bodyLarge: kStyleBlackBodyLarge,
    //   bodySmall: kStyleBlackBodySmall,
    //   bodyMedium: kStyleBlackBodyMedium,
    //   titleLarge: kStyleBlackTitleLarge,
    //   titleMedium: kStyleBlackTitleMedium,
    //   titleSmall: kStyleBlackTitleSmall,
    // ),
    //
  );

  static ThemeData getTheme(BuildContext context) {
    return Theme.of(context);
  }
}
