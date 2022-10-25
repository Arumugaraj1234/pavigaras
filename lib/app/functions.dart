import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class AppFunctions {
  static Future<bool> willPopCallback() async {
    return false;
  }

  static void displayWarningMotionToast(
      {String title = "WARNING",
      required String message,
      required BuildContext context}) {
    MotionToast.warning(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text(message),
      animationCurve: Curves.bounceIn,
      borderRadius: 0,
      animationDuration: const Duration(milliseconds: 1000),
    ).show(context);
  }

  static void displayTopMotionToast(
      {String title = "WARNING",
      required Color color,
      required String message,
      required BuildContext context}) {
    MotionToast(
      icon: Icons.zoom_out,
      primaryColor: color,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text(message),
      position: MotionToastPosition.top,
      animationType: AnimationType.fromTop,
      height: 100,
    ).show(context);
  }
}
