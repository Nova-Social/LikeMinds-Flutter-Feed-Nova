import 'package:flutter/material.dart';

class ColorTheme {
  static const backgroundColor = Color.fromRGBO(24, 23, 25, 1);
  static const primaryColor = Color.fromRGBO(180, 134, 255, 1);
  static const darkBlack300 = Color.fromRGBO(49, 49, 50, 1);
  static const lightWhite300 = Color.fromRGBO(241, 241, 241, 0.694);
  static const white = Color.fromRGBO(255, 255, 255, 1);
  static const white400 = Color.fromRGBO(241, 241, 241, 0.498);
  static const redColor = Color.fromRGBO(255, 73, 90, 1);

  static final novaTheme = ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      background: ColorTheme.backgroundColor,
      onBackground: ColorTheme.darkBlack300,
      seedColor: ColorTheme.primaryColor,
      primary: ColorTheme.primaryColor,
      onSecondary: kSecondaryColor700,
      onPrimary: ColorTheme.lightWhite300,
      error: ColorTheme.redColor,
      onPrimaryContainer: ColorTheme.white,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 16,
        color: ColorTheme.white,
        fontWeight: FontWeight.w700,
        fontFamily: 'Gantari',
        height: 0,
      ),
      titleMedium: TextStyle(
        fontSize: 14,
        color: ColorTheme.white,
        fontFamily: 'Gantari',
        fontWeight: FontWeight.w700,
        height: 0,
      ),
      titleSmall: TextStyle(
        fontSize: 12,
        color: ColorTheme.white,
        fontWeight: FontWeight.w700,
        fontFamily: 'Gantari',
        height: 0,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        color: ColorTheme.lightWhite300,
        fontFamily: 'Gantari',
        fontWeight: FontWeight.w500,
        height: 0,
      ),
      labelMedium: TextStyle(
        fontSize: 14,
        color: ColorTheme.lightWhite300,
        fontWeight: FontWeight.w500,
        fontFamily: 'Gantari',
        height: 0,
      ),
      labelSmall: TextStyle(
        fontSize: 12,
        color: ColorTheme.lightWhite300,
        fontWeight: FontWeight.w500,
        fontFamily: 'Gantari',
        height: 0,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: ColorTheme.white,
        fontFamily: 'Gantari',
        fontWeight: FontWeight.w400,
        height: 0.09,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: ColorTheme.white,
        fontWeight: FontWeight.w400,
        fontFamily: 'Gantari',
        height: 0.09,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: ColorTheme.white,
        fontWeight: FontWeight.w400,
        fontFamily: 'Gantari',
        height: 0.09,
      ),
      displayLarge: TextStyle(
        fontSize: 16,
        color: ColorTheme.lightWhite300,
        fontWeight: FontWeight.w400,
        fontFamily: 'Gantari',
        height: 0.09,
      ),
      displayMedium: TextStyle(
        fontSize: 14,
        color: ColorTheme.lightWhite300,
        fontWeight: FontWeight.w400,
        fontFamily: 'Gantari',
        height: 0.09,
      ),
      displaySmall: TextStyle(
        fontSize: 12,
        color: ColorTheme.lightWhite300,
        fontWeight: FontWeight.w400,
        fontFamily: 'Gantari',
        height: 0.09,
      ),
    ),
  );
}

const Color kPrimaryColor = Color(0xFF3B82F6);
const Color primary500 = Color(0xFF4666F6);
const Color kHeadingBlackColor = Color(0xFF0F172A);
const Color kPrimaryColorLight = Color(0xFFDBEAFE);
const Color kSecondary100 = Color(0xFFF1F5F9);
const Color kSecondaryColor700 = Color(0xFF334155);
const Color kSecondaryColorLight = Color(0xFFEDF0FE);
const Color onSurface = Color(0xFFE2E8F0);
const Color onSurface500 = Color(0xFF64748B);
const Color kBackgroundColor = Color(0xffF5F5F5);
const Color kWhiteColor = Color(0xffFFFFFF);
const Color appBlack = Color(0xFF334155);
const Color appSecondaryBlack = Color(0xFF94A3B8);
const Color kGreyColor = Color(0xff666666);
const Color kGrey1Color = Color(0xff222020);
const Color kGrey2Color = Color(0xff504B4B);
const Color kGrey3Color = Color(0xff9B9B9B);
const Color kGreyWebBGColor = Color(0xffE6EBF5);
const Color kGreyBGColor = Color(0x66D0D8E2);
const Color kBlueGreyColor = Color(0xFF484F67);
const Color kLinkColor = Color(0xff007AFF);
const Color kHeadingColor = Color(0xff333149);
const Color kBorderColor = Color(0x7ED0D8E2);
const Color notificationRedColor = Color(0x66D0D8E2);

const double kFontSmall = 12;
const double kButtonFontSize = 12;
const double kFontXSmall = 11;
const double kFontSmallMed = 14;
const double kFontMedium = 16;
const double kPaddingXSmall = 2;
const double kPaddingSmall = 4;
const double kPaddingMedium = 8;
const double kPaddingLarge = 16;
const double kPaddingXLarge = 20;
const double kBorderRadiusXSmall = 2;
const double kBorderRadiusMedium = 8;
const SizedBox kHorizontalPaddingXLarge = SizedBox(width: kPaddingXLarge);
const SizedBox kHorizontalPaddingSmall = SizedBox(width: kPaddingSmall);
const SizedBox kHorizontalPaddingXSmall = SizedBox(width: kPaddingXSmall);
const SizedBox kHorizontalPaddingLarge = SizedBox(width: kPaddingLarge);
const SizedBox kHorizontalPaddingMedium = SizedBox(width: kPaddingMedium);
const SizedBox kVerticalPaddingXLarge = SizedBox(height: kPaddingXLarge);
const SizedBox kVerticalPaddingSmall = SizedBox(height: kPaddingSmall);
const SizedBox kVerticalPaddingXSmall = SizedBox(height: kPaddingXSmall);
const SizedBox kVerticalPaddingLarge = SizedBox(height: kPaddingLarge);
const SizedBox kVerticalPaddingMedium = SizedBox(height: kPaddingMedium);
