import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/src/view/tasks/task_list_page.dart';
import 'package:task_manager/src/view_model/theme_provider.dart';

class TaskManagementApp extends ConsumerWidget {
  const TaskManagementApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    return MaterialApp(
      title: 'Task Management App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      home: TaskListPage(),
    );
  }
}
