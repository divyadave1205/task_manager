import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Hive
  final appDir = await getApplicationDocumentsDirectory();
  Hive.init(appDir.path);
  runApp(ProviderScope(child: TaskManagementApp()));
}
