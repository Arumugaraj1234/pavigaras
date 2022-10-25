import 'package:flutter/material.dart';
import 'package:pavigaras/app/app.dart';
import 'package:pavigaras/app/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(MyApp());
}
