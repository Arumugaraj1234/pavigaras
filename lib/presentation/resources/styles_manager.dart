import 'package:flutter/material.dart';
import 'package:pavigaras/presentation/resources/font_manager.dart';

TextStyle _getTextStyle(
    double fontSize, String fontFamily, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      color: color);
}

TextStyle getLightStyle(
    {double fontSize = FontSize.f16, Color color = Colors.black}) {
  return _getTextStyle(
      fontSize, FontFamilyManager.circularStd, FontWeightManager.light, color);
}

TextStyle getRegularStyle(
    {double fontSize = FontSize.f18, Color color = Colors.black}) {
  return _getTextStyle(fontSize, FontFamilyManager.circularStd,
      FontWeightManager.regular, color);
}

TextStyle getMediumStyle(
    {double fontSize = FontSize.f20, Color color = Colors.black}) {
  return _getTextStyle(
      fontSize, FontFamilyManager.circularStd, FontWeightManager.medium, color);
}

TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.f22, Color color = Colors.black}) {
  return _getTextStyle(fontSize, FontFamilyManager.circularStd,
      FontWeightManager.semiBold, color);
}

TextStyle getBoldStyle(
    {double fontSize = FontSize.f24, Color color = Colors.black}) {
  return _getTextStyle(
      fontSize, FontFamilyManager.circularStd, FontWeightManager.bold, color);
}
