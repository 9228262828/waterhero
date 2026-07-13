import 'package:flutter/material.dart';
import 'app.dart';
import 'data/local_storage.dart';
import 'state/app_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = LocalStorage();
  await storage.init();
  final controller = AppController(storage);
  await controller.load();
  runApp(WaterHeroApp(controller: controller));
}
