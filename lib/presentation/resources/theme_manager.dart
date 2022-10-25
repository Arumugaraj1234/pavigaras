import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pavigaras/presentation/resources/colors_manager.dart';
import 'package:pavigaras/presentation/resources/styles_manager.dart';
import 'package:pavigaras/presentation/resources/values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // Main Colors of the app
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryOpacity70,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.darkGrey,

    // Ripple Color
    splashColor: ColorManager.primaryOpacity70,

    // Card View Theme
    cardTheme: CardTheme(
        color: ColorManager.white,
        shadowColor: ColorManager.grey,
        elevation: AppSize.s4),

    // Appbar Theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.darkPrimary,
      elevation: AppSize.s4,
      shadowColor: ColorManager.primaryOpacity70,
      titleTextStyle: getMediumStyle(color: ColorManager.white),
    ),

    // Button Theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.darkGrey,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.primaryOpacity70,
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getMediumStyle(color: ColorManager.white),
        primary: ColorManager.darkPrimary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s12)),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
          textStyle: getMediumStyle(color: ColorManager.primary),
          primary: ColorManager.primary),
    ),

    // Text Theme
    textTheme: TextTheme(subtitle1: getRegularStyle()),

    // Text Field Theme
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle: getRegularStyle(color: ColorManager.grey1),
      labelStyle: getRegularStyle(color: ColorManager.darkPrimary),
      errorStyle: getRegularStyle(color: ColorManager.error),

      // Text Field Border Theme
      enabledBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.darkPrimary, width: AppSize.s4),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

      focusedBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.darkPrimary, width: AppSize.s4),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

      errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ColorManager.error, width: AppSize.s4),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

      focusedErrorBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.darkPrimary, width: AppSize.s4),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
    ),
  );
}
