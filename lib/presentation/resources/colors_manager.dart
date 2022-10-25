import 'package:flutter/cupertino.dart';

class ColorManager {
  static Color primary = HexColor.fromHex("#189AB4");
  static Color darkPrimary = HexColor.fromHex("#05445E");
  static Color primaryOpacity70 = HexColor.fromHex("#B3189AB4");
  static Color blueGreen = HexColor.fromHex("#75E6DA");
  static Color babyBlue = HexColor.fromHex("#D4F1F4");

  // Other Colors
  static Color grey = HexColor.fromHex("#737477");
  static Color grey1 = HexColor.fromHex("#707070");
  static Color grey2 = HexColor.fromHex("#797979");
  static Color lightGrey = HexColor.fromHex("#9E9E9E");
  static Color darkGrey = HexColor.fromHex("#525252");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color error = HexColor.fromHex("#e61f34");
  static Color black = HexColor.fromHex("#000000");
  static Color green = HexColor.fromHex("#228B22");
}

extension HexColor on Color {
  static Color fromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}
